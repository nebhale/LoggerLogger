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

extension String {

    private var length: Int { return count(self) }

    subscript(range: Range<Int>) -> String? {
        if range.startIndex < 0 || range.endIndex > self.length {
            return nil
        }

        let range = Range(start: advance(startIndex, range.startIndex), end: advance(startIndex, range.endIndex))

        return self[range]
    }

    func matches(pattern: String, ignoreCase: Bool = false) -> [NSTextCheckingResult]? {
        if let regex = regex(pattern, ignoreCase: ignoreCase) {
            return regex.matchesInString(self, options: nil, range: NSMakeRange(0, length)).map { $0 as! NSTextCheckingResult }
        }

        return nil
    }

}

infix operator =~ {}

func =~(string: String, pattern: String) -> Bool {
    if let regex = regex(pattern, ignoreCase: false) {
        let matches = regex.numberOfMatchesInString(string, options: nil, range: NSMakeRange(0, string.length))
        return matches > 0
    }

    return false
}

func =~(string: String, options: (pattern: String, ignoreCase: Bool)) -> Bool {
    if let matches = regex(options.pattern, ignoreCase: options.ignoreCase)?.numberOfMatchesInString(string, options: nil, range: NSMakeRange(0, string.length)) {
        return matches > 0
    }

    return false
}

private func regex(pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
    var options = NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue

    if ignoreCase {
        options = NSRegularExpressionOptions.CaseInsensitive.rawValue | options
    }

    var error: NSError? = nil
    let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: options), error: &error)
    
    return (error == nil) ? regex : nil
}
