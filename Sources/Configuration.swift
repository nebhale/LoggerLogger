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


/// The configuration definition for a ``Logger``
public struct Configuration {

    /// The name of the ``Logger``
    public let name: String

    /// The lowest severity of messages to be printed
    public let level: Level

    /// The format of the log message when printed
    public let format: String

    /// Creates a new instance of ``Configuration``
    ///
    /// :param: name   The name of the ``Logger``
    /// :param: level  The lowest severity of messages to be printed
    /// :param: format The format of the log message when printed
    public init(name: String, level: Level, format: String) {
        self.name = name
        self.level = level
        self.format = format
    }
}

// MARK: - Equatable
extension Configuration: Equatable {}

/// Returns the equality of two ``Configuration``s.
///
/// :param: x The first ``Configuration``
/// :param: y The second ``Configuration``
///
/// :returns: ``true`` if the ``name``s of the two ``Configuration``s match, ``false`` otherwise
public func ==(x: Configuration, y: Configuration) -> Bool {
    return x.name == y.name
}

// MARK: - Hashable
extension Configuration: Hashable {

    /// A hash value for the ``Configuration``
    public var hashValue: Int { return self.name.hashValue }
}

// MARK: - Printable
extension Configuration: Printable {
    
    /// A textual representation of the ``Configuration``
    public var description: String { return "<Configuration: \(self.name); level=\(self.level), format=\(self.format)>"}
}