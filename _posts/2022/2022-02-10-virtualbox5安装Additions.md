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
* VirtualBox 5.2.44 + Debian 11 - kernel 5.10


## Manjaro 20 Guest 启动慢的问题

* 参考
  * [VirtualBox 6 slow start/shutdown - forum.manjaro.org](https://forum.manjaro.org/t/virtualbox-6-slow-start-shutdown/70627/21)


禁止了 vboxadd service 之后，关机/开机 速度是有提高。 而且不影响**双向共享剪贴板**，神奇～～

~~~
sudo systemctl stop vboxadd
sudo systemctl disable vboxadd
~~~


## 问题： Ubuntu 20.04 无法加载共享文件夹


parrot 5, kernel 5.14 都好好的，有问题的发行版：
Ubuntu 20.04 - kernel 5.13
Kali 2022.2
Manjaro 21.2.5 - kernel 5.15


* 现象

进入配置的共享目录，内容为空，手动挂载，报错： `Invalid argument`

~~~sh
$ mount.vboxsf -w -o rw,nodev _isolate /media/sf_myshare/

mount.vboxsf: mounting failed with the error: Invalid argument
~~~

报错可能的源码位置：

~~~sh
./src/VBox/Additions/linux/sharedfolders/mount.vboxsf.c:        panic_err("%s: mounting failed with the error", argv[0]);
~~~

`journalctl` 启动日志：

~~~sh
vbub20 systemd[1]: Starting vboxadd-service.service...
vbub20 vboxadd-service[1200]: vboxadd-service.sh: Starting VirtualBox Guest Addition service.
vbub20 vboxadd-service.sh[1203]: Starting VirtualBox Guest Addition service.
vbub20 kernel: VBoxService 5.2.44 r139111 (verbosity: 0) linux.amd64 (Jul  9 2020 19:11:15) release log
                                00:00:00.000228 main     Log opened 20
vbub20 kernel: 00:00:00.001341 main     OS Product: Linux
vbub20 kernel: 00:00:00.001673 main     OS Release: 5.13.0-35-generic
vbub20 kernel: 00:00:00.002109 main     OS Version: #40~20.04.1-Ubuntu SMP Mon Mar 7 09:18:32 UTC 2022
vbub20 kernel: 00:00:00.002755 main     Executable: /opt/VBoxGuestAdditions-5.2.44/sbin/VBoxService
                                00:00:00.002756 main     Process ID: 1208
vbub20 vboxadd-service.sh[1214]: VirtualBox Guest Addition service started.
vbub20 kernel: 00:00:00.005217 main     5.2.44 r139111 started. Verbose level = 0
vbub20 systemd[1]: Started vboxadd-service.service.
vbub20 kernel: vboxsf: Old binary mount data not supported, remove obsolete mount.vboxsf and/or update your VBoxService.
vbub20 kernel: 00:00:00.021826 automount vbsvcAutoMountWorker: Shared folder 'myshare' already is mounted!
~~~








