---
layout: post
title: 创建可以引导mac book pro 2018 的 linux live usb
categories: [cm, linux]
tags: [mac, mbp, bootable, usb]
---

* 参考： 
  * [Mac Linux USB Loader官网](https://www.sevenbits.io/mlul/)
    这个工具要 4.99 刀，也可以从 [github - Mac-Linux-USB-Loader](https://github.com/SevenBits/Mac-Linux-USB-Loader) 下载源码编译运行。
  * []()


1. 应用程序 》 实用工具 》磁盘工具（Disk Utility）
2. 插入U盘，在 `Disk Utility`中选中U盘，点击“抹掉”，格式=“MS-DOS(FAT)” （fdisk里面识别的格式：b - W95 FAT32）
3. 双击`mac_linux_usb_loader.pkg` 安装 mac-linux-usb-loader 工具，安装好后，在“应用程序”里面找到app启动，一个小企鹅图标
4. 选择 第一个功能，创建演示U盘，选择iso，选择U盘，一路下一步，就好了。
5. 关闭mac，启动mac时安装Option键，就会出现启动盘选择界面了。









