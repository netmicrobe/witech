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











v
