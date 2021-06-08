---
layout: post
title: centos7支持ntfs格式
categories: [cm, linux, centos]
tags: [ntfs, fuse]
---

* 参考
    * [How to Enable NTFS Support on CentOS 7](https://manjaro.site/how-to-enable-ntfs-support-on-centos-7/)
    * [NTFS Support on CentOS 7](https://bytefreaks.net/gnulinux/ntfs-support-on-centos-7)
    * [How to Mount a NTFS Drive on CentOS / RHEL / Scientific Linux](https://www.howtoforge.com/tutorial/mount-ntfs-centos/)
    * []()

1. 安装 ntfs-3g, fuse
    ~~~
    yum install -y epel-release
    yum install -y ntfs-3g fuse
    ~~~
1. 重启系统

1. mount 测试 `mount /dev/sdb1 /mnt/ntfs-disk`

1. 自动挂载
    修改 `/etc/fstab`
    ~~~
    UUID=xxxx      /mnt/ntfs-disk      ntfs-3g rw,umask=0000,defaults 0 0
    ~~~
    UUID 用 `lsblk -f` 查看





