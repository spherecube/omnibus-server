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
default_version "3.15.2"

license "public-domain"
license_file "sqlite3.c"

version "3.15.2" do
  source url: "https://sqlite.org/2016/sqlite-autoconf-3150200.tar.gz"
  source sha1: "31f52169bcfeef9efb61480d0950e928ad059552"
  relative_path "sqlite-autoconf-3150200"
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
