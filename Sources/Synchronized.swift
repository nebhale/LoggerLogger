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


import Foundation

final class Monitor {}

func syncronized<T>(lock: Monitor, @noescape f: () -> Void) {
    objc_sync_enter(lock)
    f()
    objc_sync_exit(lock)
}

func syncronized<T>(lock: Monitor, @noescape f: () -> T) -> T {
    objc_sync_enter(lock)
    let value = f()
    objc_sync_exit(lock)
    return value
}