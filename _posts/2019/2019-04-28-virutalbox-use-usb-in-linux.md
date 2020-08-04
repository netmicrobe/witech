---
layout: post
title: linux 上的 virtualbox 使用系统的USB设备
categories: [cm, linux]
tags: [usb, virtualbox]
---

* 参考： 
  * <https://askubuntu.com/a/25600>
  * [How to access USB Drive in VirtualBox guest OS?](https://www.smarthomebeginner.com/access-usb-drive-in-virtualbox-guest-os/)


1. 安装Virutalbox 的 extention package
1. `sudo usermod -aG vboxusers <username>`
1. 重启系统
1. Virutalbox -\> Your VM -\> Settings -\> USB -\> Enable USB Controller
1. “USB Device Filters” 区域 》点击添加按钮








