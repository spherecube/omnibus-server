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
       sha256: "736079e8ac543c74d59af73f9c52737b3bfec9601f020bf25a87a4f4d0f01bd6"

relative_path "libev-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path, bfd_flags: true)

  configure env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install"

end
