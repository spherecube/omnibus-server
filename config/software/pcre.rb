#
# Copyright 2012-2014 Chef Software, Inc.
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

name "pcre"
default_version "8.39"

license "BSD-2-Clause"
license_file "LICENCE"

dependency "libedit"
dependency "ncurses"
dependency "config_guess"

version "8.39" do
  source sha256: "ccdf7e788769838f8285b3ee672ed573358202305ee361cfec7a4a4fb005bbc7"
end

source url: "http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-#{version}.tar.gz"

relative_path "pcre-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  config_command = [
    "--disable-cpp",
    "--enable-utf",
    "--enable-unicode-properties",
    "--enable-pcretest-libedit"
  ]

  configure(*config_command, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
