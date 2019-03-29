---
layout: post
title: 为manjaro制作安装启动盘 create bootable usb stick for linux manjaro
categories: [cm, linux]
tags: [manjaro, UNetbootin, balenaEtcher]
---

* 参考： 
  * [How To Create A Bootable Manjaro Linux USB Drive](http://dailylinuxuser.com/2018/09/how-to-create-a-bootable-manjaro-linux-usb-drive.html)
  * [3 Easy Ways To Create Bootable USB Media From ISO In Ubuntu Linux](https://fossbytes.com/create-bootable-usb-media-from-iso-ubuntu/)
  * [UNetbootin](https://unetbootin.github.io/)
  * [How to Create Bootable USB Disk / DVD on Ubuntu / Linux Mint](https://www.linuxtechi.com/create-bootable-usb-disk-dvd-ubuntu-linux-mint/)



## balenaEtcher

* 官网: <https://www.balena.io/etcher/>
* Linux、Windows、MacOS 都可以运行。
* 下载地址： <https://github.com/balena-io/etcher/releases>


### 在 Mint 上使用

1. 下载 [balena-etcher-electron_1.5.15_amd64.deb](https://github.com/balena-io/etcher/releases/download/v1.5.15/balena-etcher-electron_1.5.15_amd64.deb)
1. 在mint上安装deb包
1. 系统菜单搜索“balenaEtcher”并启动
1. 按照 Etcher 的帮助，选iso文件 -\> 选u盘 -\> 写u盘 
    注意!!! 这一步要小心，把移动硬盘什么的拔掉，只留下要制作启动盘的u盘







