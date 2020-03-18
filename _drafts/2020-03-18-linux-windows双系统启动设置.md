---
layout: post
title: linux-windows双系统启动设置
categories: [cm, linux]
tags: []
---

* 参考： 
  * [迁移win10的efi引导分区到系统固态硬盘](https://blog.csdn.net/Sebastien23/article/details/99691881)
  * []()



### windows重装、升级导致grub失效

1. 系统管理员身份运行 `cmd`
1. 执行 `bcdedit /set {bootmgr} path \EFI\ubuntu\grubx64.efi`
1. 如果不行，尝试： `bcdedit /deletevalue {bootmgr} path \EFI\ubuntu\grubx64.efi`

### 恢复使用 Windows boot manager

1.  `bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi`


### 迁移win10的efi引导分区到系统固态硬盘

1. Windows安装U盘启动系统，按SHIFT+F10进入命令行。
    ~~~
    diskpart
    list disk
    select disk your-disk-no # Note: Select the disk where you want to add the EFI System partition
    list partition

    select partition your-partition-no # Note: Select the Windows OS partition or your data partition
    shrink desired=100 # 从目前启动盘中挤出 100 M，这里单位是M，数值多少更具要迁移过来的那个EFI分区大小来确定
    create partition efi size=100
    format quick fs=fat32
    assign letter=select

    list partition
    list volume # 记录下Windows系统盘此时的Volume，不一定是C哦，例如，这个命令输出列表里可能是：F
    exit  # 推出 DiskPart..

    bcdboot F:\Windows /s S:
    ~~~

1. 拔掉U盘，重启系统






































