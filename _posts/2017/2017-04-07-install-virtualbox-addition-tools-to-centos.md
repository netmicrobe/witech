---
layout: post
title: 在 virtualbox 的 centos 上安装virtualbox工具包
categories: [cm, virtualbox]
tags: [virtualbox, centos]
---

* 参考
  *[VirtualBox Guest Additions on Fedora 25/24, CentOS/RHEL 7.3/6.8/5.11](https://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/)

## CentOS 6.8 安装工具包

```
yum groupinstall "Development Tools"

KERN_DIR=/usr/src/kernels/`uname -r`
export KERN_DIR

cd /media/VirtualBoxGuestAdditions
./VBoxLinuxAdditions.run
```

* 正确安装的提示

```
[root@localhost VBOXADDITIONS_5.1.18_114002]# ./VBoxLinuxAdditions.run 
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.1.18 Guest Additions for Linux...........
VirtualBox Guest Additions installer
Removing installed version 5.1.18 of VirtualBox Guest Additions...
vboxadd.sh: Stopping VirtualBox Additions.
Copying additional installer modules ...
Installing additional modules ...
vboxadd.sh: Building Guest Additions kernel modules.
Failed to set up service vboxadd, please check the log file
/var/log/VBoxGuestAdditions.log for details.
[root@localhost VBOXADDITIONS_5.1.18_114002]# rpm -ql kernel-devel-2.6.32-696.el6.i686 | less
[root@localhost VBOXADDITIONS_5.1.18_114002]# export KERN_DIR
[root@localhost VBOXADDITIONS_5.1.18_114002]# ./VBoxLinuxAdditions.run 
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.1.18 Guest Additions for Linux...........
VirtualBox Guest Additions installer
Removing installed version 5.1.18 of VirtualBox Guest Additions...
vboxadd.sh: Stopping VirtualBox Additions.
Copying additional installer modules ...
Installing additional modules ...
vboxadd.sh: Building Guest Additions kernel modules.
vboxadd.sh: Starting the VirtualBox Guest Additions.

You may need to restart the Window System (or just restart the guest system)
to enable the Guest Additions.

```
