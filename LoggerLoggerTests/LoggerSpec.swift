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

final class LoggerSpec: QuickSpec {

    override func spec() {
        class StubConfigurationProvider: ConfigurationProvider {

            private let level: Level

            private init(level: Level) {
                self.level = level
            }

            private func configuration(name: String) -> Configuration {
                return Configuration(name: name, level: self.level, format: "test-format")
            }
        }

        class StubMessageWriter: MessageWriter {

            var configuration: Configuration?

            var level: Level?

            var messagePosition: MessagePosition?

            var message: String?

            private func write(#configuration: Configuration, level: Level, messagePosition: MessagePosition, @noescape messageProvider: MessageProvider) {
                self.configuration = configuration
                self.level = level
                self.messagePosition = messagePosition
                self.message = messageProvider() as? String
            }
        }

        describe("Logger") {
            var configurationProvider: StubConfigurationProvider!
            var logger: Logger!
            var messageWriter: StubMessageWriter!

            beforeEach {
                configurationProvider = StubConfigurationProvider(level: .Debug)
                messageWriter = StubMessageWriter()
                logger = Logger(name: "test-name", configurationProvider: configurationProvider, messageWriter: messageWriter)
            }

            it("does not call MessageWriter if logging should not happen") {
                Logger(configurationProvider: StubConfigurationProvider(level: .Info), messageWriter: messageWriter).debug("test-message")
                expect(messageWriter.configuration).to(beNil())
            }

            it("uses caller's file as a default logger name") {
                Logger(configurationProvider: configurationProvider, messageWriter: messageWriter).debug("test-message")
                expect(messageWriter.configuration?.name).to(equal("LoggerSpec"))
            }

            it("writes a debug message with an autoclosure") {
                logger.debug("test-message")
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Debug))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a debug messages with a closure") {
                logger.debug { "test-message" }
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Debug))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a info message with an autoclosure") {
                logger.info("test-message")
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Info))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a info messages with a closure") {
                logger.info { "test-message" }
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Info))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a warn message with an autoclosure") {
                logger.warn("test-message")
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Warn))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a warn messages with a closure") {
                logger.warn { "test-message" }
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Warn))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a error message with an autoclosure") {
                logger.error("test-message")
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Error))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }

            it("writes a error messages with a closure") {
                logger.error { "test-message" }
                expect(messageWriter.configuration?.name).to(equal("test-name"))
                expect(messageWriter.level).to(equal(Level.Error))
                expect(messageWriter.messagePosition).toNot(beNil())
                expect(messageWriter.message).to(equal("test-message"))
            }
        }
    }
}