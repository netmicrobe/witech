---
layout: post
title: virtualbox 5 安装 增强功能 virtualbox Additions工具包
categories: [cm, vm, virtual-box]
tags: [cm, virtual-box, manjaro, vm, kernel, virtualize, network, ssh]
---


* 参考
  * <https://superuser.com/questions/298367/how-to-fix-virtualbox-startup-error-vboxadd-service-failed>
  * <http://virtualboxes.org/doc/installing-guest-additions-on-debian/>
  * []()
  * []()





## 一般安装过程

虚拟机挂载 Additions工具包iso

~~~bash
sudo apt update

# 安装当前kernel 对应的 headers
uname -r
sudo apt install linux-headers-5.4.0-91-generic

apt install build-essential module-assistant

# 安装 additions
cd /run/media/wivb/VBox_GAs_5.2.44
sudo ./VBoxLinuxAdditions.run

# 重启

# 查看安装情况
VBoxClient --version
systemctl list-units --type=service | grep vbox
systemctl is-enabled vboxadd.service
systemctl is-enabled vboxadd-service.service
~~~

宿主机配置权限： `sudo usermod -aG vboxusers $(whoami)`


### 测试可用的系统

* VirtualBox 5.2.44 + Mint 20.3 una
* VirtualBox 5.2.44 + Parrot 5



## Manjaro 20 Guest 启动慢的问题

* 参考
  * [VirtualBox 6 slow start/shutdown - forum.manjaro.org](https://forum.manjaro.org/t/virtualbox-6-slow-start-shutdown/70627/21)


禁止了 vboxadd service 之后，关机/开机 速度是有提高。 而且不影响**双向共享剪贴板**，神奇～～

~~~
sudo systemctl stop vboxadd
sudo systemctl disable vboxadd
~~~














