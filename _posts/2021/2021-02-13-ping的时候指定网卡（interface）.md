---
layout: post
title: ping的时候指定interface
categories: [cm, network]
tags: [ping, interface, 多网卡]
---

* 参考： 
    * []()
    * []()
    * []()
    * []()



机器有多个网卡，例如wlan，和有线网卡共存，且连接不同网络。

需要指定interface来ping某个网址的时候，使用 `-I` 参数：

~~~
ping 192.168.2.10 -I wlp2s0
~~~











