/*
Copyright 2015 the original author or authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import Foundation


/**
An in-memory implementation of `DateFormatterPool`.
*/
public final class InMemoryDateFormatterPool: DateFormatterPool {

    private let monitor = Monitor()

    private var dateFormatters = [String : NSDateFormatter]()

    /**
    Returns an `NSDateFormatter` for a given `format`.  Implementations should return the **same** instance for all subsequent calls that pass the same `format`.

    - parameter format: The format to return an `NSDateFormatter` for

    - returns: A new or previously created `NSDateFormatter` for this `format`
    */
    public func get(format: String) -> NSDateFormatter {
        return syncronized(self.monitor) {
            if let candidate = self.dateFormatters[format] {
                return candidate
            } else {
                let dateFormatter = NSDateFormatter()
                dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
                dateFormatter.dateFormat = format

                self.dateFormatters[format] = dateFormatter
                return dateFormatter
            }
        }
    }
}