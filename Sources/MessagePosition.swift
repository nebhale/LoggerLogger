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


/// Encapsulates the position that a log message was generated at
public struct MessagePosition {

    /// The column the log message was generated at
    public let column: Int

    /// The file the log message was generated in
    public let file: String

    /// The function the log message was generated in
    public let function: String

    /// The line the log message was generated at
    public let line: Int

    /// Creates a new instance of ``MessagePosition``
    ///
    /// :param: column   The column the log message was generated at
    /// :param: file     The file the log message was generated in
    /// :param: function The function the log message was generated in
    /// :param: line     The line the log message was generated at
    public init(column: Int, file: String, function: String, line: Int) {
        self.column = column
        self.file = file
        self.function = function
        self.line = line
    }
}

// MARK: - Printable
extension MessagePosition: Printable {
    
    /// A textual representation of the ``MessagePosition``
    public var description: String { return "<MessagePosition: column=\(self.column), file=\(self.file), function=\(self.function), line=\(self.line)>"}
}
