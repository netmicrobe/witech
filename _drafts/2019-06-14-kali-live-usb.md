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

1. 创建usb启动盘

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

2. 重启后数据保留

~~~
# 已经使用上述dd的方法创建了usb启动盘

# 找到目标u盘，例如， /dev/sdc
sudo fdisk -l

# 计算新分区的位置
end=7gb
read start _ < <(du -bcm kali-linux-2016.2-amd64.iso | tail -1); echo $start
# parted命令会建议分区大小，接受建议；然后，会提醒分区没对齐，“Ignore”。（dd创建启动盘的时候就没对齐，其实扇区是64, 装到ssd上，可以使用工具把启动扇区改到2048，对齐下速度快很多。）
parted /dev/sdb mkpart primary $start $end

# 格式化新分区，命名为 persistence
mkfs.ext3 -L persistence /dev/sdb3
e2label /dev/sdb3 persistence

# 在新分区更目录创建 persistence.conf
cd /media/wi/persistence
echo "/ union" > /mnt/my_usb/persistence.conf
~~~






























