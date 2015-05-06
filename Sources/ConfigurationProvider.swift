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


/// An instance that provides a ``Configuration`` instance for a given ``Logger``.  Implementations a free to determine where the configuration should be sourced from.
public protocol ConfigurationProvider {
    
    /// Returns the ``Configuration`` instance for a ``Logger``
    ///
    /// :param: name The name of the ``Logger``
    ///
    /// :returns: The ``Configuration`` instance for the ``Logger``
    func configuration(name: String) -> Configuration
}