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

name "nghttp2"
default_version "1.11.1"

license "MIT"
license_file "COPYING"

dependency "config_guess"
dependency "openssl"
dependency "zlib"
dependency "libev"
dependency "libxml2"

version "1.11.1" do
  source sha256: "6a920d3d6b21f6f7e3aa0061f187bfd0cbf35c3cd2b61cd3fce0af896609b877"
end

source url: "https://github.com/nghttp2/nghttp2/releases/download/v#{version}/nghttp2-#{version}.tar.gz"

relative_path "nghttp2-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_args = [
    "--prefix=#{install_dir}/embedded",
    "--with-xml-prefix=#{install_dir}/embedded",
    "--disable-examples",
    "--disable-hpack-tools",
    "--disable-python-bindings",
    "--enable-mpm-shared=all"
  ]

  configure_command = "./configure " . configure_args.join(" ")

  command configure_command, env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
