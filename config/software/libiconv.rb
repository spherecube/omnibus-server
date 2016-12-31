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

name "libiconv"
default_version "1.14"

license "LGPL-2.1"
license_file "COPYING.LIB"

dependency "config_guess"

source url: "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-#{version}.tar.gz",
       sha256: "72b24ded17d687193c3366d0ebe7cde1e6b18f0df8c55438ac95be39e8a30613"

relative_path "libiconv-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path, bfd_flags: true)

  update_config_guess(target: "build-aux")
  update_config_guess(target: "libcharset/build-aux")

  patch source: "libiconv-1.14_srclib_stdio.in.h-remove-gets-declarations.patch", env: env

  configure(env: env)

  pmake = "-j #{workers}"
  make "#{pmake}", env: env
  make "#{pmake} install-lib" \
          " libdir=#{install_dir}/embedded/lib" \
          " includedir=#{install_dir}/embedded/include", env: env
end
