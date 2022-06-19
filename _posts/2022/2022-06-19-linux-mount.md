---
layout: post
title: Linux 使用 mount，关联 挂载, fstab, ntfs, exfat
categories: [cm, linux]
tags: []
---

* 参考： 
  * [mount.ntfs-3g(8) - Linux man page](https://linux.die.net/man/8/mount.ntfs-3g)
  * []()
  * []()



## remount

~~~sh
# cdrom 上文件无法执行脚本，检查是否mount时，设置了 “noexec” 选项，重新挂载一下就好：

mount -o remount,ro,exec /media/cdrom
~~~

## 挂载ext4

1. 注意提前挂载点：`sudo mkdir /your-mount-point`
2. 编辑 `/etc/fstab`
    ~~~
    # <file system>   <dir>		<type>    <options>             <dump>  <pass>
    # /dev/sda1
    UUID=通过“lsblk -f”和“fdisk -l”来获得  /your-mount-point   ext4    defaults,noatime 0 0  
    ~~~
3. ext4 系统自带owner、gid、uid信息，创建filesystem的时候就存在，fstab文件中指定 uid、gid、fmask、dmask，都是没有用的，会导致系统启动失败。

## 挂载ntfs （使用 ntfs-3g）

1. 注意提前挂载点：
    ~~~
    sudo mkdir /mnt/windows
    sudo chown your-account:your-group /mnt/windows
    ~~~
1. 编辑 `/etc/fstab`
    ~~~
    # <file system>   <dir>		<type>    <options>             <dump>  <pass>
    /dev/NTFS-partition  /mnt/windows  ntfs-3g   defaults,noatime,uid=username,gid=users,umask=0022,locale=zh_CN.utf8    0 0
    ~~~

## 挂载exfat

1. 注意提前挂载点：
    ~~~
    sudo mkdir /Volumes/your-exfat-partition
    sudo chown your-account:your-group /Volumes/your-exfat-partition
    ~~~
1. 编辑 `/etc/fstab`，此处使用的是：  `aur/exfat-linux-dkms`
    ~~~
    # <file system>   <dir>		<type>    <options>             <dump>  <pass>
    UUID=通过“lsblk -f”和“fdisk -l”来获得             /Volumes/your-exfat-partition   exfat    rw,nosuid,nodev,relatime,uid=1000,gid=1000,fmask=0022,dmask=0022,iocharset=utf8,errors=remount-ro  0  0
    ~~~










