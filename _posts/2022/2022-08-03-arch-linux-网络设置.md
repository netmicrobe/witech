---
layout: post
title: arch-linux-网络设置，关联 manjaro, endeavoros
categories: [ cm ]
tags: []
---

* 参考
  * <https://wiki.archlinux.org/title/Network_configuration>
  * [ip-route man page](http://polarhome.com/service/man/?qf=ip-route&tf=2&of=Archlinux&sf=8)
  * []()

## 常用技巧

### 使用 Network Manager 做为网络管理工具时，添加静态路由

* 参考
  * [AYSAD KOZANOGLU - How To Add Route on Linux](https://www.linuxhowto.net/how-to-add-route-on-linux/)
  * [Red Hat - 4.2. Configuring Static Routes Using nmcli](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_static_routes_using_nmcli)

可能的方法 1：

1. `vim /etc/NetworkManager/system-connections/Wired connection 1.nmconnection`
    ~~~
    [ipv4]
    address1=192.168.178.36/24,192.168.178.1
    address1=192.168.178.36/24
    dns-search=
    method=manual
    route1=10.0.3.0/24,10.0.3.1,1
    ~~~
1. `sudo nmcli connection reload`
1. `ip route` 查看效果

可能的方法 2：

~~~sh
sudo nmcli connection modify enp1s0 +ipv4.routes "192.168.122.0/24 10.10.10.1"
sudo nmcli connection reload
~~~


## 概述

* arch linux 使用 `iproute2` 替代了 `net-tools`。
    * `ip neighbor` 替代 `arp`
    * `ip address`, `ip link` 替代 `ifconfig`
    * `ss` 替代 `netstat`
    * `ip route` 替代 `route`


## iproute2

`iproute2` 提供一堆 `ip xxx` 的命令，来管理 network interface , IP Addresses, route table。

`ip xxx` 命令设置在重启后会失效。如果要永久有效，要使用 Network_manager 或者 在 systemd units 里面配置启动执行。


## Network Interface

interface 名称，是 `udev` 自动给网络控制器取的名字，`en`开头的对应以太网卡；`wl`开头的，对应无线网卡；`ww`开头的，对应WWAN，无线广域网。

列出所有interface ： `ls /sys/class/net` or `ip link` 。

查看某个具体interface ： `ip link show dev your-interface-name`

`iw dev` 查看无线设备情况。

开关interface： `ip link set interface up|down`

### 查看 Mac 地址

`cat /sys/class/net/device_name/address`


### 修改 interface 名称

修改 udev rule `/etc/udev/rules.d/10-network.rules`

~~~
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="aa:bb:cc:dd:ee:ff", NAME="net1"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="ff:ee:dd:cc:bb:aa", NAME="net0"
~~~

注意mac地址使用小写字母。

重启系统。

如果是使用的usb 网卡、Android网络共享，mac地址没法固定，那么可以使用： 

~~~
SUBSYSTEM=="net", ACTION=="add", ATTRS{idVendor}=="12ab", ATTRS{idProduct}=="3cd4", NAME="net2"
~~~

可以先测试下，再重启：
1. 先关闭interface： `ip link set enp1s0 down`
1. `udevadm --debug test /sys/class/net/*`


## IP Address

显示IP地址： `ip addr`

向 interface 添加IP 地址： `ip address add address/prefix_len broadcast + dev your-interface`

向 interface 删除IP地址： `ip address del address/prefix_len dev your-interface`

删除所有IP 地址： `ip address flush dev your-interface`

### 多个IP，IP alias

手动设置 IP alias： `ip addr add 192.168.2.101/24 dev enp2s0 label enp2s0:1`

删除 IP alias：  `ip addr del 192.168.2.101/24 dev enp2s0:1`





## Network Managers

可选的有： 
* ConnMan
    * client tools: connmanctl
    * service: connman.service
* netctl
    * client tools: netctl, wifi-menu
    * service: netctl-ifplugd@interface.service, netctl-auto@interface.service
* NetWorkManager
    * client tools: nmcli, nmtui
    * service: NetworkManager.service
* systemd-networkd
    * client tools: networkctl
    * service: systemd-networkd.service, systemd-resolved.service


### NetworkManager

* 参考
    * <https://wiki.archlinux.org/title/NetworkManager>
    * []()

NetworkManager 是一个网络管理程序，用来侦测、自动配置链接网络，无论是有线或无线，可以根据无线网络的强弱自动连接稳定的那个。

NetworkManager 开始是RedHat开发的，现在托管在 GNOME 项目。

查看如何config： `man 5 NetworkManager.conf`

config 文件： 
* /etc/NetworkManager/NetworkManager.conf
* /etc/NetworkManager/conf.d/name.conf
* /run/NetworkManager/conf.d/name.conf
* /usr/lib/NetworkManager/conf.d/name.conf
* /var/lib/NetworkManager/NetworkManager-intern.conf

`Wired connection 1.nmconnection` 文件在 `/etc/NetworkManager/system-connections/` 下找不到，有可能在 `/run/NetworkManager/system-connections/` 下。

~~~
[connection]
id=Wired connection 1
uuid=f3267ade-62ab-78cb-8430-a0cc625223e2
type=ethernet
autoconnect-priority=-999
interface-name=eno1
timestamp=1659577993

[ethernet]

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto

[proxy]

[.nmmeta]
nm-generated=true
~~~






## Routing table

`ip route` 可简化为 `ip r`

列出所有IPv4的路由： `ip route show`

列出所有IPv6的路由： `ip -6 route`

添加路由： `ip route add CIDR-notaion-or-default via your-gw-address dev your-interface`

删除路由： `ip route del CIDR-notaion-or-default via your-gw-address dev your-interface`





    
    
## hostname

hostname 保存在 `/etc/hostname`

修改hostname，可以直接修改 `/etc/hostname` ，也可以 `hostnamectl set-hostname my-host-name`

临时修改 hostname： `hostname my-host-name`

本地域名解析配置文件： `/etc/hosts`



## 混杂模式 promiscuous mode

混杂模式下， 网卡将所有数据包发送给OS，而normal mode下，网卡丢弃其他不是发给他的包。

混杂模式一般用于 网络诊断或包嗅探（packet sniffing）

混杂模式的service位置： `/etc/systemd/system/promiscuous@.service`

在  interface enp2s0 上打开混杂模式： `sudo systemctl enable promiscuous@enp2s0.service`



## 网络状态统计 ss / netstat

Display all TCP Sockets with service names: `ss -at`
Display all TCP Sockets with port numbers: `ss -atn`
Display all UDP Sockets: `ss -au`






























