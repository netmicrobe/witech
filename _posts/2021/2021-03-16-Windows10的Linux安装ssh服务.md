---
layout: post
title: Windows10的Linux安装ssh服务
categories: [cm, Windows]
tags: [WSL, Windows-Subsystem-Linux, ssh]
---

* 参考： 
    * [SSH on Windows Subsystem for Linux (WSL)](https://www.illuminiastudios.com/dev-diaries/ssh-on-windows-subsystem-for-linux/)
    * [How to SSH into WSL2 on Windows 10 from an external machine](https://www.hanselman.com/blog/how-to-ssh-into-wsl2-on-windows-10-from-an-external-machine)
    * [SSH-ing into a Windows WSL Linux Subsystem](https://jeetblogs.org/post/sshing-into-a-windows-wsl-linux-subsystem/)
    * []()


## 安装ssh server

1. 重新执行一遍安装
    ~~~
    sudo apt remove openssh-server
    sudo apt install openssh-server
    ~~~
1. 配置ssh `sudo vi /etc/ssh/sshd_config`
    1. `PasswordAuthentication` 改为 `yes`
    1. 文件末尾添加 `AllowUsers yourusername`
    1. 保存配置文件。
    1. 重启ssh ： `sudo service ssh --full-restart`

重启Windows后，ssh服务不会自动启动，可手动启动 `sudo service ssh start`



## 自动启动 ssh server


`%windir%\System32\bash.exe -c "sudo /etc/init.d/ssh start"`
















