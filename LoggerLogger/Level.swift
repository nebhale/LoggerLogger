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


/**
A hierarchy of severities that log messages can be contributed at
*/
public enum Level: Int {

    /**
    Indicates that a message is trivial.  The lowest level severity.
    */
    case Debug

    /**
    Indicates that a message is routine in normal operation
    */
    case Info

    /**
    Indicates that a message is *not* routine in normal operation, but may not be a problem
    */
    case Warn

    /**
    Indicates that a message is *not* routine in normal operation, and is a problem.  The highest severity.
    */
    case Error

    func toString() -> String {
        switch(self) {
        case .Debug:
            return "Debug"
        case .Info:
            return "Info"
        case .Warn:
            return "Warn"
        case .Error:
            return "Error"
        }
    }
}

// MARK: - CustomStringConvertible
extension Level: CustomStringConvertible {

    /**
    A textual representation of the `Level`
    */
    public var description: String { return "<Level: \(self.rawValue)>" }
}