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

name "apache2"
default_version "2.4.20"

license "apache2"
license_file "COPYING"

dependency "config_guess"
dependency "zlib"
dependency "openssl"
dependency "nghttp2"

version "2.4.20" do
  source sha1: "b08d6889100294fd89a2ff9c60137e70ef2e996b"
end

source url: "http://apache.mirrors.pair.com/httpd/httpd-#{version}.tar.gz"

relative_path "httpd-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  configure = [
    "./configure",
    "--prefix=#{install_dir}/embedded",
    "--with-z=#{install_dir}/embedded",
    "--with-ssl=#{install_dir}/embedded",
    "--with-nghttp2=#{install_dir}/embedded",
    "--with-program-name=apache2",
    "--enable-pie",
    "--enable-mods-shared=most",
    "--enable-mpms-shared=all"
  ]

  command configure.join(" "), env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
