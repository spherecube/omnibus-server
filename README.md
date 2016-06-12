!WIP! PROBABLY DOESN'T WORK YET

The Omnibus Server project
==========================
This project creates full-stack platform-specific packages for the following projects:

* Apache
* OpenSSH

These packages are meant to replace the ones provided by your distribution, giving you the latest release of those projects and their major dependencies without replacing core libraries (like OpenSSL or zlib) for the rest of your system. These packages allow for you to implement the latest standards and technologies (like TLS 1.2 with PFS, HTTP/2 with ALPN and NPN, etc) without breaking the rest of your system's binaries.

Apache Modules
----------------

The Apache that is shipped with this project includes all of the 1st party modules included with the main Apache release. Third party modules which have minimal external dependencies will be accepted through contributions. Third party modules which have large external dependencies (like mod_php, mod_perl2, mod_python, mod_wsgi, and mod_passenger) will not be included. Applications requiring those modules should instead take advantage of mod_proxy_ajp, mod_proxy_fcgi, mod_proxy_scgi, or mod_proxy_http. The tools (apxs, et al) are provided for end users to build their own modules later if needed by legacy applications.

Supported Platforms/Distributions
-------------------------------------

CentOS 5 on x86 and x86_64
CentOS 7 on x86_64
Debian 8 on x86_64, armhf, and arm64

Installation
------------
You must have a sane Ruby 2.1.2+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ bundle install --without development
```

Usage
-----
### Build

You create a platform-specific package using the `build project` command:

```shell
$ bundle exec omnibus build <PROJECT>
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. For example, running this command
on a MacBook Pro will generate a Mac OS X package. After the build completes
packages will be available in the `pkg/` folder.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bundle exec omnibus clean <PROJECT>
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/chef`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bundle exec omnibus clean <PROJECT> --purge
```

### Publish

Omnibus has a built-in mechanism for releasing to a variety of "backends", such
as Amazon S3 and Artifactory. You must set the proper credentials in your `omnibus.rb`
config file or specify them via the command line.

```shell
$ bundle exec omnibus publish path/to/*.deb --backend s3
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bundle exec omnibus help
```

Kitchen-based Build Environment
-------------------------------
Every Omnibus project ships will a project-specific
[Berksfile](http://berkshelf.com/) that will allow you to build your omnibus projects on all of the projects listed
in the `.kitchen.yml`. You can add/remove additional platforms as needed by
changing the list found in the `.kitchen.yml` `platforms` YAML stanza.

This build environment is designed to get you up-and-running quickly. However,
there is nothing that restricts you to building on other platforms. Simply use
the [omnibus cookbook](https://github.com/opscode-cookbooks/omnibus) to setup
your desired platform and execute the build steps listed above.

The default build environment requires Test Kitchen and VirtualBox for local
development. Test Kitchen also exposes the ability to provision instances using
various cloud providers like AWS, DigitalOcean, or OpenStack. For more
information, please see the [Test Kitchen documentation](http://kitchen.ci).

Once you have tweaked your `.kitchen.yml` (or `.kitchen.local.yml`) to your
liking, you can bring up an individual build environment using the `kitchen`
command.

```shell
$ bundle exec kitchen converge <PROJECT>-ubuntu-1204
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login <PROJECT>-ubuntu-1204
[vagrant@ubuntu...] $ cd omnibus-chef
[vagrant@ubuntu...] $ bundle install --without development # Don't install dev tools!
[vagrant@ubuntu...] $ ...
[vagrant@ubuntu...] $ bundle exec omnibus build <PROJECT> -l internal
```

You can also login to Windows instances but will have to manually call the
`load-omnibus-toolchain.bat` script which initializes the build environment.
Please note the mounted code directory is also at `C:\home\vagrant\omnibus-chef`
as opposed to `C:\Users\vagrant\omnibus-chef`.

```shell
$ bundle exec kitchen login <PROJECT>-windows-81-professional
Last login: Sat Sep 13 10:19:04 2014 from 172.16.27.1
Microsoft Windows [Version 6.3.9600]
(c) 2013 Microsoft Corporation. All rights reserved.

C:\Users\vagrant>load-omnibus-toolchain.bat

C:\Users\vagrant>cd C:\home\vagrant\omnibus-chef

C:\home\vagrant\omnibus-chef>bundle install --without development

C:\home\vagrant\omnibus-chef>bundle exec omnibus build <PROJECT> -l internal
```

For a complete list of all commands and platforms, run `kitchen list` or
`kitchen help`.

License
-------
```text
Copyright 2012-2014 Chef Software, Inc.
Copyright 2016 Sphere Cube, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
