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


import Nimble
import Quick

final class ConfigurationSpec: QuickSpec {

    override func spec() {
        describe("Configuration") {
            it("initializes all properties to values") {
                let configuration = Configuration(name: "test-name", level: .Info, format: "test-format")
                expect(configuration.name).to(equal("test-name"))
                expect(configuration.level).to(equal(Level.Info))
                expect(configuration.format).to(equal("test-format"))
            }

            it("bases equality on name") {
                let configuration1 = Configuration(name: "test-name", level: .Info, format: "test-format")
                let configuration2 = Configuration(name: "test-name", level: .Warn, format: "another-test-format")
                let configuration3 = Configuration(name: "anoter-test-name", level: .Info, format: "test-format")

                expect(configuration1).to(equal(configuration2))
                expect(configuration1).toNot(equal(configuration3))
            }

            it("bases hash value on name") {
                let name = "test-name"
                expect(Configuration(name: name, level: .Info, format: "test-format").hashValue).to(equal(name.hashValue))
            }
        }
    }
}