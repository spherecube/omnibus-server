#
# Copyright 2012-2015 Chef Software, Inc.
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

name "zlib"
default_version "1.2.8"

version "1.2.8" do
  source sha256: "36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d"
end

source url: "http://zlib.net/zlib-#{version}.tar.gz"

license "Zlib"
license_file "README"

relative_path "zlib-#{version}"

build do
  env = with_standard_compiler_flags
  if freebsd?
    # FreeBSD 10+ gets cranky if zlib is not compiled in a
    # position-independent way.
    env["CFLAGS"] << " -fPIC"
  end

  configure env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
