---
layout: post
title: efi方式安装manjaro 和 windows 双系统
categories: [cm, manjaro]
tags: [ linux, uefi, rufus ]
---

* 参考： 
  * [UEFI安装win10+manjaro双系统](https://blog.nowcoder.net/n/1274dc137b8a4137b1e516b825f7efe0)
  * []()
  * []()


### rufus创建启动盘

* rufus 3.14p 无法将 manjaro 21 的iso制作为 EFI 启动盘
* rufus 3.5p 可以
  * 分区类型： GPT
  * 目标系统： UEFI（非CSM）
  * 文件系统： FAT32
  * 点击开始，弹出对话框，选择 `以DD镜像模式写入`



