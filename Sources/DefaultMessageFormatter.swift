// Copyright 2015 the original author or authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import Foundation

/// The default implementation of `MessageFormatter`.  This implementation inspects the configured `Logger` `format` and replaces the following values:
///
/// * `%column`: The column the message was generated at
/// * `%date{<FORMAT>}`: The date the message was generated on.  The format of the date is specified within the curly braces.
/// * `%file`: The file the message was generated in
/// * `%function`: The function the message was generated in
/// * `%level`: The level the message was logged at
/// * `%line`: The line the message was generated at
/// * `%message`: The logged message
/// * `%thread`: Whether the message was logged on the main or background thread
public final class DefaultMessageFormatter: MessageFormatter {

    private let dateFormatterPool: DateFormatterPool

    /// Creates a new instance of `DefaultMessageFormatter`
    ///
    /// - parameter dateFormatterPool: A pool of `NSDateFormatter`s.  This is used to improve the performance of writing log messages.
    public init(dateFormatterPool: DateFormatterPool = InMemoryDateFormatterPool()) {
        self.dateFormatterPool = dateFormatterPool
    }

    /// Formats the contents of a message.  Implementations can assume that if this method is called, the message _should_ be formatted.
    ///
    /// - parameter configuration:   The configuration of the `Logger` generating the message
    /// - parameter level:           The level that the message was generated at
    /// - parameter messagePosition: The position that the log message was generated at
    /// - parameter messageProvider: The `MessageProvider` to be evaluated
    public func format(configuration configuration: Configuration, level: Level, messagePosition: MessagePosition, @noescape messageProvider: MessageProvider) -> String {
        return configuration.format
            .replace("%column", with: messagePosition.column)
            .replace("%date\\{(.+?)\\}", with: dateFormatter())
            .replace("%file", with: messagePosition.file.basename())
            .replace("%function", with: messagePosition.function)
            .replace("%level", with: level.toLoggingString())
            .replace("%line", with: messagePosition.line)
            .replace("%message", with: messageProvider())
            .replace("%thread", with: thread())
            .replace("\n", with: " ")
    }

    private func dateFormatter() -> ReplacementGenerator {
        return { captures in self.dateFormatterPool.get(captures[1]).stringFromDate(NSDate()) }
    }

    private func thread() -> String {
        return NSThread.isMainThread() ? "Main" : "Background"
    }
}

// MARK: - Level Logging
extension Level {

    private func pad(value: String, size: Int) -> String {
        var padded = value
        while padded.characters.count < size { padded += " " }
        return padded
    }

    private func toLoggingString() -> String {
        return pad(self.toString().uppercaseString, size: 5)
    }
}

// MARK: - Pattern Replacement
public typealias ReplacementGenerator = [String] -> AnyObject

extension String {

    private func replace(pattern: String, @autoclosure with replacement: () -> AnyObject) -> String {
        return replace(pattern, with: { regex in replacement() })
    }

    private func replace(pattern: String, @noescape with replacement: ReplacementGenerator) -> String {
        let captures = self.matches(pattern)?.map { match -> [String] in
            return (0..<match.numberOfRanges).map { i -> String in
                let range = match.rangeAtIndex(i)
                return self[range.location..(range.location + range.length)]!
            }
            }.flatMap { $0 }

        if captures?.count > 0 {
            return self.stringByReplacingOccurrencesOfString(pattern, withString: "\(replacement(captures!))", options: .RegularExpressionSearch, range: nil)
        } else {
            return self
        }
    }
}
