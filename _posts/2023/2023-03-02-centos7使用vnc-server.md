---
layout: post
title: centos7使用vnc-server，关联 virtual-desktop, tigervnc, vncserver
categories: []
tags: []
---

* 参考
  * [How to Install and Configure VNC Server in CentOS 7](https://www.tecmint.com/install-and-configure-vnc-server-in-centos-7/)
  * [Installing and configuring a VNC server on CentOS 7](https://serverspace.io/support/help/installing-and-configuring-a-vnc-server-on-centos-7/)
  * [Install and Configure VNC Server in CentOS 7 and RHEL 7](https://www.linuxtechi.com/install-configure-vnc-server-centos-7-rhel-7/)
  * []()


`VNC (Virtual Network Computing)` is a server-client protocol which allows user accounts to remotely connect and control a distant system by using the resources provided by the Graphical User Interface.


`VNC X` or `Vino`, `tigervnc-vncserver` 为每一个用户配置一个独立的虚拟桌面。


## 使用 tigervnc server

1. 安装 tigervnc server
    ~~~sh
    sudo yum install -y tigervnc-server
    ~~~
1. 配置vnc登陆密码
    ~~~sh
    $ su - your_user  # If you want to configure VNC server to run under this user directly from CLI without switching users from GUI
    $ vncpasswd
    ~~~
1. 配置对应的service
    ~~~sh
    # 先从模板文件拷贝
    sudo cp /lib/systemd/system/vncserver@.service  /etc/systemd/system/vncserver@:1.service
    ~~~

    编辑 `vi /etc/systemd/system/vncserver@\:1.service`

    添加如下配置：

    ~~~
    [Unit]
    Description=Remote desktop service (VNC)
    After=syslog.target network.target

    [Service]
    Type=forking
    ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
    ExecStart=/sbin/runuser -l my_user -c "/usr/bin/vncserver %i -geometry 1280x1024"
    PIDFile=/home/my_user/.vnc/%H%i.pid
    ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

    [Install]
    WantedBy=multi-user.target
    ~~~

    刷新systemctl 配置

    ~~~sh
    # systemctl daemon-reload
    # systemctl start vncserver@:1
    # systemctl status vncserver@:1
    # systemctl enable vncserver@:1
    ~~~

1. vnc 开放的端口
    一般从5901开始，后继有连接端口加一，上限是6000个端口

    可以用 ss 命令搜索：

    ~~~
    ss -tulpn | grep vnc
    ~~~

1. 防火墙配置
    ~~~
    # firewall-cmd --add-port=5901/tcp
    # firewall-cmd --add-port=5901/tcp --permanent
    ~~~

1. 从vnc客户端连接 ==========================================

1. 选择一个VNC客户端软件
    RealVNC VNC Viewer ： 兼容windows，linux
    vinagre: CentOS 上使用，`sudo yum install vinagre`
    Remmina: debian系上使用， `sudo apt-get install remmina`
    
1. 客户端地址输入： IP:Port ，例如 `192.168.1.222:5901`

1. 提升安全性 ==========================================
1. VNC通信除了密码，其他都是未加密的。可以限制本地访问，通过ssh tunnel再连接。
1. 
1. 
1. 
1. 
1. 



## trouble shoting

### vnc连接正常，但是显示蓝屏

可能是 vnc server 桌面环境没装好。

修复：
1. vnc server 上安装 Gnome
    ~~~
    # 保险期间，2个命令都执行了一下
    yum install gnome* --exclude=gnome-session-wayland-session
    yum groupinstall "GNOME Desktop"
    ~~~
1. 重启宿主机

















































































































































































































