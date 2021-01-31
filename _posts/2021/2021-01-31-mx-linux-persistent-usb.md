---
layout: post
title: mx-linux-persistent-usb / mx linux 持久化 启动u盘/移动硬盘 制作
categories: [cm, linux]
tags: [persistent, usb, boot]
---

* 参考： 
  * [mxlinux.org - wiki - Boot parameters](https://mxlinux.org/wiki/system/boot-parameters/#Persistence)
  * [Questions about booting with static vs. dynamic persistence](https://forum.mxlinux.org/viewtopic.php?t=57586)
  * [antiX-FAQ - Persistence Options](https://download.tuxfamily.org/antix/docs-antiX-19/FAQ/persistence.html)


1. 使用rufus/etcher制作启动盘，或者在MX Linux中使用 Live USB Creator 工具制作启动盘
    `Live USB Creator`工具选择 Full-feature USB ，而不是 live image
1. 插入USB启动盘，到达MX Linux启动菜单页面。
1. `F5` 选择 Persist 选项
    * `persist_static` 如果是移动SSD，选择这个，在系统运行时的改动直接回写硬盘，这样需要写盘速度快，否则系统会运行很慢。
    * `persist_all` 如果是U盘，写速度慢，这个选项表示运行时写入RAM，关机是回写存储。
1. `F8` 选择 Save，保存设置
1. 启动进MX Linux系统。

















