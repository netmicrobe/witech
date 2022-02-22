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


## 安装 exfat-nofuse

* 测试可用，三星T5 的 exfat 格式比 exfat-fuse 快，exfat-fuse上的虚拟机很慢：
  * manjaro 21.2.3
  * linux mx 19.4

1. 卸载 exfat-fuse
    ``
1. 编译安装 https://github.com/relan/exfat

    安装依赖包

    ~~~
    # linux mx 19.4
    sudo apt install -y git autoconf automake pkg-config libfuse-dev gcc make
    ~~~

    下载&编译

    ~~~
    git clone https://github.com/relan/exfat.git
    cd exfat
    autoreconf --install
    ./configure
    make
    ~~~
    
    安装
    
    ~~~
    sudo make install
    ~~~
    
1. 编译安装 https://github.com/arter97/exfat-linux/
    ~~~bash
    git clone https://github.com/arter97/exfat-linux
    cd exfat-linux
    make
    sudo make install

    # 5.4以上的kernel，重启下再执行下面

    sudo modprobe exfat

    # 检查module

    lsmod | grep exfat
    ~~~

1. `/etc/fstab` 配置
~~~
UUID=C747-899C /Volumes/somedir exfat rw,nofail,nosuid,nodev,relatime,uid=1000,gid=1000,fmask=0022,dmask=0022,iocharset=utf8,errors=remount-ro  0  0
~~~







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

