---
layout: post
title: virtualbox桥接网卡中看不到任何网卡
categories: [cm, vm]
tags: [bridge]
---

* 参考： 
    * [VirtualBox找不到桥接网卡问题解决](https://blog.csdn.net/helloword4217/article/details/89281652)
    * []()
    * []()



1. 在 Windows “更改适配器选项” 中，右键选择某一个看不见的网卡，右键进入属性
1. 检查是否勾选 `Virtualbox NDIS6 Bridged Networking Driver`，有则勾选；
1. 如果在属性中看不到上述选项，往下继续
1. 在属性选项卡上，点击“安装” \> Service
1. 进入virtualbox安装目录的 `virtualbox-installed-dir/drivers/network/netlwf`











