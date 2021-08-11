---
layout: post
title: Ubuntu下使用tune2fs修改分区的uuid.md
categories: [ cm, linux ]
tags: [e2fsck, disk, harddisk, partition]
---


* 参考
  * [askubuntu.com - How do I change UUID of a disk to whatever I want?](https://askubuntu.com/a/132087)
  * [CentOS / RHEL : How to change the UUID of the filesystem](https://www.thegeekdiary.com/centos-rhel-how-to-change-the-uuid-of-the-filesystem/)
  * [How to change disk partition UUID in Linux](https://www.simplified.guide/linux/disk-uuid-set)
  * []()


1. 先执行 `e2fsck -f` 之后才允许执行 `tune2fs`，否则会报错：`This operation requires a freshly checked filesystem`
    `sudo e2fsck -f /dev/{device}`
1. 修改 uuid
    * 直接指定UUID
      `tune2fs /dev/{device} -U {uuid}`
    * 或者 随机生成UUID
      `tune2fs /dev/{device} -U random`
1. 













