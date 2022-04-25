---
layout: post
title: 通过vnc连接ubuntu
categories: [cm, linux]
tags: [realvnc]
---

* 参考： 
    * [Ubuntu 16.04 VMWare Install and Remote Desktop Setup](https://www.youtube.com/watch?v=NaI6lB87HM0)
    * [How to Use Remote Desktop Connection in Ubuntu Linux: Complete Walkthrough](https://www.nakivo.com/blog/how-to-use-remote-desktop-connection-ubuntu-linux-walkthrough/)
    * []()
    * []()



## Ubuntu 20.04 上安装VNC Server

* 参考： 
    * [digitalocean.com - How to Install and Configure VNC on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-20-04)
    * [Install and Configure VNC Server on Ubuntu 20.04|18.04](https://techviewleo.com/install-and-configure-vnc-server-on-ubuntu/)
    * [VNC server on Ubuntu 20.04 Focal Fossa Linux](https://linuxconfig.org/vnc-server-on-ubuntu-20-04-focal-fossa-linux)
    * [Ubuntu 20.04 Remote Desktop Access with VNC](https://www.answertopia.com/ubuntu/ubuntu-remote-desktop-access-with-vnc/)
    * [How to Install TightVNC Server on Ubuntu 20.04](https://serverspace.io/support/help/install-tightvnc-server-on-ubuntu-20-04/)
    * []()

### xfce4 desktop

1. 安装 xfce4 desktop + vnc server
    ~~~sh
    sudo apt update

    # 安装 xfce4 桌面，选择 lightdm
    sudo apt install xfce4 xfce4-goodies
    ~~~

    ~~~sh
    # 安装 vnc server
    sudo apt install tightvncserver
    ~~~

1. 配置
    ~~~sh
    # 设置VNC 访问密码，密码长度要求在 6-8个字符，超过8个会自动被截掉
    #
    # 设置完 访问密码，还会被询问设置 view-only password，
    # 用来给其他人看桌面演示（鼠标、键盘无效），这个不是必须的
    # 
    vncserver
    ~~~

1. 配置完成后，默认运行在 `5901` 端口，VNC `:1`，第二个客户端连接使用 `5902` `:2`，以此类推。

1. 先关闭刚启动的 vnc server，来继续后面的配置： `vncserver -kill :1`

1. 修改 `~/.vnc/xstartup`
    vnc server 的初始化脚本是： `~/.vnc/xstartup`
    ~~~sh
    #先备份
    mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
    ~~~

    然后，修改：

    * For xfce4 desktop environment:
        ~~~
        #!/bin/bash
        xrdb $HOME/.Xresources
        startxfce4 &
        ~~~

    * 第一行命令 `xrdb $HOME/.Xresources`, tells VNC’s GUI framework to read the server user’s .Xresources file. `.Xresources` is where a user can make changes to certain settings of the graphical desktop, like terminal colors, cursor themes, and font rendering. 
    * 第二行命令 `startxfce4 &` tells the server to launch Xfce. Whenever you start or restart the VNC server, these commands will execute automatically.

    最后，记得改成可执行： `chmod +x ~/.vnc/xstartup`

1. 启动vnc： `vncserver`
1. 使用 vnc viewer 访问 server-ip:5901 ，输入密码就可以进入了
1. 
1. 


### lxde desktop

* 参考
    * [Ubuntu 20.04 安装 Tigervncserver](https://bevisy.github.io/p/install-tigervncserver-on-ubuntu-20.04/)
    * [Linux: Use Lubuntu 20.04, TightVNC Server, NoVNC, WebSockify to Create a Terminal Server Accessible via Any Browser!](https://kimconnect.com/linux-use-lubuntu-20-04-tightvnc-server-novnc-websockify-to-create-a-terminal-server-accessible-via-any-browser/)
    * []()
    * []()
    * []()
    * []()
    * []()
    * []()


1. 安装

~~~sh
sudo apt -y install tightvncserver xfonts-base xorg lxde-core autocutsel

# Initialize VNC server for the first time to create the config file
vncserver :1
vncserver -kill :1
~~~~

1. 配置 `vim /home/$(whoami)/.vnc/xstartup`

~~~sh
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
xrdb $HOME/.Xresources
xsetroot -solid grey
export XKL_XMODMAP_DISABLE=1

lxterminal &
/usr/bin/lxsession -s LXDE &
~~~

~~~sh
sudo chmod +x /home/$(whoami)/.vnc/xstartup
  
# Configure firewall to allow port 5901
sudo ufw allow from any to any port 5901 proto tcp
~~~

1. 启动

~~~sh
# Restart session 1
sessionId=1
vncserver -kill :$sessionId
rm -f /tmp/.X$sessionId-lock
rm -f /tmp/.X11-unix/X$sessionId
vncserver :$sessionId -geometry 1920x1080 -depth 16 -pixelformat rgb565
~~~











### gnome desktop

* 参考： 
    * [Install VNC Server on Ubuntu 20.04 | 18.04 LTS to access GNOME](https://www.how2shout.com/linux/install-vnc-server-on-ubuntu-20-04-18-04-lts-to-access-gnome/)
    * [Using VNC to Operate a Desktop on Ubuntu 18.04](https://hustakin.github.io/bestpractice/setup-vncserver-for-ubuntu/)
    * [Use VNC to build GUIs on Ubuntu 18.04 and 20.04](https://www.alibabacloud.com/help/en/simple-application-server/latest/use-vnc-to-build-guis-on-ubuntu-18-04-and-20-04)
    * [How to Create a Virtual (Headless) TigerVNC Server on Ubuntu 20.04](https://www.sproutworkshop.com/2021/04/how-to-create-a-virtual-headless-tigervnc-server-on-ubuntu-20-04/)
    * []()

总结： gnome 的效果差，运行速度慢，不建议使用。

1. 安装
    ~~~sh
    sudo apt update
    sudo apt install tigervnc-standalone-server tigervnc-xorg-extension 
    sudo apt install xserver-xorg-core
    sudo apt install ubuntu-gnome-desktop
    sudo systemctl start gdm

    # 设置vnc passwd
    vncpasswd

    # 第一次运行 vnc server
    vncserver
    # 关闭
    vncserver -kill :*
    ~~~

1. 配置

    `cat ~/.vnc/xstartup`

    ~~~
    #!/bin/sh 
    [ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
    [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
    vncconfig -iconic &
    dbus-launch --exit-with-session gnome-session &
    ~~~

    `sudo chmod +x ~/.vnc/xstartup`

1. 启动

    `vncserver -localhost no -geometry 800x600 -depth 24`
    注意 `localhost no` 没加的话，默认就是 `localhost yes` ，无法被网络上其他主机访问，只能localhost访问。


### ufw 开启 5901 端口

~~~sh
sudo ufw allow 5901
sudo ufw status
~~~

### vncserver 自启动

1. 创建 `/etc/systemd/system/vncserver@.service`

    * User, Group, WorkingDirectory,PIDFILE 都要改成你自己的用户名、用户组和用户目录
    * ExecStart 里面，如果不使用ssh tunnel ，那么，要删除掉 -localhost

    ~~~
    [Unit]
    Description=Start TightVNC server at startup
    After=syslog.target network.target

    [Service]
    Type=forking
    User=sammy
    Group=sammy
    WorkingDirectory=/home/sammy

    PIDFile=/home/sammy/.vnc/%H:%i.pid
    ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
    ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 -localhost :%i
    ExecStop=/usr/bin/vncserver -kill :%i

    [Install]
    WantedBy=multi-user.target
    ~~~

1. 启动测试
    ~~~sh
    sudo systemctl daemon-reload
    sudo systemctl start vncserver@1.service
    ~~~
1. 开机自启动
    ~~~sh
    sudo systemctl enable vncserver@1.service
    ~~~
1. 
1. 
1. 




### ssh tunnel 访问，增加安全性

1. 重启 vncserver： `vncserver -localhost`
    `-localhost` 表示只能本地连接上服务器

1. 在客户端电脑上创建一个ssh tunnel
~~~sh
ssh -L 59000:localhost:5901 -C -N -l your-user-name your_server_ip
~~~

vnc 本身不支持安全连接，所以在本地做了一个ssh tunnel

* `-L 59000:localhost:5901` 通过`localhost:59000` 通过ssh tunnel 转发到服务器的 `localhost:5901`
* `-C` 开启压缩，节约流量
* `-N` 不需要通过ssh执行命令，只是转发流量
* `-l your-user-name your_server_ip` 登录服务器时候的用户和地址

1. VNC 客户端输入 `localhost:59000` 进行连接。
1. 
1. 



## google-chrome-stable 启动，整个窗口都是粉色

~~~
ERROR:sandbox_linux.cc InitializeSandbox() called with multiple threads in progress gpu-process
ERROR:gpu_memory_buffer_support_x11.cc(44) dri3 extension not supported.
Unsupported visual with rgb mask 0x7, 0x38, 0xc0. Please report this to https://crbug.com/1025266
~~~



## 在Manjaro上使用realvnc viewer 访问 Esxi 上的Ubuntu 18.04

* Ubuntu 18.04 上安装VNC Server : vino

    ~~~
    sudo apt install vino
    # 关闭加密
    gsettings set org.gnome.Vino require-encryption false
    # 重启系统
    reboot
    ~~~

* Manjaro 安装 realvnc viewer

    1. 安装 Realvnc Viewer
    ~~~
    yay -S realvnc-vnc-viewer
    ~~~
    1. 启动 VNC Viewer -\> File 菜单 -\> New Connection...
        1. VNC Server: 目标ubuntu的IP
        1. Security / Encryption : Let VNC Server choose
        1. 保存
    1. 连接目标Ubuntu

* 存在的问题

    1. 可以剪贴板双向粘帖，但是中文乱码。
    1. 
    1. 




















































