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

name "apr-util"
default_version "1.5.4"

license "Apache-2.0"
license_file "COPYING"

version "1.5.4" do
  source sha256: "976a12a59bc286d634a21d7be0841cc74289ea9077aa1af46be19d1a6e844c19"
end

source url: "http://apache.osuosl.org/apr/apr-util-#{version}.tar.gz"

dependency "libiconv"
dependency "sqlite3"

relative_path "apr-util-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  config_command = [
    "--with-apr=#{install_dir}/embedded",
    "--with-crypto",
    "--with-openssl=#{install_dir}/embedded",
    "--with-iconv=#{install_dir}/embedded",
    "--with-sqlite3=#{install_dir}/embedded",
    "--without-odbc",
    "--without-sqlite2",
    "--with-expat=builtin"
  ]

  configure(*config_command, env: env)
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
