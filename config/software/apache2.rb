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
default_version "2.4.25"

license "Apache-2.0"
license_file "COPYING"

dependency "config_guess"
dependency "zlib"
dependency "openssl"
dependency "nghttp2"
dependency "pcre"
dependency "apr"
dependency "apr-util"

version "2.4.25" do
  source sha1: "377c62dc6b25c9378221111dec87c28f8fe6ac69"
end

source url: "http://apache.osuosl.org/httpd/httpd-#{version}.tar.gz"

relative_path "httpd-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  config_command = [
    "--with-z=#{install_dir}/embedded",
    "--with-ssl=#{install_dir}/embedded",
    "--with-nghttp2=#{install_dir}/embedded",
    "--with-apr=#{install_dir}/embedded",
    "--with-apr-util=#{install_dir}/embedded",
    "--with-program-name=apache2",
    "--enable-pie",
    "--enable-mods-shared=most",
    "--enable-mpms-shared=all"
  ]

  configure(*config_command, env: env)
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
