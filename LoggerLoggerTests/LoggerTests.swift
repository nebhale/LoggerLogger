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


final class LoggerTests: XCTestCase {

    private var configurationProvider: StubConfigurationProvider!

    private var logger: Logger!

    private var messageWriter: StubMessageWriter!

    override func setUp() {
        self.configurationProvider = StubConfigurationProvider(level: .Debug)
        self.messageWriter = StubMessageWriter()
        self.logger = Logger(name: "test-name", configurationProvider: self.configurationProvider, messageWriter: self.messageWriter)
    }

    func test_DoesNotCallMessageWriterIfLoggingShouldNotHappen() {
        Logger(configurationProvider: StubConfigurationProvider(level: .Info), messageWriter: messageWriter).debug("test-message")
        expect(self.messageWriter.configuration).to(beNil())
    }

    func test_UsesCallerFileAsADefaultLoggerName() {
        Logger(configurationProvider: configurationProvider, messageWriter: messageWriter).debug("test-message")
        expect(self.messageWriter.configuration?.name).to(equal("LoggerTests"))
    }

    func test_WritesADebugMessageWithAnAutoclosure() {
        logger.debug("test-message")
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Debug))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesADebugMessageWithAClosure() {
        logger.debug { "test-message" }
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Debug))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesAnInfoMessageWithAnAutoclosure() {
        logger.info("test-message")
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Info))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesAnInfoMessageWithAClosure() {
        logger.info { "test-message" }
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Info))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesAWarnMessageWithAnAutoclosure() {
        logger.warn("test-message")
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Warn))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesAWarnMessageWithAClosure() {
        logger.warn { "test-message" }
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Warn))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesAnErrorMessageWithAnAutoclosure() {
        logger.error("test-message")
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Error))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }

    func test_WritesAnErrorMessageWithAClosure() {
        logger.error { "test-message" }
        expect(self.messageWriter.configuration?.name).to(equal("test-name"))
        expect(self.messageWriter.level).to(equal(Level.Error))
        expect(self.messageWriter.messagePosition).toNot(beNil())
        expect(self.messageWriter.message).to(equal("test-message"))
    }
}

private final class StubConfigurationProvider: ConfigurationProvider {

    private let level: Level

    private init(level: Level) {
        self.level = level
    }

    private func configuration(name: String) -> LoggerLogger.Configuration {
        return Configuration(name: name, level: self.level, format: "test-format")
    }
}

private final class StubMessageWriter: MessageWriter {

    var configuration: LoggerLogger.Configuration?

    var level: Level?

    var messagePosition: MessagePosition?

    var message: String?

    private func write(configuration configuration: LoggerLogger.Configuration, level: Level, messagePosition: MessagePosition, @noescape messageProvider: MessageProvider) {
        self.configuration = configuration
        self.level = level
        self.messagePosition = messagePosition
        self.message = messageProvider() as? String
    }
}