---
layout: post
title: linux、Openwrt 修改Mac地址， Mac Address Spoofing
categories: [cm, windows]
tags: [ manjaro, spoof, mac-address, network ]
---

* 参考： 
  * []()
  * []()
  * []()

## Manjaro

~~~
sudo ip link set dev device-name down
sudo ip link set dev device-name address xx:xx:xx:xx:xx:xx
sudo ip link set dev device-name up
~~~


## CentOS

~~~
vi /etc/sysconfig/network-scripts/ifcfg-ens160
添加
MACADDR=xx:xx:xx:xx:xx:xx

service network restart
~~~


## Openwrt

* 参考： 
  * [CSDN - 鱼与羽 - OPENWRT修改MAC(亲测有效)](https://blog.csdn.net/winux123/article/details/50084521)
  * []()


方法一： 在 `/etc/config/network` 修改好后，重启 `/etc/init.d/network restart`

~~~
config device 'lan_eth1_dev'
        option name 'eth1'
        option macaddr '6a:27:19:a5:1d:be'

config device 'wan_eth0_dev'
        option name 'eth0'
        option macaddr '68:27:19:a5:1d:be'
~~~


方法二： 登陆 openwrt 管理页面

1. 网络 》接口
1. LAN 》高级设置 》重设MAC地址
1. WAN 》高级设置 》重设MAC地址





















