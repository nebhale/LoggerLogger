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


/// The main entry point used for logging.
public final class Logger {

    private let configuration: Configuration

    private let messageWriter: MessageWriter

    /// Creates an instance of ``Logger``
    ///
    /// :param: name                  The name of the logger.  Defaults to the `basename` of the file containing the declaration.
    /// :param: configurationProvider The ``ConfigurationProvider`` to use.  Defaults to ``ConfigurationProviderManager.defaultInstance``
    /// :param: messageWriter         The ``MessageWriter`` to use.  Defaults to ``MessageWriterManager.defaultInstance``.
    public init(name: String = __FILE__, configurationProvider: ConfigurationProvider = ConfigurationProviderManager.defaultInstance, messageWriter: MessageWriter = MessageWriterManager.defaultInstance) {
        self.configuration = configurationProvider.configuration(name.basename())
        self.messageWriter = messageWriter
    }

    /// Logs a message at the ``Debug`` level
    ///
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    public func debug(@autoclosure messageProvider: MessageProvider, column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        log(column: column, file: file, function: function, level: .Debug, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Debug`` level
    ///
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    public func debug(column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__, messageProvider: MessageProvider) {
        log(column: column, file: file, function: function, level: .Debug, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Info`` level
    ///
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    public func info(@autoclosure messageProvider: MessageProvider, column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        log(column: column, file: file, function: function, level: .Info, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Info`` level
    ///
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    public func info(column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__, messageProvider: MessageProvider) {
        log(column: column, file: file, function: function, level: .Info, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Warn`` level
    ///
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    public func warn(@autoclosure messageProvider: MessageProvider, column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        log(column: column, file: file, function: function, level: .Warn, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Warn`` level
    ///
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    public func warn(column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__, messageProvider: MessageProvider) {
        log(column: column, file: file, function: function, level: .Warn, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Error`` level
    ///
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    public func error(@autoclosure messageProvider: MessageProvider, column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        log(column: column, file: file, function: function, level: .Error, line: line, messageProvider: messageProvider)
    }

    /// Logs a message at the ``Error`` level
    ///
    /// :param: column          The column the log message was generated at.  This argument is populated automatically.
    /// :param: file            The file the log message was generated in.  This argument is populated automatically.
    /// :param: function        The function the log message was generated in.  This argument is populated automatically.
    /// :param: line            The line the log message was generated at.  This argument is populated automatically.
    /// :param: messageProvider The ``MessageProvider`` to be evaluated
    public func error(column: Int = __COLUMN__, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__, messageProvider: MessageProvider) {
        log(column: column, file: file, function: function, level: .Error, line: line, messageProvider: messageProvider)
    }

    private func log(#column: Int, file: String, function: String, level: Level, line: Int, @noescape messageProvider: MessageProvider) {
        if configuration.level.rawValue <= level.rawValue {
            let messagePosition = MessagePosition(column: column, file: file, function: function, line: line)
            self.messageWriter.write(configuration: self.configuration, level: level, messagePosition: messagePosition, messageProvider: messageProvider)
        }
    }
}