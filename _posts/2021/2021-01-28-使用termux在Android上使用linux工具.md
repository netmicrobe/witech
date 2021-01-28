---
layout: post
title: 使用termux在Android上使用linux工具
categories: [cm, android]
tags: [termux, ssh]
---

* 参考： 
  * [Termux 官网](https://termux.com)
  * [Run an SSH server on your Android with Termux](https://glow.li/posts/run-an-ssh-server-on-your-android-with-termux/)
  * [wiki.termux.com - Remote Access](https://wiki.termux.com/wiki/Remote_Access)
  * []()
  * []()



## 下载安装

可以在Google Play下载，也可搜索 `termux apk` 下载。

类似cygwin，模拟系统的路径在`/data/data/com.termux/files/`，HOME目录在 `/data/data/com.termux/files/home` 。


## Termux 安装包

apt ， pkg 都可以使用

~~~
apt update
apt install some-package

pkg search some-query
pkg install some-package
pkg upgrade

# 其他repo
pkg install root-repo  #root
pkg install unstable-repo #unstable
pkg install x11-repo   # X11
~~~


## ssh 登录手机

1. 手机端Termux上安装sshd
    ~~~
    apt install openssh
    # 启动sshd
    sshd
    # 检查 sshd 是否在运行，termux默认运行在 8022 端口
    ssh localhost -p 8022
    ~~~
1. 将电脑的公钥加到termux（无法密码登录）
1. Termux上创建 `~/.ssh/authorized_keys`，可能之前已经有这个文件，创建之前`ls`看下。
    ~~~
    ls ~/.ssh/authorized_keys
    touch ~/.ssh/authorized_keys
    # Set Permissions to the file
    chmod 600 ~/.ssh/authorized_keys
    # Make sure the folder .ssh folder has the correct permissions
    chmod 700 ~/.ssh
    ~~~
1. 电脑上传终端的 id_rsa.pub , `adb push ~/.ssh/id_rsa.pub /sdcard/Download/`
1. Termux上写入公钥
    ~~~
    su
    cat /sdcard/Download/id_rsa.pub >> ~/.ssh/authorized_keys
    ~~~
1. 在电脑上连接手机端的termux ssh
    ~~~
    # -i $PATH_TO_FILE/filename is only required if the id_rsa file is not ~/.ssh/id_rsa
    ssh $IP -p 8022 -i %PATH_TO_KEY-FILE%/%NAME_OF_KEY%
    ~~~

### 在Termux关闭sshd

`pkill sshd`
















