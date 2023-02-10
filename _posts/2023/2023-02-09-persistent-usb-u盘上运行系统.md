---
layout: post
title: persistent-usb-u盘上运行系统，关联 linux, BSD, unix, windows
categories: [ ]
tags: []
---

* 参考
  * [How to Create a Linux Live USB With Persistence Using Easy2boot](https://www.baeldung.com/linux/easy2boot-live-usb-persistence)
  * [antiX-FAQ Persistence Options](https://download.tuxfamily.org/antix/docs-antiX-19/FAQ/persistence.html)
  * [github.com - MX-Linux - mx-remaster](https://github.com/MX-Linux/mx-remaster)
  * [GRUB starts in command line after reboot](https://unix.stackexchange.com/questions/329926/grub-starts-in-command-line-after-reboot)
  * [wiki.archlinux.org - GRUB](https://wiki.archlinux.org/title/GRUB)
  * [Live-USB - persistente Installation](https://wiki.ubuntuusers.de/Archiv/Live-USB_-_persistente_Installation/)
  * [How to create a Debian live USB with persistence?](https://unix.stackexchange.com/questions/118965/how-to-create-a-debian-live-usb-with-persistence)
  * [DebianLiveLiveUsbPersistence](https://wiki.debian.org/DebianLive/LiveUsbPersistence)
  * []()



## antiX / MX linux

* 参考
  * [antiX-FAQ Persistence Options](https://download.tuxfamily.org/antix/docs-antiX-19/FAQ/persistence.html)
  * [antiX-FAQ - Live Boot Parameters](https://download.tuxfamily.org/antix/docs-antiX-19/FAQ/boot-params.html)
  * [github.com - MX-Linux - mx-remaster](https://github.com/MX-Linux/mx-remaster)
  * [mxlinux.org - HELP: MX Remaster](https://mxlinux.org/wiki/help-files/help-mx-remaster/)
  * [antixlinux.com - The Most Extensive Live-usb on the Planet!](https://antixlinux.com/the-most-extensive-live-usb-on-the-planet/)
  * [antixlinuxfan.miraheze.org - antiX How to install](https://antixlinuxfan.miraheze.org/wiki/How_to_install)
  * [antixlinuxfan.miraheze.org - Boot_Parameters](https://antixlinuxfan.miraheze.org/wiki/Boot_Parameters)
  * [github - live-usb-maker](https://github.com/BitJam/live-usb-maker)
    Create an antiX/MX LiveUSB
    Create a live-usb from an iso-file, another live-usb, a live-cd/dvd
  or a running live system. 
  * [antixlinuxfan.miraheze.org - Table of antiX Boot Parameters](https://antixlinuxfan.miraheze.org/wiki/Table_of_antiX_Boot_Parameters)
  * [mxlinux.org - boot-parameters](https://mxlinux.org/wiki/system/boot-parameters/)
  * [gitlab.com - antiX-Linux - live-initrd.gz](https://gitlab.com/antiX-Linux/live-initrd.gz)
  * [Persistent MX Linux on Flash Drive](https://www.techsolveprac.com/persistent-portable-mx-linux/)




### MX 21.3 KDE Live USB

* 制作 Live Live

    1. MX Linux中使用 Live USB Creator 工具制作启动盘
        `Live USB Creator`工具选择 `Full-feature USB` ，而不是 live image
    1. 插入USB启动盘，到达MX Linux启动菜单页面。
    1. 配置 persistence
        * Legacy
            1. `F5` 选择 Persist 选项
                * `persist_static` 如果是移动SSD，选择这个，在系统运行时的改动直接回写硬盘，这样需要写盘速度快，否则系统会运行很慢。
                * `persist_all` 如果是U盘，写速度慢，这个选项表示运行时写入RAM，关机是回写存储。
            1. `F8` 选择 Save，保存设置
        * UEFI
            1. 进入 `Advanced Options` 菜单项
                * Persistenct option: `persist_static`
                    也可以选 `p_static_root` ，这样 rootfs 和 homefs 合并成一个文件。`persist_static` 会分别产生 rootfs 和 homefs 文件。
                * Boot options: `from=usb`
                * Save options: `grubsave Save options(LiveUSB only) -> GRUB menu`
            1. 选择 `<=== Back to main menu`
            1. 选择 `MX-21.3 x64(最近一次保存日期)`
                第一次进入，会要选择语言、时区、rootfs/homefs/linuxfs的大小等等信息。
    1. 启动进MX Linux系统。


* 配置
    修改启动菜单的 timeout 时间，

    `/live/boot-dev/boot/grub/config/bootmenu.cfg` 中修改 `set timeout=10` ，即等待10秒。

    在 `/live/boot-dev/boot/grub/grub.cfg` 修改 `set timeout=xx` 没有用。

    可以在 `/live/boot-dev/boot/grub/grub.cfg` 中修改启动的菜单项。


    参考： [antixlinuxfan.miraheze.org - Boot_Parameters](https://antixlinuxfan.miraheze.org/wiki/Boot_Parameters)

    * LIVE or FRUGAL install
    Depending on your system (and BIOS/UEFI configuration), antiX live will boot differently.

        * Legacy_BIOS boot (syslinux/isolinux)
            Type the boot parameters directly in the boot screen. You will see the rectangle in the middle of the screen change with the boot parameters you add/remove. Pressing Enter key will boot into your live system with the selected boot options.

            If your live medium can save changes, you can use the boot parameter gfxsave to save the boot option changes or (inside the running antiX live system) edit the files `/live/boot-dev/boot/isolinux/isolinux.cfg` and `/live/boot-dev/boot/syslinux/syslinux.cfg` and even change and customize the menu as you want.

        * UEFI boot (grub)
            On the UEFI boot screen, if the boot options you want to select are not available using the text menus (menus), you can add them in the same way as the installed grub method, by pressing the e key and editing the parameters in the third line starting with vmlinuz, and pressing F10 to boot with the selected parameters.

            If your live medium can save changes, you can use the boot parameter bootsave to save the boot option changes or (inside the running antiX live system) edit the file `/live/boot-dev/boot/grub/grub.cfg` (with root privileges) and even change and customize the menu as you want.

            See Help:[antiX Boot Parameters](https://antixlinuxfan.miraheze.org/wiki/Help:AntiX_Boot_Parameters) for a more complete list of Boot Parameters.







## NomadBSD

https://nomadbsd.org/

BSD unix, 图形界面类似mac，软件齐全。

提供 xxx.img.lzma 作为系统下载，而不是iso.

安装方法： 使用 7zip 解压 lzma 文件，使用 balenaetcher 将解压后的img文件刷到U盘。

最新一次发布是 2022-11-30，支持 x86（包括mac），arm 不支持。

NomadBSD is a persistent live system for USB flash drives, based on FreeBSD®. Together with automatic hardware detection and setup, it is configured to be used as a desktop system that works out of the box, but can also be used for data recovery, for educational purposes, or to test FreeBSD®'s hardware compatibility.




