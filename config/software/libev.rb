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
default_version "4.24"

license "BSD-2-Clause"
license_file "LICENSE"

dependency "config_guess"

source url: "http://dist.schmorp.de/libev/Attic/libev-#{version}.tar.gz",
       sha256: "973593d3479abdf657674a55afe5f78624b0e440614e2b8cb3a07f16d4d7f821"

relative_path "libev-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path, bfd_flags: true)

  configure env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install"

end
