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

dependency "zlib"
dependency "makedepend"

source url: "https://www.openssl.org/source/openssl-#{version}.tar.gz", extract: :lax_tar

version("1.0.2h") { source sha256: "1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919"}

relative_path "openssl-#{version}"

build do

  env = with_standard_compiler_flags(with_embedded_path({}, msys: true), bfd_flags: true)

  configure_args = [
    "--prefix=#{install_dir}/embedded",
    "--with-zlib-lib=#{install_dir}/embedded/lib",
    "--with-zlib-include=#{install_dir}/embedded/include",
    "no-idea",
    "no-mdc2",
    "no-rc5",
    "shared",
    "zlib"
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
    "#{prefix} disable-gost"

  #patch source: "openssl-1.0.1f-do-not-build-docs.patch", env: env

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
