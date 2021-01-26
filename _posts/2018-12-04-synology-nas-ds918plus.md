---
layout: post
title: 使用 Synology 群晖DS918+
categories: [ cm, nas ]
tags: [synology, nas]
---

参考
* [群晖中文官网](https://www.synology.cn/zh-cn/dsm/)
* [群晖DS918+](https://www.synology.cn/zh-cn/support/download/DS918+)
* []()
* []()


## 传输文件

* Samba
* FTP
* 网页登陆，打开File Station，拖动文件到File Station的目录中。速度挺慢。
* Hyper Backup 上传。速度尚可。文件会在 Driver/Backup/Your-PC-Name/...
* Drive 同步。速度不行，界面丑陋，可用性差。

目前看，还是 samba 最快，适合内网。
外网应该FTP最快，但目前尚未研究如何用。







## 常见问题

### Windows 连接不上 群晖 Samba，报错 0x80070035找不到网络路径

#### 原因1：被防火墙挡住了139、445端口

没啥好办法，病毒喜欢这个端口，Windows的samba客户端又不能改端口。
目前，只能要用到时候防火墙开放这些端口，用完再关闭。






## 命令行

可以使用ssh远程登录，设置： 控制面板 》终端机和SNMP 》终端机 》 勾选“启动SSH功能”

使用Synology上的帐号就可以登录。home目录为 `/volume1/homes/wi` ，等效路径为 `/var/services/homes/wi`

bashrc 的位置为：
* `/etc.defaults/profile `
* `/etc.defaults/.bashrc_profile `
* `~/.bashrc`




