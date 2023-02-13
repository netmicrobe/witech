---
layout: post
title: exfat-nofuse 安装使用
categories: [cm, linux]
tags: [fcitx, anti-linux]
---

* 参考： 
  * []()
  * []()


## 文件系统

### exfat

#### 在 5.6 kernel 上使用 exfat-nofuse

* 参考
  * <https://github.com/rxrz/exfat-nofuse>
  * <>
  * <>
  * <>

exfat-nofuse是从Android的Linux kernel3.0中移植而来，Android的Linux kernel 3.0上的exFAT驱动是第一个Linux“non-FUSE”kerneldriver，支持对exFAT文件系统进行正常在读取和写入操作，并且是由东家微软开发。

exfat-nofuse在Linuxkernel3.8和3.9中通过测试。

~~~
$ yay -Si exfat-linux-dkms exfat-utils-nofuse
:: Querying AUR...
Repository      : aur
Name            : exfat-utils-nofuse
Keywords        : None
Version         : 1.3.0-3
Description     : Utilities for the exFAT file system without fuse (to prefer exfat kernel module over fuse)
URL             : https://github.com/relan/exfat
AUR URL         : https://aur.archlinux.org/packages/exfat-utils-nofuse
Groups          : None
Licenses        : GPL2
Provides        : exfat-utils
Depends On      : glibc
Make Deps       : None
Check Deps      : None
Optional Deps   : None
Conflicts With  : fuse-exfat  exfat-utils
Maintainer      : freswa
Votes           : 30
Popularity      : 0.226387
First Submitted : Fri 13 Jan 2017 06:36:27 AM CST
Last Modified   : Sun 17 May 2020 10:54:26 AM CST
Out-of-date     : No

Repository      : aur
Name            : exfat-linux-dkms
Keywords        : None
Version         : 5.8_1-1
Description     : This exFAT filesystem module for Linux kernel is based on sdFAT drivers by Samsung, which is used with their smartphone lineups.
URL             : https://github.com/arter97/exfat-linux/
AUR URL         : https://aur.archlinux.org/packages/exfat-linux-dkms
Groups          : None
Licenses        : GPL2
Provides        : None
Depends On      : dkms  exfat-utils-nofuse
Make Deps       : None
Check Deps      : None
Optional Deps   : None
Conflicts With  : exfat  exfat-git
Maintainer      : rdnvndr
Votes           : 3
Popularity      : 0.000002
First Submitted : Sun 15 Sep 2019 06:41:15 PM CST
Last Modified   : Sat 04 Jul 2020 01:12:48 PM CST
Out-of-date     : No
~~~













