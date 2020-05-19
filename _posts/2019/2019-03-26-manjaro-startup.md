---
layout: post
title: manjaro 入门使用
categories: [cm, linux]
tags: [manjaro]
---

* 参考： 
  * [Manjaro 上手使用简明教程](https://wenqixiang.com/manjaro-guide/)
  * []()
  * []()




## LXDE

### 屏幕分辨率设置

Application menu -\> Preferences -\> Monitor Settings




## pacman

### 更换为中国国内源

列出国内源，按速度排序

~~~
sudo pacman-mirrors -i -c China -m rank
~~~

更换上新的国内源之后，可以刷新一下缓存，输入

~~~
# -S: Sync packages
# -yy: refresh package database, force refresh even if local database appears up-to-date
sudo pacman -Syy
~~~


## VirutalBox 安装配置

### install through command line

1. To list what kernels is installed use mhwd 
    ~~~
    $ mhwd-kernel -li
    Currently running: 5.6.11-1-MANJARO (linux56)
    The following kernels are installed in your system:
       * linux56
    ~~~
1. install the kernel modules for your installed kernels, here is **linux56**
~~~
sudo pacman -Syu virtualbox linux56-virtualbox-host-modules
~~~
1. 
1. 
1. 
1. 

### install through pamac-manager GUI

1. `Super` + R 运行 `pamac-manager`  打开软件管理器
    或者， Application Menu -\> Preferences -\> Add\/Remove Software  
1. 搜索 virtualbox ，安装 VirtualBox
1. 安装过程中，被询问使用什么provider，使用当前内核版本对应的provider
1. 重启电脑
1. 安装extension
    1. 到Oracle官网下载对应版本的extension
    2. 执行 `sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.26.vbox-extpack`
    3. 重启电脑
    4. `VBoxManage list extpacks` 查看安装结果





## 文件系统

### 自动挂载fs

* 参考：
  * [ArchWiki - fstab (简体中文)](https://wiki.archlinux.org/index.php/Fstab_\(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87\))
  * [ArchWiki - NTFS-3G (简体中文)](https://wiki.archlinux.org/index.php/NTFS-3G_\(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87\))
  * <https://community.linuxmint.com/tutorial/view/1513>
  * [CSDN - Archlinux下实现NTFS分区自动挂载](https://blog.csdn.net/baimaozi/article/details/3134267)

* 挂载ext4
  1. 注意提前挂载点：`sudo mkdir /your-mount-point`
  2. 编辑 `/etc/fstab`
      ~~~
      # <file system>   <dir>		<type>    <options>             <dump>  <pass>
      # /dev/sda1
      UUID=通过“lsblk -f”和“fdisk -l”来获得  /your-mount-point   ext4    defaults,noatime 0 0  
      ~~~
  3. ext4 系统自带owner、gid、uid信息，创建filesystem的时候就存在，fstab文件中指定 uid、gid、fmask、dmask，都是没有用的，会导致系统启动失败。

* 挂载ntfs
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





### NTFS 支持

~~~
pacman -S ntfs-3g
~~~

一般随系统安装好了。


































