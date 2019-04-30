---
layout: post
title: 硬盘、外置存储相关知识
categories: [hardware]
tags: [hardware, 硬件, disk, ssd, block, dd]
---

* 参考： 
  * []()
  * []()



## 磁盘信息获取

* ref
  * <https://www.linuxnix.com/find-block-size-linux/>

### `lsblk` 获取硬盘和分区列表

### `blockdev` 获取磁盘的 block size

~~~
blockdev --getbsz partition
~~~

Example, 4K的block size

~~~
# blockdev --getbsz /dev/sda1 
4096
~~~


## 磁盘备份和恢复


<https://askubuntu.com/a/563946>

~~~
partclone.ntfs -b -N -s /dev/sda3 -o /dev/sdb3
~~~

Partclone puked on the ntfs needing chkdisk run in Windows, so a quick fix got partclone happy:

~~~
ntfsfix -b /dev/sda3
ntfsfix -d /dev/sda3
~~~

[dd命令的conv=fsync,oflag=sync/dsync](https://blog.csdn.net/menogen/article/details/38059671)

[Full Metal Backup Using the dd Command](https://www.linux.com/learn/full-metal-backup-using-dd-command)



















