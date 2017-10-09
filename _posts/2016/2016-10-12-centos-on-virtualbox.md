---
layout: post
title: 在 virtualbox 中使用 centos 6
categories: [cm, vm, virtual-box]
tags: [cm, virtual-box, centos, vm, kernel, virtualize, network]
---




## 安装 增强功能

* 参考
  * [VirtualBox Guest Additions on Fedora 25/24, CentOS/RHEL 7.3/6.8/5.11](https://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/)


### 安装步骤

* “增强功能”要编译安装，so先安装 build essential ： `yum groupinstall "Development Tools"`
* 菜单： 设备 》安装增强功能，会挂载安装光盘
* 执行光盘下的 `/media/VBOXADDITIONS_5.1.2_108956/VBoxLinuxAdditions.run`


```
yum groupinstall "Development Tools"

KERN_DIR=/usr/src/kernels/`uname -r`
export KERN_DIR

cd /media/VirtualBoxGuestAdditions
./VBoxLinuxAdditions.run
```

* 正确安装的提示

```
[root@localhost VBOXADDITIONS_5.1.18_114002]# ./VBoxLinuxAdditions.run 
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.1.18 Guest Additions for Linux...........
VirtualBox Guest Additions installer
Removing installed version 5.1.18 of VirtualBox Guest Additions...
vboxadd.sh: Stopping VirtualBox Additions.
Copying additional installer modules ...
Installing additional modules ...
vboxadd.sh: Building Guest Additions kernel modules.
Failed to set up service vboxadd, please check the log file
/var/log/VBoxGuestAdditions.log for details.
[root@localhost VBOXADDITIONS_5.1.18_114002]# rpm -ql kernel-devel-2.6.32-696.el6.i686 | less
[root@localhost VBOXADDITIONS_5.1.18_114002]# export KERN_DIR
[root@localhost VBOXADDITIONS_5.1.18_114002]# ./VBoxLinuxAdditions.run 
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.1.18 Guest Additions for Linux...........
VirtualBox Guest Additions installer
Removing installed version 5.1.18 of VirtualBox Guest Additions...
vboxadd.sh: Stopping VirtualBox Additions.
Copying additional installer modules ...
Installing additional modules ...
vboxadd.sh: Building Guest Additions kernel modules.
vboxadd.sh: Starting the VirtualBox Guest Additions.

You may need to restart the Window System (or just restart the guest system)
to enable the Guest Additions.

```


### 问题：找不到 kernel source

不知道为啥找不到，按照错误日志的提示，设置 KERN_DIR 变量，告诉它哪儿有

编辑 /etc/profile （见如下代码块）后，重启。

```
## ADD KERN_DIR to help vboxadd find kernel source
KERN_DIR=/usr/src/kernels/2.6.32-642.6.1.el6.i686
export KERN_DIR
```

重新执行 `VBoxLinuxAdditions.run`







## 设置 host 和 vm 之间剪贴板共享

设置 》常规 》 高级 》 共享粘贴板：双向


## 设置网卡

### 即能访问网络、又能host ssh 客户端连接。需要设置2个网卡。

* 前提：关闭虚拟机

1. 管理 》 网络 》 网卡1
  1.1. check 启用网络连接
  1.2. 连接方式：仅主机（host-only）网络
  1.3. 界面名称：VirtualBox Host-Only Ehternet Adapter
  1.4. 控制芯片：Intel PRO/1000 MT 桌面（82540EM）
  1.5. 混杂模式：全部允许
  1.6. MAC 地址，刷新一下
2. 管理 》 网络 》 网卡2
  2.1. check 启用网络连接
  2.2. 连接方式：网络地址转换（NAT）
  2.3. MAC 地址，刷新一下

```
[root@localhost ~]# ifconfig -a
eth1      Link encap:Ethernet  HWaddr 08:00:27:04:40:74  
          inet addr:192.168.56.102  Bcast:192.168.56.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe04:4074/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:80 errors:0 dropped:0 overruns:0 frame:0
          TX packets:86 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:26530 (25.9 KiB)  TX bytes:16830 (16.4 KiB)

eth2      Link encap:Ethernet  HWaddr 08:00:27:48:07:46  
          inet addr:10.0.3.15  Bcast:10.0.3.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe48:746/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:322 errors:0 dropped:0 overruns:0 frame:0
          TX packets:356 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:147746 (144.2 KiB)  TX bytes:36617 (35.7 KiB)
```

#### 在 host-only 网卡上 设置固定IP

1. 进入图形界面
2. 系统菜单： System > Preferences > Network Connections
3. 对 host-only 网卡例如 Auto eth1 进行修改，选择 Edit...
4. 选择tab页：IPv4 Settings
5. Method: Manual
6. 添加 Address
  * Address : 192.168.56.101
  * Netmask : 255.255.255.0
  * Geteway : 0.0.0.0
    * 网关写host地址（例如，196.168.56.1 ）时，ssh客户端连上VM会很慢，不明白为啥
7. 保存后，重启。








