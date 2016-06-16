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

name "apr"
default_version "1.5.2"

license "Apache-2.0"
license_file "COPYING"

version "1.5.2" do
  source sha256: "1af06e1720a58851d90694a984af18355b65bb0d047be03ec7d659c746d6dbdb"
end

source url: "http://apache.osuosl.org/apr/apr-#{version}.tar.gz"

relative_path "apr-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  config_command = [
    "--enable-threads"
  ]

  configure(*config_command, env: env)
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
