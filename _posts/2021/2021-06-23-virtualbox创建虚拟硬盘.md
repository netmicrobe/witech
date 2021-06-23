---
layout: post
title: virtualbox创建虚拟硬盘
categories: [ cm, vm ]
tags: [  ]
---

* 参考
  * []()
---


### 创建

1. 某个虚拟机的 Settings  \> Storage \> Controller:SATA \> 点击 `+` 图标 \> Create new disk
1. 按照提示创建新的虚拟硬盘，成功后自动挂载到该虚拟机

### 备份和恢复

* 备份
    1. 文件系统找到目标虚拟硬盘文件，拷贝下

* 恢复
    1. 在虚拟机中删除`脏了的`硬盘
    1. 在VM的`File菜单` \> `Virtual Media Manager...`中也删除该硬盘介质
    Hard disks \> 选择该硬盘介质 \> Remove \> Keep 保留`脏了的`硬盘虚拟文件
    1. 在虚拟机中添加`之前备份`的硬盘文件



































































































