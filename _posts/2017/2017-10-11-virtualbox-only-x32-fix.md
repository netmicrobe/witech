---
layout: post
title: 如何解决：在 64bit 的Windows 系统上 VirtualBox 只支持 32bit 的虚拟机
categories: [cm, virtualization]
tags: [linux, virtualize, virtualbox ]
---

* 参考
  * [Why is VirtualBox only showing 32 bit guest versions on my 64 bit host OS?](http://www.fixedbyvonnie.com/2014/11/virtualbox-showing-32-bit-guest-versions-64-bit-host-os/#.Wd3QuikRXIV)



### 问题现象

![](virtualbox-32-bit-only.png)


### 解决方法

* BIOS 》Security 》Intel Virtualization Technology : Enabled
* BIOS 》Security 》Intel VT-d Feature : Enabled

![](thinkpad-setup-bios-vt-d.jpg)















