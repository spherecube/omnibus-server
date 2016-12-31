#
# Copyright 2012-2016 Chef Software, Inc.
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

name "openssl"

license "OpenSSL"
license_file "LICENSE"

dependency "makedepend"

source url: "https://www.openssl.org/source/openssl-#{version}.tar.gz", extract: :lax_tar

version("1.1.0c") { source sha256: "fc436441a2e05752d31b4e46115eb89709a28aef96d4fe786abe92409b2fd6f5"}
version("1.0.2j") { source sha256: "e7aff292be21c259c6af26469c7a9b3ba26e9abaaffd325e3dccc9785256c431"}

relative_path "openssl-#{version}"

build do

  env = with_standard_compiler_flags(with_embedded_path({}, msys: true), bfd_flags: true)

  configure_args = [
    "--prefix=#{install_dir}/embedded",
    "no-idea",
    "no-mdc2",
    "no-rc2",
    "no-rc4",
    "no-rc5",
    "shared",
    "no-ssl",
    "no-ssl2",
    "no-ssl3",
    "no-ssl3-method",
    "enable-unit-test",
    "enable-rfc3779",
    "enable-cms",
    "no-zlib"
  ]

  configure_cmd =
    prefix =
      if linux? && ppc64?
        "./Configure linux-ppc64"
      elsif linux? && ohai["kernel"]["machine"] == "s390x"
        "./Configure linux64-s390x"
      else
        "./config"
      end

  # Out of abundance of caution, we put the feature flags first and then
  # the crazy platform specific compiler flags at the end.
  configure_args << env["CFLAGS"] << env["LDFLAGS"]

  configure_command = configure_args.unshift(configure_cmd).join(" ")

  command configure_command, env: env, in_msys_bash: true
  make "depend", env: env
  # make -j N on openssl is not reliable
  make "", env: env
  make "install", env: env
end
