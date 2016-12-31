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
default_version "1.18.0"

license "MIT"
license_file "COPYING"

dependency "config_guess"
dependency "openssl"
dependency "zlib"
dependency "libev"
dependency "libxml2"

version "1.18.0" do
  source sha256: "30b7a1fc21f58eadbcd124791dd7dbda50b9d4ad113b49d78d04ded49c22be8a"
end

source url: "https://github.com/nghttp2/nghttp2/releases/download/v#{version}/nghttp2-#{version}.tar.gz"

relative_path "nghttp2-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  config_command = [
    "--prefix=#{install_dir}/embedded",
    "--with-xml-prefix=#{install_dir}/embedded",
    "--disable-examples",
    "--disable-hpack-tools",
    "--disable-python-bindings"
  ]

  configure(*config_command, env: env)

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
