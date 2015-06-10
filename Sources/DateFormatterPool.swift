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

/// An instance that provides an `NSDateFormatter` instance for a given format.  This is used to improve performance when formatting log messages.
public protocol DateFormatterPool {

    /// Returns an `NSDateFormatter` for a given `format`.  Implementations should return the **same** instance for all subsequent calls that pass the same `format`.
    ///
    /// - parameter format: The format to return an `NSDateFormatter` for
    ///
    /// - returns: A new or previously created `NSDateFormatter` for this `format`
    func get(format: String) -> NSDateFormatter
}