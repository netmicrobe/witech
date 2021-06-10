---
layout: post
title: manjaro上使用samba服务
categories: [cm, linux]
tags: [linux, manjaro, arch-linux, smbclient ]
---

* 参考
  * [archlinux wiki - Samba](https://wiki.archlinux.org/title/samba)
  * []()
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
1. 
1. 
1. 
1. 
1. 





























