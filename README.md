# LoggerLogger
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/nebhale/LoggerLogger.svg)](https://travis-ci.org/nebhale/LoggerLogger)

LoggerLogger is intented to be a simple, lightweight, and fast logging framework for Swift-based applications.

## Installation
[Carthage][c] is the easiest way to use this framework.  [Follow the Carthage instructions][a] to add a framework to your application.  The proper declaration for your `Cartfile` is:

```cartfile
github "nebhale/LoggerLogger"
```

## Usage
To use LoggerLogger, first start by importing the module.  Next, create a new instance of the `Logger` type.  In most cases, using the empty initializer is sufficient.  This creates a `Logger` that uses the name of the file it is declared in, as its name.  Finally, call the appropriate logging method (`debug()`, `info()`, `warn()`, `error()`).  The logging methods ensure that all input, whether via an argument or a trailing closure, are lazily evaluated and if and only if logging should happen based on the configuration.

```swift
import LoggerLogger

final class Example {

    private let logger = Logger()

    func example() {
        logger.debug("debug autoclosure")
        logger.debug { "debug closure" }

        logger.info("info autoclosure")
        logger.info { "info closure" }

        logger.warn("warn autoclosure")
        logger.warn { "warn closure" }

        logger.error("error autoclosure")
        logger.error { "error closure" }
    }
}
```

## Configuration
Configuration of LoggerLogger is done using a `Logging.plist` file, in the main bundle of the application.  A logger can be configured with a `Level` and a `Format`.

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Level</key>
  <string>Warn</string>
  <key>Format</key>
  <string>%level %message</string>
</dict>
</plist>
```

### Levels
There are 4 levels that can be configured.  The values are not case sensitive.

| Value | Description
| ----- | -----------
| `Debug` | Indicates that a message is trivial.  The lowest level severity.
| `Info` | Indicates that a message is routine in normal operation
| `Warn` | Indicates that a message is *not* routine in normal operation, but may not be a problem
| `Error` | Indicates that a message is *not* routine in normal operation, and is a problem.  The highest severity.

If not specified, the default `Level` if `Info`

### Format
The format is a string containing a set of patterns that can be replaced.  Any other characters in the format string are left unchanged.

| Pattern | Description
| ------- | -----------
| `%column` | The column the message was generated at
| `%date{<FORMAT>}` | The date the message was generated on.  The format of the date (usable by `NSDateFormatter`) is specified within the curly braces.
| `%file` | The file the message was generated in
| `%function` | The function the message was generated in
| `%level` | The level the message was logged at
| `%line` | The line the message was generated at
| `%message` | The logged message
| `%thread` | Whether the message was logged on the main or background thread

If not specified the default `Format` is `%date{HH:mm:ss} %level %message`.

### Named Loggers
In addition to the root `Logger`, additional _named_ `Logger`s can be configured.  In order to use a named `Logger`, the declaration is slightly different.

```swift
private let logger = Logger(name: "Networking")
```

In order to configure a named `Logger`, the same keys are used, they are instead nested under a dictionary who's key is the name of the `Logger` being configured.

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Level</key>
  <string>Warn</string>
  <key>Neworking</key>
  <dict>
    <key>Level</key>
    <string>Error</string>
  </dict>
</dict>
</plist>
```

## Contributing
[Pull requests][p] are welcome.

## License
This project is released under version 2.0 of the [Apache License][l].


[a]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application
[c]: https://github.com/Carthage/Carthage
[l]: http://www.apache.org/licenses/LICENSE-2.0
[p]: http://help.github.com/send-pull-requests
