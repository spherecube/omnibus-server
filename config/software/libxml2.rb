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

name "libxml2"
default_version "2.9.4"

license "MIT"
license_file "COPYING"

dependency "zlib"
dependency "libiconv"
dependency "liblzma"
dependency "config_guess"

version "2.9.4" do
  source sha256: "ffb911191e509b966deb55de705387f14156e1a56b21824357cdf0053233633c"
end

source url: "ftp://xmlsoft.org/libxml2/libxml2-#{version}.tar.gz"

relative_path "libxml2-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path({}, msys: true), bfd_flags: true)

  configure_command = [
    "--with-zlib=#{install_dir}/embedded",
    "--with-iconv=#{install_dir}/embedded",
    "--without-python",
    "--without-icu",
  ]

  update_config_guess

  configure(*configure_command, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
