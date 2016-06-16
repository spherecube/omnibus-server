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

name "sqlite3"
default_version "3.13.0"

license "apache2"
license_file "COPYING"

version "3.13.0" do
  source url: "https://sqlite.org/2016/sqlite-autoconf-3130000.tar.gz"
  source sha1: "f6f76e310389e3f510b23826f805850449ae8653"
  relative_path "sqlite-autoconf-3130000"
end


build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  config_command = [
    "--disable-readline",
    "--enable-editline"
  ]

  configure(*config_command, env: env)
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
