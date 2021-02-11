---
layout: post
title: 通过rdp连接ubuntu
categories: [cm, linux]
tags: [rdp, remmina, remote-desktop]
---

* 参考： 
    * [如何在Ubuntu 20.04 上安装 Xrdp 服务器（远程桌面）](https://yq.aliyun.com/articles/762186)
    * []()
    * []()
    * []()
    * []()

1. 安装配置xrdp
~~~
sudo apt install xrdp 

# 一旦安装完成，Xrdp 服务将会自动启动。
sudo systemctl status xrdp

# 默认情况下，Xrdp 使用/etc/ssl/private/ssl-cert-snakeoil.key,它仅仅对“ssl-cert” 用户组成语可读。运行下面的命令，将xrdp用户添加到这个用户组：
sudo adduser your-account ssl-cert  

# 重启 Xrdp 服务，使得修改生效：
sudo systemctl restart xrdp
~~~

1. 使用Remmina登录目标ubuntu
