---
layout: post
title: macbook pro 2018 到 os 从mojave 降级到 high sierra
categories: [ cm, mac ]
tags: [operating-system, macintosh]
---

* 参考
  * [【Mac教程】如何从macOS Mojave降级到macOS High Sierra](https://www.jianshu.com/p/c390f46f0530)
  * [Bootable USB Installers for OS X Mavericks, Yosemite, El Capitan, and Sierra](https://discussions.apple.com/thread/8626707)
   * [How to create a bootable installer for macOS](https://support.apple.com/en-us/HT201372)
   * [How to reinstall macOS from macOS Recovery](https://support.apple.com/en-us/HT204904)
   * []()


## 从mojave 降级到 high sierra

1. 下载 High Sierra
    从 <https://itunes.apple.com/cn/app/macos-high-sierra/id1246284741?mt=12> 跳转到 App Store，点击“获取”来下载 High Sierra 最新版。
    会下载到 `/Applications/Install\ macOS\ High\ Sierra.app`

2. 格式化U盘，作为启动盘

    用 12G 以上的U盘。

    打开 “应用程序 → 实用工具 → 磁盘工具”，将U盘「抹掉」(格式化) 成「Mac OS X 扩展（日志式）」格式，并将U盘命名为「HIGH_SIERRA」。

    ![](format-u-disk.png)

3. 使用 createinstallmedia 命令制作启动盘。

    打开 “应用程序→实用工具→终端”，将下面的一段命令复制并粘贴进去：

    U盘制作过程 20分钟左右。

    ~~~
    $ sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/HIGH_SIERRA

    Ready to start.
    To continue we need to erase the volume at /Volumes/HIGH_SIERRA.
    If you wish to continue type (Y) then press return: Y
    Erasing Disk: 0%... 10%... 20%... 30%...100%...
    Copying installer files to disk...
    Copy complete.
    Making disk bootable...
    Copying boot files...
    Copy complete.
    Done.
    ~~~

4. 通过 U 盘安装 high Sierra ，抹盘全新安装系统

    1. 按下电源键开机，当听到“噹”的一声时，按住 Option 键不放，直到出现启动菜单选项，选择U盘启动。
    2. 选择【磁盘工具】格式化电脑硬盘
        ![](format-harddisk.jpeg)
    3. 选择【安装macOS】按照新系统到硬盘。
        ![](install-to-harddisk.jpeg)



## 使用macOS Recovery回退（电脑出厂就是High Sierra）

1. 启动电脑，迅速按下组合键 `Shift-Option-⌘-R`，看到apple logo后松开，进入 macOS Recovery
    ![](macos-high-sierra-recovery-mode-reinstall.jpg)
    组合键参考
    | Command (⌘)-R    |     Install the latest macOS that was installed on your Mac.
    | Option-⌘-R           |     Upgrade to the latest macOS compatible with your Mac.
    | Shift-Option-⌘-R  |     Install the macOS that came with your Mac, or the closest version still available.

2. 如果要格式化硬盘，就选择 “Disk Utility”

3. 选择：“Reinstall macOS”，点继续，期间可能重启几次。



## 附录

### 格式化硬盘时候，使用 APFS 还是 Mac OS Extended

High Sierra 和以后版本，使用APFS，但也可以选 Mac OS Extended，High Sierra和以后的OS installer 安装系统时自动转成 APFS。

Disk Utility in macOS High Sierra or later can erase most disks and volumes for Mac using either the newer APFS (Apple File System) format or the older Mac OS Extended format, and it automatically chooses a compatible format for you.

Are you formatting the disk that came built into your Mac?
If the built-in disk came APFS-formatted, don't change it to Mac OS Extended.

Are you about to install macOS High Sierra or later on the disk?
If you need to erase your disk before installing High Sierra or later for the first time on that disk, choose Mac OS Extended (Journaled). During installation, the macOS installer decides whether to automatically convert to APFS—without erasing your files:

macOS Mojave: The installer converts from Mac OS Extended to APFS.
macOS High Sierra: The installer converts from Mac OS Extended to APFS only if the volume is on an SSD or other all-flash storage device. Fusion Drives and traditional hard disk drives (HDDs) aren't converted. 
Are you preparing a Time Machine backup disk or bootable installer?
Choose Mac OS Extended (Journaled) for any disk that you plan to use with Time Machine or as a bootable installer.

Will you be using the disk with another Mac?
If the other Mac isn't using High Sierra or later, choose Mac OS Extended (Journaled). Earlier versions of macOS don't mount APFS-formatted volumes.



### Create Installer

~~~
*Command for macOS Mojave:

sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

*Command for macOS High Sierra:

sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

Command for macOS Sierra:

sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ macOS\ Sierra.app

Command for El Capitan:

sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app

Command for Yosemite:

sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ Yosemite.app

Command for Mavericks:

sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ Mavericks.app
~~~



### Boot Using OPTION key


Restart the computer.
Immediately after the chime press and hold down the  "OPTION" key.
Release the key when the Boot Manager screen appears.
Select the disk icon for the USB flash drive.
Click on the arrow button under the disk icon.


