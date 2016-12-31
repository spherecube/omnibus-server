#
# Copyright 2016 Sphere Cube LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "apache"
friendly_name "Apache HTTP Server"
maintainer "Sphere Cube LLC <omnibus-server@spherecube.host>"
homepage "https://www.spherecube.host"

build_iteration 1
build_version '2.4.25-1.1.0c'

install_dir "#{default_root}/omnibus-#{name}"

# Chef Release version pinning
override :apache, version: '2.4.25'
override :openssl, version: '1.1.0c'

license "Apache-2.0"
license_file "LICENSE"

dependency "apache2"

package :rpm do
  signing_passphrase ENV['OMNIBUS_RPM_SIGNING_PASSPHRASE']
end
