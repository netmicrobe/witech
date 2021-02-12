---
layout: post
title: ssh的时候指定网卡（interface）
categories: [cm, network]
tags: [ssh, scp, interface, 多网卡]
---

* 参考： 
    * [Force SSH connection through a different interface](https://serverfault.com/questions/417035/force-ssh-connection-through-a-different-interface)
    * [Use ssh with a specific network interface](https://unix.stackexchange.com/questions/16057/use-ssh-with-a-specific-network-interface)
    * []()
    * []()



机器有多个网卡，例如wlan，和有线网卡共存，且连接不同网络。

可以使用命令参数，来指定使用哪个网卡，但是如果本地的路由表设置，优先起作用。

如果参数设置无效，那么就只能修改 local route table来解决了。

## ssh的时候指定网卡

需要指定interface / ip地址 来指定通过哪个网卡去ssh的时候：

~~~
ssh -B wlan0 192.168.1.100
# 或者
ssh -b 192.168.1.101 192.168.1.100
~~~

## scp的时候指定网卡

~~~
scp -o BindInterface=wlan0 some-file root@192.168.100.10:/some-path
# 或者
scp -o BindAddress=192.168.1.101 some-file root@192.168.100.10:/some-path
~~~











