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


final class ConsoleMessageWriterTests: XCTestCase {

    func test_FormatsTheMessageBeforeWriting() {
        let configuration = Configuration(name: "test-name", level: .Info, format: "test-format")
        let messageFormatter = StubMessageFormatter()
        let messagePosition = MessagePosition(column: 0, file: "test-file", function: "test-function", line: 1)
        let messageWriter = ConsoleMessageWriter(messageFormatter: messageFormatter)

        messageWriter.write(configuration: configuration, level: .Info, messagePosition: messagePosition, messageProvider: { "" })
        expect(messageFormatter.called).to(beTruthy())
    }
}

private final class StubMessageFormatter: MessageFormatter {

    var called = false

    func format(configuration configuration: LoggerLogger.Configuration, level: Level, messagePosition: MessagePosition, @noescape messageProvider: MessageProvider) -> String {
        self.called = true
        return "test-formatted-message"
    }
}