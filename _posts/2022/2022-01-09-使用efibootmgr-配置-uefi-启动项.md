---
layout: post
title: 使用 efibootmgr 配置 uefi 启动项
categories: [cm]
tags: []
---

* 参考： 
    * [UEFI 与Linux基础：一_cgm88s的专栏-程序员宝宝_linux uefi](https://www.cxybb.com/article/cgm88s/91830509)
    * [Gentoo wiki - Efibootmgr](https://wiki.gentoo.org/wiki/Efibootmgr)
    * []()
    * []()
    * []()
    * []()
    * []()




* EFI 启动项，没法重命名，只能删除后，新建
* MSI 主板 BIOS 能读取的启动项有限，x299 carbon 只有 5个！！
    设置位置： BIOS 》Settings 》Boot 》UEFI Hard Disk Drive BBS Priorites


~~~bash
# 查看当前启动项
efibootmgr

# 查看当前启动项，更详细的信息（包含efi启动文件位置）
efibootmgr -v


# 查看 /boot 下面的启动文件
tree /boot/ -L 3
# 或
find . -type f -name "*.efi"

# 创建启动项 -----------
# 创建从 /dev/sda 第二个分区 启动，启动项lable 为 Gentoo
efibootmgr -c -d /dev/sda -p 2 -L "Gentoo" -l '\efi\boot\bootx64.efi'
~~~


























