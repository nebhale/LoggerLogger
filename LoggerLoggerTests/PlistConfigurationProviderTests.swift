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

@testable
import LoggerLogger
import Nimble
import XCTest


final class PlistConfigurationProviderTests: XCTestCase {

    private var bundle: NSBundle!

    private var configurationProvider: PlistConfigurationProvider!

    override func setUp() {
        self.bundle = NSBundle(forClass: self.dynamicType)
        self.configurationProvider = PlistConfigurationProvider(file: "Levels", bundle: self.bundle)
    }

    // MARK: - PlistConfigurationProvider

    func test_ReturnsRootIfFileDoesNotExist() {
        let configurationProvider = PlistConfigurationProvider(file: "NonExistent", bundle: self.bundle)
        expect(configurationProvider.configuration("Test").name).to(equal("ROOT"))
    }

    func test_ReturnsRootIfNamedConfigurationIsNotSpecified() {
        let configurationProvider = PlistConfigurationProvider(file: "RootOnly", bundle: self.bundle)
        expect(configurationProvider.configuration("Test").name).to(equal("ROOT"))
    }

    func test_ReturnsNamedConfigurationIfSpecified() {
        let configurationProvider = PlistConfigurationProvider(file: "Named", bundle: self.bundle)
        expect(configurationProvider.configuration("Test").name).to(equal("Test"))
    }

    func test_SetsLevelIfSpecified() {
        let configurationProvider = PlistConfigurationProvider(file: "LevelSet", bundle: self.bundle)
        expect(configurationProvider.configuration("Test").level).to(equal(Level.Error))
    }

    func test_SetsFormatIfSpecified() {
        let configurationProvider = PlistConfigurationProvider(file: "FormatSet", bundle: self.bundle)
        expect(configurationProvider.configuration("Test").format).to(equal("test-format"))
    }

    // MARK: - Level

    func test_ParsesLevelFromString() {
        expect(self.configurationProvider.configuration("debug").level).to(equal(Level.Debug))
        expect(self.configurationProvider.configuration("DEBUG").level).to(equal(Level.Debug))
        expect(self.configurationProvider.configuration("Debug").level).to(equal(Level.Debug))

        expect(self.configurationProvider.configuration("info").level).to(equal(Level.Info))
        expect(self.configurationProvider.configuration("INFO").level).to(equal(Level.Info))
        expect(self.configurationProvider.configuration("Info").level).to(equal(Level.Info))

        expect(self.configurationProvider.configuration("warn").level).to(equal(Level.Warn))
        expect(self.configurationProvider.configuration("WARN").level).to(equal(Level.Warn))
        expect(self.configurationProvider.configuration("Warn").level).to(equal(Level.Warn))

        expect(self.configurationProvider.configuration("error").level).to(equal(Level.Error))
        expect(self.configurationProvider.configuration("ERROR").level).to(equal(Level.Error))
        expect(self.configurationProvider.configuration("Error").level).to(equal(Level.Error))
    }

    func test_ParsesLevelToDebugForAnUnknownString() {
        expect(self.configurationProvider.configuration("unknown").level).to(equal(Level.Debug))
    }
}