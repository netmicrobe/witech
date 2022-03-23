---
layout: post
title: 降级-Ubuntu-20-的kernel版本到5.4, 关联 linux-image, linux-headers, grub
categories: [cm, linux]
tags: []
---

* 参考
  * [How to downgrade the kernel on Ubuntu 20.04 to the 5.4 (LTS) version](https://discourse.ubuntu.com/t/how-to-downgrade-the-kernel-on-ubuntu-20-04-to-the-5-4-lts-version/26459)
  * [How to Change the Default Ubuntu Kernel](https://meetrix.io/blog/aws/changing-default-ubuntu-kernel.html)
  * [How to change default kernel in Ubuntu 22.04 | 20.04 LTS](https://www.how2shout.com/linux/how-to-change-default-kernel-in-ubuntu-22-04-20-04-lts/)
  * [Check and Update Ubuntu Kernel Version on Ubuntu 20.04](https://linuxhint.com/update_ubuntu_kernel_20_04/)
  * []()




1. 安装 5.4 kernel
    ~~~sh
    sudo apt install linux-image-5.4.0-104-generic linux-headers-5.4.0-104-generic
    ~~~
1. 检查grub 菜单项
    ~~~sh
    sudo grep 'menuentry \|submenu ' /boot/grub/grub.cfg | cut -f2 -d "'"
    ~~~
1. 根据grub菜单结构，修改 `/etc/default/grub` 的启动项
    `GRUB_DEFAULT=0` 改为
    ~~~sh
    GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 5.4.0-104-generic"
    ~~~
1. 更新grub并重启
    ~~~sh
    sudo update-grub
    sudo reboot
    ~~~
1. 重启后，检查是否是 5.4 kernel ： `uname -r`







