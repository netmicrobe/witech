---
layout: post
title: 在 virtualbox 中使用 Ubuntu 18.04
categories: [cm, vm, virtual-box]
tags: [cm, virtual-box, ubuntu, vm, kernel, virtualize, network, ssh]
---

## 安装&配置

### 安装开发工具

~~~
sudo apt-get install build-essential
~~~




#### 安装 增强功能 virtualbox Additions工具包


安装步骤

1. 菜单： 设备 》安装增强功能，会挂载安装光盘
1. 执行光盘下的 `sudo ./VBoxLinuxAdditions.run`






### 设置 host 和 vm 之间剪贴板共享

设置 》常规 》 高级 》 共享粘贴板：双向







## Trouble shooting













## 设置网卡


### CentOS 7 启动后网络默认关闭

* 手动打开
  通过图形界面 Applications - System Tools - Network 打开 Network Manager

* 设置开机自动打开
  
  1. 修改配置文件
      ~~~ shell
      vim /etc/sysconfig/network-scripts/ifcfg-enp0s3
      # enp0s3 是通过  ifconfig -a 获得虚拟网卡接口的名称
      ~~~
  
  2. 改为 `ONBOOT=yes`
  3. 重启



### 双网卡模式

即能访问网络、又能固定IP连接VM 的sshd。需要设置2个网卡。

#### VirutalBox 启用2个网卡 （设置 - 网络）

* 【网卡1】网络地址转换NAT：VM通过该网卡访问外网。
* 【网卡2】仅主机（host-only）网络 ： 设置固定IP，来进行ssh连接。
  1. 界面名称：VirtualBox Host-Only Ehternet Adapter
  1. 控制芯片：Intel PRO/1000 MT 桌面（82540EM）
  1. 混杂模式：全部允许
  1. MAC 地址，刷新一下

#### CentOS中设置

图形界面方式进入CentOS。`ifconfig -a` 查看对应的网卡名称和信息。

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

##### 在 host-only 网卡上 设置固定IP

1. 进入图形界面
2. 系统菜单： System > Preferences > Network Connections
3. 对 host-only 网卡例如 Auto eth1 进行修改，选择 Edit...
4. 选择tab页：IPv4 Settings
5. Method: Manual
6. 添加 Address
  * Address : 192.168.56.101
  * Netmask : 255.255.255.0
  * Geteway : 0.0.0.0
    * 注意：网关必须写 0.0.0.0 。写 host地址（例如，196.168.56.1 ）时，ssh客户端连上VM会很慢，VM也可能使用这个网卡访问外网，导致不能上网。
7. 保存后，重启。



## ssh 连接很慢

参考： <http://ask.xmodulo.com/fix-slow-ssh-login-issue-linux.html>

~~~ shell
vi /etc/ssh/sshd_config

# To disable GSSAPI authentication on an SSH server
GSSAPIAuthentication no

# add this line
UseDNS no
~~~



## CentOS - 7

### 设置启动模式（runlevel）

CentOS7 不在使用 inittab ，改为 systemd

~~~ shell
# To view current default target, run:
systemctl get-default

# multi-user.target: analogous to runlevel 3
# graphical.target: analogous to runlevel 5

# 图形界面
systemctl set-default graphical.target

# 多用户文字界面
systemctl set-default multi-user.target

~~~


### systemctl 启动/关闭服务

~~~ shell
systemctl status sshd.service
systemctl start sshd.service
systemctl stop sshd.service
systemctl restart sshd.service
~~~





















