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






### 设置网卡


即能访问网络、又能固定IP连接VM 的sshd。需要设置2个网卡。

#### VirutalBox 启用2个网卡 （设置 -- 网络）

* 【网卡1】网络地址转换NAT：VM通过该网卡访问外网。
* 【网卡2】仅主机（host-only）网络 ： 设置固定IP，来进行ssh连接。
  1. 界面名称：VirtualBox Host-Only Ehternet Adapter
  1. 控制芯片：Intel PRO/1000 MT 桌面（82540EM）
  1. 混杂模式：全部允许
  1. MAC 地址，刷新一下


#### 在 host-only 网卡上 设置固定IP

`ifconfig -a` 查看对应的“host-only 网卡”名称和信息。

1. 进入图形界面
2. 系统菜单： System > Preferences > Network Connections
3. 对 host-only 网卡例如 Auto eth1 进行修改，选择 Edit...
4. 选择tab页：IPv4 Settings
5. Method: Manual
6. 添加 Address
  * Address : 192.168.56.101
  * Netmask : 255.255.255.0
  * Geteway : 0.0.0.0
    * **注意**： 网关必须写 0.0.0.0 。写 host地址（例如，196.168.56.1 ）时，ssh客户端连上VM会很慢，VM也可能使用这个网卡访问外网，导致不能上网。
7. 保存后，重启。




### 配置 OpenSSH

~~~ shell
sudo apt install ssh
sudo systemctl enable ssh
~~~



### 配置无图形界面启动

~~~ shell
sudo ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target
~~~








## Trouble shooting































