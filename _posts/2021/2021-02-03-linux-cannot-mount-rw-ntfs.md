---
layout: post
title: ntfs分区加载失败，不可写，只能读
categories: [cm, linux]
tags: [ntfs, hibernation, mount, fstab]
---

* 参考： 
  * [Fast Startup - Turn On or Off in Windows 8.](www.eightforums.com/tutorials/6320-fast-startup-turn-off-windows-8-a.html)
  * [Unable to mount Windows (NTFS) filesystem due to hibernation](https://askubuntu.com/a/145904)
  * []()
  * []()
  * []()
  * []()


### 问题现象

linux下ntfs分区加载失败，不可写，只能读

~~~
The NTFS partition is in an unsafe state. Please resume and shutdown
Windows fully (no hibernation or fast restarting), or mount the volume
read-only with the ‘ro’ mount option.
~~~

~~~
$ sudo mount -a
The disk contains an unclean file system (0, 0).
Metadata kept in Windows cache, refused to mount.
Falling back to read-only mount because the NTFS partition is in an
unsafe state. Please resume and shutdown Windows fully (no hibernation
or fast restarting.)
Could not mount read-write, trying read-only
~~~

### 解决办法

一般都发生在安装Windows 10 / Linux 双系统的机器上。

Windows 10 对 ntfs 分区有快速启动都优化操作，被linux ntfs-3g 认为非正常关闭，数据完整性不能保障。

1. 进入Windows 》 设置 》电源选项 》 其他电源设置 》 选择电源按钮的功能
1. 更改当期不可用的设置 》不勾选 启用快速启动（推荐）


1. Open Control Panel in the small icons view and click on Power Options. (see screenshot 1)
1. Click on Choose what the power buttons do. (see screenshot 2)
1. Click on Change settings that are currently unavailable. (see screenshot 3)
1. Uncheck Turn on fast startup (recommended). (see screenshot 4)








