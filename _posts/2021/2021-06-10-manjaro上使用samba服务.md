---
layout: post
title: manjaro上使用samba服务
categories: [cm, linux]
tags: [linux, manjaro, arch-linux, smbclient ]
---

* 参考
  * [archlinux wiki - Samba](https://wiki.archlinux.org/title/samba)
  * [archlinux wiki - Fstab#Remote_filesystem](https://wiki.archlinux.org/title/Fstab#Remote_filesystem)
  * [archlinux man - mount.cifs](https://man.archlinux.org/man/mount.cifs.8#FILE_AND_DIRECTORY_OWNERSHIP_AND_PERMISSIONS)
  * [NOFAIL AND NOBOOTWAIT MOUNT OPTIONS IN FSTAB PREVENT BOOT PROBLEMS](https://www.furorteutonicus.eu/2013/08/29/nofail-and-nobootwait-mount-options-in-fstab-prevent-boot-problems/)
  * [Auto-mount Samba / CIFS shares via fstab on Linux](https://timlehr.com/auto-mount-samba-cifs-shares-via-fstab-on-linux/)
  * []()
  * []()



## 命令行工具 smbclient

~~~
# 安装
sudo pacman -S smbclient

# 保证config文件存在，防止报错
sudo touch /etc/samba/smb.conf

# 列出对应用户可以使用的共享目录
smbclient -L 【IP地址】 -U 【用户名】
~~~


## KDE - Dolphin 文件管理器配置samba连接

1. 右键左侧导航栏目 \> Add Entry...
1. 弹出对话框，填写：
    Label： 名称，自己取个容易记住的
    Location: smb://192.168.0.1/your-share-dir/
1. 点击OK后，输入用户名和密码，这个samba连接配置就保存在导航栏了



## **自动**挂载到文件系统


1. `sudo pacman -S cifs-utils`
1. 手动mount先试试
    ~~~
    mount -t cifs //SERVER/sharename /mnt/mountpoint -o username=username,password=password,workgroup=workgroup,iocharset=utf8,uid=username,gid=group
    ~~~

1. 可能会mount失败，使用命令 `dmesg` 看看
1. 可能samba协议问题，例如：
    ~~~
    [30009.063303] No dialect specified on mount. Default has changed to a more secure dialect, SMB2.1 or later (e.g. SMB3), from CIFS (SMB1). To use the less secure SMB1 dialect to access old servers which do not support SMB3 (or SMB2.1) specify vers=1.0 on mount.
    [30009.067536] CIFS VFS: cifs_mount failed w/return code = -2
    ~~~
    
    加上 `vers=1.0` 或 `vers=2.0` 或 `vers=3.0` 试试
    ~~~
    mount -t cifs //SERVER/sharename /mnt/mountpoint -o username=username,password=password,iocharset=utf8,noperm,vers=1.0
    ~~~


1. 创建帐号密码文件
    例如，`vi /etc/samba/credentials/hgst500g`
    ~~~
    username=myuser
    password=mypass
    ~~~
1. 用密码文件，手动mount先试试
    ~~~
    mount -t cifs //192.168.0.32/users /run/media/samba/hgst500g -o credentials=/etc/samba/credentials/hgst500g,iocharset=utf8,noperm
    ~~~

1. 方法一，使用 `/etc/fstab` 自动挂载
    1. 启动服务 systemd-networkd-wait-online.service 和 NetworkManager-wait-online.service
        ~~~
        sudo systemctl enable systemd-networkd-wait-online.service
        sudo systemctl enable NetworkManager-wait-online.service
        ~~~
    1. 编辑 `/etc/fstab` ，添加：
        ~~~
        //192.168.0.32/users /run/media/samba/hgst500g cifs noauto,x-systemd.automount,x-systemd.mount-timeout=30,_netdev,nofail,credentials=/etc/samba/credentials/hgst500g,iocharset=utf8,noperm 0 0
        ~~~
    
    fstab 相关参数说明，参见 [archlinux wiki - Fstab#Remote_filesystem](https://wiki.archlinux.org/title/Fstab#Remote_filesystem)
    
    * `noauto,nofail`，不要因为无法挂载导致操作系统无法启动
      * All specified devices within `/etc/fstab` will be automatically mounted on startup and when the -a flag is used with mount(8) unless the `noauto` option is specified. Devices that are listed and not present will result in an error unless the `nofail` option is used.
    * _`netdev` option ensures systemd understands that the mount is network dependent and order it after the network is online.
    * `noauto,x-systemd.automount` 访问挂载的时候，才fsck
    * `x-systemd.mount-timeout=` option to specify how long systemd should wait for the mount command to finish. 
    * `noperm`， override permission checking on the client altogether

1. 方法二、作为 systemd unit 【还没试过～～～】
    1. 创建`.mount` 文件
        例如，`/etc/systemd/system/mnt-myshare.mount`，
        这个名字对应的挂载目录是 `/mnt/myshare`， 否则目录不对应可能报错： systemd[1]: mnt-myshare.mount: Where= setting does not match unit name. Refusing..

        * /etc/systemd/system/mnt-myshare.mount

        ~~~
        [Unit]
        Description=Mount Share at boot

        [Mount]
        What=//server/share
        Where=/mnt/myshare
        Options=_netdev,credentials=/etc/samba/credentials/myshare,iocharset=utf8,rw
        Type=cifs
        TimeoutSec=30

        [Install]
        WantedBy=multi-user.target
        ~~~

    1. 创建 `.automount` 文件

        * /etc/systemd/system/mnt-myshare.automount

        ~~~
        [Unit]
        Description=Automount myshare

        [Automount]
        Where=/mnt/myshare

        [Install]
        WantedBy=multi-user.target
        ~~~
    1. `sudo systemctl enable mnt-myshare.automount`

1. 
1. 
1. 
1. 





























