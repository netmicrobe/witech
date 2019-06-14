---
layout: post
title: 创建Kali Live USB / U 盘运行Kali
categories: [cm, linux]
tags: []
---

* 参考： 
  * [官网文档 - Making a Kali Bootable USB Drive](https://docs.kali.org/downloading/kali-linux-live-usb-install)
  * [官网文档 - Kali Linux Live USB Persistence](https://docs.kali.org/downloading/kali-linux-live-usb-persistence)


## 下载Kali

<https://www.kali.org/downloads/>


## Linux 上创建Kali Live USB（重启后数据保留， aka, Persistence USB Stick）

### 创建usb启动盘

~~~
# 找到目标u盘，例如， /dev/sdc
sudo fdisk -l

# 我用的u盘是在MacBook上格式化的FAT，dd 将kali iso刷进去结果分区的乱了。
# so，建议先将u盘格式化为 linux 分区，例如 ext4
sudo fdisk /dev/sdc
# 进入fdisk，删除所有分区，创建一个linux分区，退出前别忘 w 写入。
sudo mkfs.ext4 /dev/sdc1


# 写入，注意！！ of 参数值一定要写对，否则其他盘数据被抹掉，悔之晚矣！！dd命令一回车就开始执行啦
dd if=/path-to-kali-iso/kali-linux-2019.2-amd64.iso | pv | sudo dd of=/dev/sdc

~~~




