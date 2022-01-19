---
layout: post
title: centos7安装配置samba服务
categories: [cm, linux]
tags: [linux, centos, samba, windows, smbd, samba-client ]
---

* 参考
  * [如何在CentOS 7上安装和配置Samba](https://www.myfreax.com/how-to-install-and-configure-samba-on-centos-7/)
  * [How to Install and Configure Samba on CentOS 7](https://linuxize.com/post/how-to-install-and-configure-samba-on-centos-7/)
  * [Setting Up Samba and Configure FirewallD and SELinux to Allow File Sharing on Linux/Windows Clients – Part 6](https://www.tecmint.com/setup-samba-file-sharing-for-linux-windows-clients/)
  * [Setting up a Samba Server with SELinux on RHEL 7](https://www.lisenet.com/2016/samba-server-on-rhel-7/)
  * [CentOS 7: Samba and SELinux](https://www.alteeve.com/w/CentOS_7:_Samba_and_SELinux)
  * [CentOS7下Samba服务安装与配置](https://www.jianshu.com/p/cc9da3a154a0)
  * [CentOS 7下Samba服务器的安装与配置](https://www.cnblogs.com/muscleape/p/6385583.html)
  * [Centos7下Samba服务器配置（实战）](https://cloud.tencent.com/developer/article/1720995)
  * []()


1. 安装&启动samba
    ~~~
    sudo yum install samba samba-client
    sudo systemctl start smb.service 
    sudo systemctl enable smb.service
    ~~~

1. 配置防火墙
    smbd服务提供文件共享和打印服务，并侦听TCP端口139和445。nmbd服务向客户端提供基于IP命名服务的NetBIOS，并侦听UDP端口137。

    ~~~
    firewall-cmd --permanent --zone=public --add-service=samba
    firewall-cmd --zone=public --add-service=samba
    ~~~
1. 创建目录和用户组，存放samba共享文件
    ~~~
    sudo mkdir /samba
    sudo groupadd sambashare
    sudo chgrp sambashare /samba
    ~~~
1. 创建samba管理帐号 `sadmin`
    ~~~
    # add user in linux
    sudo useradd -M -d /samba/users -s /usr/sbin/nologin -G sambashare sadmin
    # add user in samba
    sudo smbpasswd -a sadmin
    # enable user
    sudo smbpasswd -e sadmin
    sudo mkdir /samba/users
    sudo chown sadmin:sambashare /samba/users
    sudo chmod 2770 /samba/users
    ~~~
1. 配置samba
    `vi /etc/samba/smb.conf`

    ~~~
    [users]
      path = /samba/users
      browseable = yes
      read only = no
      force create mode = 0660
      force directory mode = 2770
      valid users = @sambashare @sadmin
    ~~~

1. 重启 samba 服务
    ~~~
    sudo systemctl restart smb.service
    sudo systemctl restart nmb.service
    ~~~

1. 配置selinux

    selinux 没配置，可能报错： `NT_STATUS_ACCESS_DENIED`

    ~~~
    setsebool -P samba_export_all_ro=1 samba_export_all_rw=1
    getsebool -a | grep samba_export
    semanage fcontext -at samba_share_t "/samba(/.*)?"
    restorecon /samba
    ~~~
    
    * 如果报错： `-bash: semanage: command not found`
    ~~~bash
    # 先查找 semanage 在哪个包
    yum provides /usr/sbin/semanage
    
    # CentOS7.9 为例，输出： 
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirrors.aliyun.com
     * extras: mirrors.aliyun.com
     * updates: mirrors.aliyun.com
    policycoreutils-python-2.5-34.el7.x86_64 : SELinux policy core python utilities
    Repo        : base
    Matched from:
    Filename    : /usr/sbin/semanage

    # 安装对应的包
    yum install policycoreutils-python-2.5-34.el7.x86_64
    ~~~
    

1. 从linux测试samba连接
    ~~~
    sudo yum install samba-client
    smbclient //samba_hostname_or_server_ip/share_name -U username
    ~~~

    如果出现报错 `protocol negotiation failed: NT_STATUS_CONNECTION_DISCONNECTED`，
    处理方法如下，参考： <https://unix.stackexchange.com/a/585339>
    ~~~
    vi /etc/samba/smb.conf
    ~~~
    ~~~
    client min protocol = CORE
    client max protocol = SMB3
    ~~~




## Samba configuration file

* `[users] ` and `[josh]` - The names of the shares that you will use when logging in.
* `path` - The path to the share.
* `browseable` - Whether the share should be listed in the available shares list. By setting to no other users will not be able to see the share.
* `read only` - Whether the users specified in the valid users list are able to write to this share.
* `force create mode` - Sets the permissions for the newly created files in this share.
* `force directory mode` - Sets the permissions for the newly created directories in this share.
* `valid users` - A list of users and groups that are allowed to access the share. Groups are prefixed with the @ symbol.








