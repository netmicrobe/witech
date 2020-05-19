---
layout: post
title: 在Linux上支持exfat文件格式
categories: [cm, linux]
tags: [exfat, nofuse]
---

* 参考： 
  * [arter97/exfat-linux - github](https://github.com/arter97/exfat-linux)
  * [dorimanx/exfat-nofuse - github](https://github.com/dorimanx/exfat-nofuse)
  * []()













## 参考

### Mint 19.3 自带 exfat-fuse

~~~
$ apt list --installed | grep xfat

exfat-fuse/bionic,now 1.2.8-1 amd64 [installed]
exfat-utils/bionic,now 1.2.8-1 amd64 [installed]
~~~

~~~
$ apt show exfat-fuse exfat-utils
Package: exfat-fuse
Version: 1.2.8-1
Priority: optional
Section: universe/otherosfs
Source: fuse-exfat
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Sven Hoexter <hoexter@debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 69.6 kB
Depends: libc6 (>= 2.14), libfuse2 (>= 2.6), fuse
Recommends: exfat-utils
Homepage: https://github.com/relan/exfat
Task: ubuntukylin-desktop, ubuntu-mate-core, ubuntu-mate-desktop
Supported: 3y
Download-Size: 24.5 kB
APT-Manual-Installed: yes
APT-Sources: http://mirrors.aliyun.com/ubuntu bionic/universe amd64 Packages
Description: read and write exFAT driver for FUSE
 fuse-exfat is a read and write driver implementing
 the extended file allocation table as a filesystem in userspace.
 A mounthelper is provided unter the name mount.exfat-fuse.

Package: exfat-utils
Version: 1.2.8-1
Priority: optional
Section: universe/otherosfs
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Sven Hoexter <hoexter@debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 204 kB
Depends: libc6 (>= 2.14)
Recommends: exfat-fuse
Homepage: https://github.com/relan/exfat
Task: ubuntukylin-desktop, ubuntu-mate-core, ubuntu-mate-desktop
Supported: 3y
Download-Size: 39.9 kB
APT-Manual-Installed: yes
APT-Sources: http://mirrors.aliyun.com/ubuntu bionic/universe amd64 Packages
Description: utilities to create, check, label and dump exFAT filesystem
 Utilities to manage extended file allocation table filesystem.
 This package provides tools to create, check and label the
 filesystem. It contains
  - dumpexfat to dump properties of the filesystem
  - exfatfsck / fsck.exfat to report errors found on a exFAT filesystem
  - exfatlabel to label a exFAT filesystem
  - mkexfatfs / mkfs.exfat to create a exFAT filesystem.
~~~

