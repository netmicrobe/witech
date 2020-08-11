---
layout: post
title: virtualbox-虚拟机通过USB调试android设备
categories: [cm, virtualbox]
tags: [adb]
---

* 参考： 
  * [forums.virtualbox.org - #2: Capturing a USB device in VirtualBox](https://forums.virtualbox.org/viewtopic.php?f=35&t=82639#p390399)
  * []()


## Linux host

在linux系统上运行virtualbox，要将当前用户加入 `vboxusers` 组，才能在虚拟机的USB设置看到usb设备。

`sudo usermod -a -G vboxusers $(whoami)`



## Android 手机设置

### 小米手机

除了要开启 USB调试，还要开启 `USB调试（安全设置）`

设置 –》 更多设置 –》 开发者选项 –》USB调试（安全设置）

否则，会报错： `requires INJECT_EVENTS permission`








