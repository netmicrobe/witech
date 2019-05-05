---
layout: post
title: linux mint 19.1 连接 Android 手机
categories: [cm, linux]
tags: [mint, android, gvfs, mtp]
---

* 参考： 
  * [Where are MTP mounted devices located in the filesystem?](https://askubuntu.com/a/585675)


1. 手机连接电脑后，选择MTP模式
2. 文件系统挂载在 `/run/user/$UID/gvfs/mtp*` 一般个人电脑 `$UID` 是 1000
    例如：`$ cd /run/user/1000/gvfs/mtp\:host=%5Busb%3A001%2C006%5D/`








