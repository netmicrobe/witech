---
layout: post
title: manjaro-grub2.06-无法搜索出Windows系统，关联 dual boot, 双系统, arch linux, gparted
categories: [ cm ]
tags: []
---

* 参考
  * [GParted, Partition, and Filesystem Flags](https://www.linux.org/threads/gparted-partition-and-filesystem-flags.11640/)
  * [Grub don’t show Windows 10 entry](https://forum.manjaro.org/t/grub-dont-show-windows-10-entry/112191/7)
  * [After update, grub doesn’t find windows install](https://forum.manjaro.org/t/after-update-grub-doesnt-find-windows-install/56899)
  * <https://www.gnu.org/software/parted/manual/html_node/set.html>


 
## 问题

在 manjaro 21.3 上使用 grub2.06，`update-grub` 的时候无法识别 Windows 系统。

## 分析

Manjaro 利用 `os-prober` 搜索出 Windows 系统。

因为安全问题， grub 2.06 默认禁用 `os-prober`，所以首先要打开 `os-prober`。

`os-prober` 扫描不到Windows 系统，也可能是flag不对，而被它忽略了：
ESP分区的flag，需要是  `boot`, `esp` ，而不是 `bios_grub`；有时候Windows安装的时候，还给ESP分区加了个 `hidden`的flag，也可能导致问题。

## 解决

### 启用 `os-prober`

编辑 `/etc/default/grub` 设置 `GRUB_DISABLE_OS_PROBER=false`

~~~sh
# Uncomment this option to enable os-prober execution in the grub-mkconfig command
GRUB_DISABLE_OS_PROBER=false
~~~

执行 `update-grub` 看到 `os-prober will be executed to detect other bootable partitions.`，说明 `os-prober` 被启用。

### 修改 ESP 分区的 flag
 
但是，如果还是看不到 `Found Windows Boot Manager` ，说明 `os-prober` 还是没有找到 Windows 系统。

打开 GParted，检查 ESP 分区的 flag，如果是 `bios_grub`，则要改成 `boot`, `esp`

1. 使用 U盘引导到带有GParted 的 linux 系统
1. 启动 `GParted` ，选中 ESP 分区，右键菜单，选 `Manage Flags`
1. 勾选 `boot`, `esp`，勾掉 `bios_grub`
1. 重启系统再执行 `update-grub`



































































