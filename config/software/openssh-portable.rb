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

name "openssh-portable"
default_version "7.2p2"

license "BSD-3-Clause"
license_file "LICENCE"

dependency "config_guess"
dependency "zlib"
dependency "openssl"
dependency "libedit"
dependency "ldns"

version "7.2p2" do
  source sha256: "a72781d1a043876a224ff1b0032daa4094d87565a68528759c1c2cab5482548c"
end

source url: "http://openbsd.mirrors.pair.com/OpenSSH/portable/openssh-#{version}.tar.gz"

relative_path "openssh-#{version}"

# This depends on pam and libaudit, so we just whitelist it
whitelist_file "sbin/sshd"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  config_command = [
    "--prefix=#{install_dir}/embedded",
    "--with-zlib=#{install_dir}/embedded",
    "--with-ssl-dir=#{install_dir}/embedded",
    "--with-libedit=#{install_dir}/embedded",
    "--with-ldns=#{install_dir}/embedded",
    "--with-ssl-engine",
    "--with-pie",
    "--with-pam",
    "--with-privsep-user=nobody",
    "--with-privsep-path=#{install_dir}/empty"
  ]

  if rhel?
    config_command << "--with-selinux"
  end

  configure(*config_command, env: env)

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
