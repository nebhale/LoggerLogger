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

/// An implementation of ``ConfigurationProvider`` that reads configuration values from a plist
public final class PlistConfigurationProvider: ConfigurationProvider {

    private static let DEFAULT_FORMAT = "%date{HH:mm:ss} %level %message"

    private static let DEFAULT_LEVEL = Level.Info

    private var configurations: [String : Configuration] = [:]

    private let rootConfiguration: Configuration

    /// Creates a new instance of ``PlistConfigurationProvider``
    ///
    /// :param: file   The name of the plist file to read
    /// :param: bundle The bundle to read the plist from.  Defaults to ``NSBundle.mainBundle()``
    public init(file: String = "Logging", bundle: NSBundle = NSBundle.mainBundle()) {
        let source = PlistConfigurationProvider.readSource(file, bundle: bundle)
        rootConfiguration = PlistConfigurationProvider.toConfiguration("ROOT", source: source)

        for (key, value) in source {
            if let value = value as? [String : AnyObject] {
                configurations += PlistConfigurationProvider.toConfiguration(key, source: value)
            }
        }
    }

    /// Returns the ``Configuration`` instance for a ``Logger``
    ///
    /// :param: name The name of the ``Logger``
    ///
    /// :returns: The ``Configuration`` instance for the ``Logger``
    public func configuration(name: String) -> Configuration {
        if let configuration = self.configurations[name] {
            return configuration
        } else {
            return self.rootConfiguration
        }
    }

    private static func toConfiguration(name: String, source: [String : AnyObject]) -> Configuration {
        let level: Level
        if let candidate = source["Level"] as? String {
            level = Level(candidate)
        } else {
            level = DEFAULT_LEVEL
        }

        let format: String
        if let candidate = source["Format"] as? String {
            format = candidate
        } else {
            format = DEFAULT_FORMAT
        }

        return Configuration(name: name, level: level, format: format)
    }

    private static func readSource(file: String, bundle: NSBundle) -> [String : AnyObject] {
        if let url = bundle.URLForResource(file, withExtension: "plist"), let dictionary = NSDictionary(contentsOfURL: url) as? [String: AnyObject] {
            return dictionary
        } else {
            return [:]
        }
    }
}

// MARK: - Level From String
extension Level {
    private init(_ rawValue: String) {
        switch rawValue {
        case let value where value =~ (Level.Debug.toString(), true):
            self = .Debug
        case let value where value =~ (Level.Info.toString(), true):
            self = .Info
        case let value where value =~ (Level.Warn.toString(), true):
            self = .Warn
        case let value where value =~ (Level.Error.toString(), true):
            self = .Error
        default:
            self = .Debug
        }

    }
}

// MARK: - Dictionary Addition
func +=(inout dictionary: [String : Configuration], configuration: Configuration) -> [String : Configuration] {
    dictionary[configuration.name] = configuration
    return dictionary
}
