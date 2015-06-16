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
An implementation of `MessageWriter` that outputs to the console via `print`
*/
public final class ConsoleMessageWriter: MessageWriter {

    private let messageFormatter: MessageFormatter

    private let monitor = Monitor()

    /**
    Creates a new instance of `MessageFormatter`

    - parameter messageFormatter: The `MessageFormatter` to use.  Defaults to the `DefaultMessageFormatter`.
    */
    public init(messageFormatter: MessageFormatter = DefaultMessageFormatter()) {
        self.messageFormatter = messageFormatter
    }

    /**
    Write the contents of a message.  Implementations can assume that if this method is called, the message _should_ be written.

    - parameter configuration:   The configuration of the `Logger` generating the message
    - parameter level:           The level that the message was generated at
    - parameter messagePosition: The position that the log message was generated at
    - parameter messageProvider: The `MessageProvider` to be evaluated
    */
    public func write(configuration configuration: Configuration, level: Level, messagePosition: MessagePosition, @noescape messageProvider: MessageProvider) {
        let message = self.messageFormatter.format(configuration: configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)

        syncronized(self.monitor) {
            print(message)
        }
    }
}