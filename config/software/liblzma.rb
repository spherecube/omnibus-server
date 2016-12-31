#
# Copyright 2014 Chef Software, Inc.
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

name "liblzma"
default_version "5.2.3"

license "Public-Domain"
license_file "COPYING"

source url: "http://tukaani.org/xz/xz-#{version}.tar.gz",
       sha256: "71928b357d0a09a12a4b4c5fafca8c31c19b0e7d3b8ebb19622e96f26dbf28cb"

relative_path "xz-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path({}, msys: true), bfd_flags: true)

  config_command = [
    "--disable-debug",
    "--disable-dependency-tracking",
    "--disable-doc",
    "--disable-scripts",
  ]

  configure(*config_command, env: env)

  make "install", env: env
end
