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

name "libev"
default_version "4.22"

license "BSD"
license_file "LICENSE"

dependency "config_guess"

source url: "http://dist.schmorp.de/libev/Attic/libev-#{version}.tar.gz",
       sha256: "41bee4a874b939ceeeb8453742d80ad71172dcfcb2d9632e9e1fbdaac43b6a2a"

relative_path "libev-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path, bfd_flags: true)

  configure(env: env)

  pmake = "-j #{workers}"
  make "#{pmake}", env: env
  make "#{pmake} install-lib" \
          " libdir=#{install_dir}/embedded/lib" \
          " includedir=#{install_dir}/embedded/include", env: env
end
