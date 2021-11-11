---
layout: post
title: Windows-to-go-和linux双系统到U盘/移动硬盘，u disk, removable disk
categories: [cm, windows]
tags: [windows-to-go]
---

* 参考
  * []()
  * []()
  * []()


## 大体步骤

1. 使用rufus 写入 windows to go 系统到U盘/移动硬盘
1. 插上Windows to go 盘，同时插入 linux 安装盘
1. 从linux安装盘启动，将linux系统装入wtg盘。


### 调整 wtg 各个分区大小

wtg 生成后，会有3个分区ESP,MSR,WINDOWS分区。

其中，ESP分区小于500M，需要调整。用GParted是不行。

使用 `DiskGenies`（以下简称，`DG`）成功：

1. 缩小Windows分区，提交DG应用修改
1. 将Windows分区向后移动出一些空间，比如300M，提交DG应用修改
1. 删除MSR分区，右键ESP和Windows分区之间空白空间，新建ESP和MSR分区，提交DG应用修改
1. 删除新建的ESP分区，将原来ESP分区扩大。提交DG应用修改











