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
import Quick


final class PlistConfigurationProviderSpec: QuickSpec {

    override func spec() {

        let bundle = NSBundle(forClass: self.dynamicType)

        describe("PlistConfigurationProviderSpec") {

            it("returns root if file does not exist") {
                let configurationProvider = PlistConfigurationProvider(file: "NonExistent", bundle: bundle)
                expect(configurationProvider.configuration("Test").name).to(equal("ROOT"))
            }

            it("returns root if named configuration is not specified") {
                let configurationProvider = PlistConfigurationProvider(file: "RootOnly", bundle: bundle)
                expect(configurationProvider.configuration("Test").name).to(equal("ROOT"))
            }

            it("returns named configuration if specified") {
                let configurationProvider = PlistConfigurationProvider(file: "Named", bundle: bundle)
                expect(configurationProvider.configuration("Test").name).to(equal("Test"))
            }

            it("sets level if specified") {
                let configurationProvider = PlistConfigurationProvider(file: "LevelSet", bundle: bundle)
                expect(configurationProvider.configuration("Test").level).to(equal(Level.Error))
            }

            it("sets format if specified") {
                let configurationProvider = PlistConfigurationProvider(file: "FormatSet", bundle: bundle)
                expect(configurationProvider.configuration("Test").format).to(equal("test-format"))
            }
        }

        describe("Level") {

            let configurationProvider = PlistConfigurationProvider(file: "Levels", bundle: bundle)

            it("parses from String") {
                expect(configurationProvider.configuration("debug").level).to(equal(Level.Debug))
                expect(configurationProvider.configuration("DEBUG").level).to(equal(Level.Debug))
                expect(configurationProvider.configuration("Debug").level).to(equal(Level.Debug))

                expect(configurationProvider.configuration("info").level).to(equal(Level.Info))
                expect(configurationProvider.configuration("INFO").level).to(equal(Level.Info))
                expect(configurationProvider.configuration("Info").level).to(equal(Level.Info))

                expect(configurationProvider.configuration("warn").level).to(equal(Level.Warn))
                expect(configurationProvider.configuration("WARN").level).to(equal(Level.Warn))
                expect(configurationProvider.configuration("Warn").level).to(equal(Level.Warn))

                expect(configurationProvider.configuration("error").level).to(equal(Level.Error))
                expect(configurationProvider.configuration("ERROR").level).to(equal(Level.Error))
                expect(configurationProvider.configuration("Error").level).to(equal(Level.Error))
            }

            it("parses to .Debug for an unknown String") {
                expect(configurationProvider.configuration("unknown").level).to(equal(Level.Debug))
            }
        }
    }
}