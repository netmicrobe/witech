---
layout: post
title: openwrt-添加自定义DNS解析
categories: [cm, openwrt]
tags: [network, 路由器, dnsmasq]
---

* 参考： 
  * [如何正常的设置OpenWrt的DNS,OpenWrt_DNS设置预防劫持，DNS污染正确设置](https://aisoa.cn/post-2093.html)
  * [DNSmasq详细解析及详细配置](https://cloud.tencent.com/developer/article/1174717)
  * [全方面讲解OpenWrt的DNS配置与DHCP，并介绍dnsmasq DNS缓存工具、nslookup/dig DNS测试工具](https://blog.51cto.com/u_15346415/3694596)
  * [Openwrt路由自带hosts功能](https://www.5yun.org/21010.html)
  * []()
  * []()
  * []()


### 配置方法

ssh到路由器上，修改 `/etc/hosts`，添加一行：

`192.168.1.1 o.cn`

之后再重启dnsmasq `service dnsmasq restart`，通过浏览器输入 `o.cn` 就进入 192.168.1.1了。


### dnsmasq的解析流程

dnsmasq先去解析hosts文件， 再去解析/etc/dnsmasq.d/下的*.conf文件，并且这些文件的优先级要高于dnsmasq.conf，我们自定义的resolv.dnsmasq.conf中的DNS也被称为上游DNS，这是最后去查询解析的；

如果不想用hosts文件做解析，我们可以在/etc/dnsmasq.conf中加入no-hosts这条语句，这样的话就直接查询上游DNS了，如果我们不想做上游查询，就是不想做正常的解析，我们可以加入no-reslov这条语句。


### 找到最好的DNS解析地址

访问在线ping工具， 输入域名 `brave-browser-apt-release.s3.brave.com` ，找到解析速度最快的IP

目前可用的ping工具：

* <https://www.wepcc.com>
* <https://tools.ipip.net/ping.php>
* <http://www.webkaka.com/ping.aspx>
* <https://www.boce.com/ping>
* 
* 

