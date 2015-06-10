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


@testable import LoggerLogger
import Nimble
import Quick

final class DefaultMessageFormatterSpec: QuickSpec {
    override func spec() {
        describe("DefaultMessageFormatter") {
            let level = Level.Debug
            let messageFormatter = DefaultMessageFormatter()
            let messagePosition = MessagePosition(column: 0, file: "test-file", function: "test-function", line: 1)
            let messageProvider: MessageProvider = { "test-message" }

            it("expands %column") {
                let configuration = self.configurationWithFormat("%column")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal(String(messagePosition.column)))
            }

            it("expands %date{}") {
                let configuration = self.configurationWithFormat("%date{HH:mm}")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider) =~ "[\\d]{2}:[\\d]{2}").to(beTruthy())
            }

            it("expands %file") {
                let configuration = self.configurationWithFormat("%file")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal(messagePosition.file))
            }

            it("expands %function") {
                let configuration = self.configurationWithFormat("%function")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal(messagePosition.function))
            }

            it("expands %level") {
                let configuration = self.configurationWithFormat("%level")
                expect(messageFormatter.format(configuration: configuration, level: .Debug, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal("DEBUG"))
                expect(messageFormatter.format(configuration: configuration, level: .Info,  messagePosition: messagePosition, messageProvider: messageProvider)).to(equal("INFO "))
                expect(messageFormatter.format(configuration: configuration, level: .Warn,  messagePosition: messagePosition, messageProvider: messageProvider)).to(equal("WARN "))
                expect(messageFormatter.format(configuration: configuration, level: .Error, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal("ERROR"))
            }

            it("expands %line") {
                let configuration = self.configurationWithFormat("%line")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal(String(messagePosition.line)))
            }

            it("expands %message") {
                let configuration = self.configurationWithFormat("%message")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal(messageProvider() as? String))
            }

            it("expands %thread") {
                let configuration = self.configurationWithFormat("%thread")
                expect(messageFormatter.format(configuration: configuration, level: .Debug, messagePosition: messagePosition, messageProvider: messageProvider)).to(equal("Main"))
            }

            it("replaces newlines with spaces") {
                let configuration = self.configurationWithFormat("%message")
                expect(messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: { "test\nmessage" })).to(equal("test message"))
            }
        }
    }

    private func configurationWithFormat(format: String) -> LoggerLogger.Configuration {
        return Configuration(name: "test-name", level: Level.Debug, format: format)
    }
}