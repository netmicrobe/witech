---
layout: post
title: unlock, root LG Nexus 5X
categories: [cm, phone]
tags: [刷机, flash, rom]
---

* 参考：
  * [ xda-developers - LG Nexus 5X - [GUIDE] Unlock/Root/Flash for Nexus 5X by SlimSnoopOS](https://forum.xda-developers.com/nexus-5x/general/guides-how-to-guides-beginners-t3206930)
  * [xda - Nexus 5X Rooting](https://www.xda-developers.com/nexus-5x-rooting/)


## How To Unlock Your Bootloader

1. 打开开发者选项，开启USB调试
2. 关机，启动进 bootloader (power + volume down).
3. Connect your phone to your PC via usb cable.
4. Check your fastboot connection by issuing this command:
    ~~~
    fastboot devices
    ~~~
5. 解锁
    ~~~
    fastboot oem unlock
    ~~~
    **This will erase all user data from the device!**
6. 在手机屏幕上确认解锁。
7. 重启。 `fastboot reboot`


## How To Install A Custom Recovery On Your Device

1. Download [TWRP Recovery](https://dl.twrp.me/bullhead/)
1. Make sure you check the md5 to verify its integrity (where possible).
1. Place the file in your fastboot folder (this is where fastboot.exe is located on your PC).
1. 重启进入 bootloader (power + volume down).
1. Open a command prompt from within your fastboot folder (navigate to where you have fastboot.exe located on your PC, shift + right click anywhere within that folder, select open command prompt here), enter this command:
    ~~~
    fastboot flash recovery filename.img
    ~~~
1. 重启进入TWRP recovery
    Use the volume keys to scroll and power key to select the Reboot Bootloader option. Once the phone has booted back into the bootloader, use the volume keys to scroll and the power key to boot into your newly flashed recovery.
1. It's now safe to disconnect your usb cable. If using Nougat 7.0 or newer, you must now boot directly into TWRP and flash SuperSU (or your preferred root alternative) so that TWRP will persist between reboots.

<div style="color:red">
注意：
我的Nexus5x刷完之后可以进入 TWRP 3.2.1。
但后，重启就不能再进入，提示“no command”
我解决方法是，再装一次 TWRP ，趁能进入TWRP，刷一下SuperSU，
天可怜见，能成功。
</div>


* 后继
  * When TWRP boots up you'll be asked 
    "whether you want to allow system modifications or to keep it read-only",
    choose to **allow system modifications**, there's no benefit to keeping it read-only.
  * 不要使用TWRP提供的SuperSU版本。
    * Do not flash the version of SuperSU that TWRP offers to flash for you in order to give you root, it is not compatible and will cause problems. When you attempt to reboot out of TWRP it will tell you that it's detecting that you don't have root and it will offer to root for you, **skip past this**.


### 临时使用 TWRP

Some users need a custom recovery for a temporary period, so they live boot the recovery. In this scenario, the custom recovery replaces the stock recovery until a reboot is performed. Place the file in your fastboot folder then enter this command:

~~~
fastboot boot filename.img
~~~


## How To Decrypt Your Data Partition

This is no longer necessary as long as you use TWRP 2.8.7.1 or newer

In order for TWRP to be able to read/write on your data partition (to root or create a nandroid backup) you will need to format it, a format will remove encryption.

1. Boot into the bootloader and connect your phone to your PC via usb cable.
1. Open a command prompt from within your fastboot folder (navigate to where you have fastboot.exe located on your PC, shift + right click anywhere within that folder, select open command prompt here), enter this command:
    ~~~
    fastboot format userdata
    ~~~
    **Please note: this will erase all user data from the device!**
* 重启回bootloader： `fastboot reboot-bootloader`



## How To Root

1. Download the latest SuperSU of your choosing to your phone:
  * <https://forum.xda-developers.com/apps/supersu>
1. Boot into TWRP recovery and enter the install menu.
1. Navigate to where you have SuperSU stored on your internal storage and select it.
1. Swipe to install.
1. Once you've installed SuperSU you'll have an option to wipe cache/dalvik and an option to reboot system. Wipe the cache/dalvik, hit the back button, and hit the reboot system button. That's it.
























## Quick Tips

### How to boot into the bootloader:

~~~
adb reboot bootloader
~~~

### How to boot into recovery:

~~~
adb reboot recovery
~~~









