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

name "ncurses"
default_version "6.0"

license "MIT"
license_file "http://invisible-island.net/ncurses/ncurses-license.html"
license_file "http://invisible-island.net/ncurses/ncurses.faq.html"

dependency "config_guess"

version("6.0") { source sha256: "f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260", url: "https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz" }

relative_path "ncurses-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  env.delete("CPPFLAGS")

  patch source: "ncurses-5.9-gcc-5.patch", env: env

  config_command = [
    "--enable-overwrite",
    "--with-shared",
    "--with-termlib",
    "--without-ada",
    "--without-cxx-binding",
    "--without-debug",
    "--without-manpages",
  ]

  configure(*config_command, env: env)

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env

end
