---
layout: post
title: Openwrt强行清理某个DHCP租约，关联 dhcp, dnsmasq
categories: [cm]
tags: []
---

* 参考
  * [Openwrt下dnsmasq强行清理某个DHCP租约](https://hiwbb.com/2021/10/openwrt-release-dhcp-client/)
  * []()
  * []()


编辑 `/tmp/dhcp.leases` 文件，删除想清理的IP地址/MAC地址那一行

重启dnsmasq： `/etc/init.d/dnsmasq restart`















































































