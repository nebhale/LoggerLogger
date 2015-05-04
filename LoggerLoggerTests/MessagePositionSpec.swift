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

final class MessagePositionSpec: QuickSpec {

    override func spec() {
        describe("MessagePosition") {
            it("initializes all properties to values") {
                let messagePosition = MessagePosition(column: 0, file: "test-file", function: "test-function", line: 1)
                expect(messagePosition.column).to(equal(0))
                expect(messagePosition.file).to(equal("test-file"))
                expect(messagePosition.function).to(equal("test-function"))
                expect(messagePosition.line).to(equal(1))
            }
        }
    }
}