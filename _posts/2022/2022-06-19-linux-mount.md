---
layout: post
title: Linux 使用 mount，关联 挂载, fstab, ntfs, exfat
categories: [cm, linux]
tags: []
---

* 参考： 
  * [mount.ntfs-3g(8) - Linux man page](https://linux.die.net/man/8/mount.ntfs-3g)
  * [ArchWiki - fstab (简体中文)](https://wiki.archlinux.org/index.php/Fstab_\(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87\))
  * [ArchWiki - NTFS-3G (简体中文)](https://wiki.archlinux.org/index.php/NTFS-3G_\(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87\))
  * <https://community.linuxmint.com/tutorial/view/1513>
  * [CSDN - Archlinux下实现NTFS分区自动挂载](https://blog.csdn.net/baimaozi/article/details/3134267)
  * [ExFAT with Arch Linux](https://topher1kenobe.com/exfat-with-arch-linux/)
  * [Mounting NTFS on Linux machines](https://teamdynamix.umich.edu/TDClient/47/LSAPortal/KB/ArticleDet?ID=2563)
  * []()
  * []()
  * []()



## 查看磁盘信息

获得UUID

`lsblk -f` 或 `fdisk -l` 或 `sudo blkid`

获取smart信息

`smartctl -i /dev/sda` ， 加上 `--all` 参数会读取所有SMART信息，启动次数、运行时长、读写量等。


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
  UUID=通过“lsblk -f”和“fdisk -l”来获得  /your-mount-point   ext4    defaults,noatime,nofail 0 0  
  ~~~
  
  `nofail` 参数，表示如果系统启动时挂载失败，系统照常启动。
  
3. ext4 系统自带owner、gid、uid信息，创建filesystem的时候就存在，fstab文件中指定 uid、gid、fmask、dmask，都是没有用的，会导致系统启动失败。



## 挂载ntfs （使用 ntfs-3g）

1. 安装 ntfs-3g
    ~~~sh
    # arch linux
    pacman -S ntfs-3g
    
    # centos
    yum install -y epel-release
    yum install -y ntfs-3g fuse
    ~~~
1. 注意提前挂载点：
    ~~~
    sudo mkdir /mnt/windows
    sudo chown your-account:your-group /mnt/windows
    ~~~
1. 编辑 `/etc/fstab`
    ~~~
    # <file system>   <dir>		<type>    <options>             <dump>  <pass>
    /dev/NTFS-partition  /mnt/windows  ntfs-3g   defaults,noatime,nofail,rw,uid=username,gid=users,umask=0022,locale=zh_CN.utf8    0 0
    ~~~
    
    `nofail` 参数，表示如果系统启动时挂载失败，系统照常启动。
    
1. 直接使用命令挂载
* 参考： <https://linux.die.net/man/8/mount.ntfs-3g>

~~~sh
sudo mount -o defaults,noatime,rw,uid=your-name,gid=your-group-name,umask=0022,locale=zh_CN.utf8 -t ntfs-3g /dev/sda1 /Volumes/your-mount-point

# 也可以直接使用 ntfs-3g 命令
ntfs-3g /dev/your_NTFS_partition /mount/point
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










