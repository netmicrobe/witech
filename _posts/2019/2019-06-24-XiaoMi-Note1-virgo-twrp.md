---
layout: post
title: 小米 Note LTE virgo 安装 Xposed
categories: [ cm, android ]
tags: [ adb, fastboot, bootloader, root, unlock, twrp, xposed ]
---

* 参考
  * [ OFFICIAL  Xposed for Lollipop/Marshmallow/Nougat/Oreo  v90-beta3, 2018/01/29  by rovo89](https://forum.xda-developers.com/showthread.php?t=3034811)
  * []()


# 机型信息

MODEL: MI NOTE LTE
SDK: 23  Android 6.0.1 Marshmallow
PRODUCT: virgo
CPU_ABI: armeabi-v7a


## TWRP

* 参考
  * [twrp 3.1.1 Recovery for Xiaomi Mi Note](https://romprovider.com/2017/10/twrp-3-1-1-virgo/)
  * [MIUI 论坛- 3.1.1-0 for Mi Note (virgo)](https://en.miui.com/thread-628692-1-1.html)
  * [http://diantokam.blogspot.com/2018/01/how-to-install-twrp-3020-on-miui-9-mi.html](How To Install TWRP-3.0.2.0 on MIUI 9 (Mi Note Marshmallow))
  * [How To Root and Install TWRP Recovery On Xiaomi Mi Note (virgo)](https://kbloghub.com/2018/04/root-and-install-twrp-recovery-on-xiaomi-mi-note.html)
  * [TeamWin - TWRP - Xiaomi](https://twrp.me/Devices/Xiaomi/)
  * [8.1.0 Mi Note LTE/Pro (Virgo/Leo) LineageOS15.1 Project 2017.12.14](https://forum.xda-developers.com/mi-note-pro/general/8-1-0-virgo-leo-lineageos15-1-project-t3719175)


1. 下载TWRP for virgo： 
    * [TWRP-20171028-3.1.1.0-virgo.img](https://androidfilehost.com/?fid=962021903579488304) 
      * 15M  可用，粉红色界面底色
    * [TWRP-20190418-3.3.0.0-virgo.img](https://androidfilehost.com/?w=files&flid=199259)

1. 进入 fastboot 模式： `adb reboot bootloader`

1. 检查手机是否连接正常：`fastboot devices`
    没有显示设备，检查驱动是否安装正确。

1. 检查是否解锁

    ~~~
    fastboot oem device-info
    fastboot oem unlock
    ~~~

    注意：unlock 会删除所有信息，重置手机。

1. 安装TWRP Recovery： `fastboot flash recovery TWRP-20171028-3.1.1.0-virgo.img`

1. 重启 `fastboot reboot`



## 安装Xposed


1. 下载 Xposed framework
    SDK23 is Android 6.0 (Marshmallow). 从 <https://dl-xda.xposed.info/framework/> 下载。
    1. [xposed-v89-sdk23-arm.zip](https://dl-xda.xposed.info/framework/sdk23/arm/xposed-v89-sdk23-arm.zip)
    1. [xposed-v89-sdk23-arm.zip.asc](https://dl-xda.xposed.info/framework/sdk23/arm/xposed-v89-sdk23-arm.zip.asc)
1. 使用 TWRP 安装 framework
    1. 将下载的 xposed-v89-sdk23-arm.zip 拷贝进手机
        `adb push xposed-v89-sdk23-arm.zip /sdcard/xposed-v89-sdk23-arm.zip`
    1. 进入Recovery模式
        * 开机状态下：进入“系统更新”，点右上角“…”选择“重启到恢复模式（Recovery）”，点击“立即重启” 进入Recovery模式。
        * 关机状态下：同时按住`音量上+电源键开机`，屏幕亮起松开电源键保持长按音量键 进入Recovery模式。

1. 下载 XposedInstaller_3.1.5.apk 并安装
    <https://dl.xda-developers.com/4/3/9/3/0/8/2/XposedInstaller_3.1.5.apk?key=OWWhsb2JIP6g8kz6OOn4Fw&ts=1561369540>



























