---
layout: post
title: linux-mx-安装到virtualbox
categories: [cm, linux]
tags: []
---

* 参考： 
  * []()
  * []()


## 关于版本

在VirtualBox 5.2.44 中 MX 19.3 启动到桌面后黑屏，MX 19.2 正常。



## 修改 apt sources 到国内

`cd /etc/apt/sources.list.d/`

* antix.list
~~~
# Use with Debian Stable/buster repositories.
deb https://mirrors.huaweicloud.com/mxlinux/antix/buster buster main
#deb http://iso.mxrepo.com/antix/buster buster main
#deb-src http://iso.mxrepo.com/antix/buster buster main
~~~

* debian.list
~~~
# Debian Stable.
deb https://mirrors.huaweicloud.com/debian buster main contrib non-free
deb https://mirrors.huaweicloud.com/debian-security buster/updates main contrib non-free

#deb http://deb.debian.org/debian buster main contrib non-free
#deb http://deb.debian.org/debian-security buster/updates main contrib non-free
#deb-src http://deb.debian.org/debian buster main contrib non-free

#buster backports
#deb http://deb.debian.org/debian buster-backports main contrib non-free
~~~

* debian-stable-updates.list
~~~
# Debian buster Updates
deb https://mirrors.huaweicloud.com/debian/ buster-updates main contrib non-free
#deb http://deb.debian.org/debian buster-updates main contrib non-free
~~~

* mx.list
~~~
# MX Community Main and Test Repos
deb https://mirrors.huaweicloud.com/mxlinux/mx/repo buster main non-free
#deb http://mxrepo.com/mx/repo/ buster main non-free
#deb http://mxrepo.com/mx/testrepo/ buster test
#ahs hardware stack repo
deb https://mirrors.huaweicloud.com/mxlinux/mx/repo/ buster ahs
#deb http://mxrepo.com/mx/repo/ buster ahs
~~~


## 安装软件

* ssh

~~~
apt search openssh
sudo apt install openssh-server
service ssh status
~~~



## 挂在共享目录 shared_folder

1. 设置虚拟机共享目录 
1. 重启 virtualbox Additions 服务 `sudo service vboxadd-service restart`








