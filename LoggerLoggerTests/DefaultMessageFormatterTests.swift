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


final class DefaultMessageFormatterTests: XCTestCase {

    private var level: Level!

    private var messageFormatter: DefaultMessageFormatter!

    private var messagePosition: MessagePosition!

    private var messageProvider: MessageProvider!

    override func setUp() {
        self.level = Level.Debug
        self.messageFormatter = DefaultMessageFormatter()
        self.messagePosition = MessagePosition(column: 0, file: "test-file", function: "test-function", line: 1)
        self.messageProvider = { "test-message" }
    }


    func test_expandsPercentColumn() {
        let configuration = self.configurationWithFormat("%column")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal(String(messagePosition.column)))
    }

    func test_expandsPercentDate() {
        let configuration = self.configurationWithFormat("%date{HH:mm}")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: self.messageProvider) =~ "[\\d]{2}:[\\d]{2}").to(beTruthy())
    }

    func test_expandsPercentFile() {
        let configuration = self.configurationWithFormat("%file")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal(messagePosition.file))
    }

    func test_expandsPercentFunction() {
        let configuration = self.configurationWithFormat("%function")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal(messagePosition.function))
    }

    func test_expandsPercentLevel() {
        let configuration = self.configurationWithFormat("%level")
        expect(self.messageFormatter.format(configuration: configuration, level: .Debug, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal("DEBUG"))
        expect(self.messageFormatter.format(configuration: configuration, level: .Info,  messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal("INFO "))
        expect(self.messageFormatter.format(configuration: configuration, level: .Warn,  messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal("WARN "))
        expect(self.messageFormatter.format(configuration: configuration, level: .Error, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal("ERROR"))
    }

    func test_expandsPercentLine() {
        let configuration = self.configurationWithFormat("%line")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal(String(messagePosition.line)))
    }

    func test_expandsPercentMessage() {
        let configuration = self.configurationWithFormat("%message")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal(messageProvider() as? String))
    }

    func test_expandsPercentThread() {
        let configuration = self.configurationWithFormat("%thread")
        expect(self.messageFormatter.format(configuration: configuration, level: .Debug, messagePosition: self.messagePosition, messageProvider: self.messageProvider)).to(equal("Main"))
    }

    func test_replacesNewlinesWithSpaces() {
        let configuration = self.configurationWithFormat("%message")
        expect(self.messageFormatter.format(configuration: configuration, level: self.level, messagePosition: self.messagePosition, messageProvider: { "test\nmessage" })).to(equal("test message"))
    }

    private func configurationWithFormat(format: String) -> LoggerLogger.Configuration {
        return Configuration(name: "test-name", level: .Debug, format: format)
    }
}