---
layout: post
title: manjaro使用openzfs文件系统，关联 arch linux, file system
categories: [ cm, linux ]
tags: []
---

* 参考
  * [导入 ZFS 存储池](https://docs.oracle.com/cd/E19253-01/819-7065/gazuf/index.html)
  * []()
  * []()


## zfs 安装

许可证的问题，linux 不会自带 zfs 支持。

arch linux， manjaro 安装：

~~~sh
sudo pacman -S zfs-dkms
~~~


## 将zfs格式的磁盘挂载

### udev 类型为 strip，没有组阵列的，单独一个zfs磁盘

1. 列出可用的pool： `sudo zpool import`
1. 挂载pool： `sudo zpool import -f your-pool-name`
    一般挂载目录在根目录： `/your-pool-name/your-dataset-name`
1. 查看状态： `zpool status`
1. 查看可用的dataset： `zfs list`
1. ---
1. 写在pool： `sudo zpool export -f your-pool-name`















