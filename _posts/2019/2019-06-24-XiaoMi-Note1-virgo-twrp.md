---
layout: post
title: 小米 Note LTE virgo 安装 Xposed
categories: [ cm, android ]
tags: [ adb, fastboot, bootloader, root, unlock, twrp, xposed ]
---

* 参考
  * [ OFFICIAL  Xposed for Lollipop/Marshmallow/Nougat/Oreo  v90-beta3, 2018/01/29  by rovo89](https://forum.xda-developers.com/showthread.php?t=3034811)
  * [xda-developers.com - Xiaomi 机型专区](https://forum.xda-developers.com/c/xiaomi.12005/)
  * [8.1.0  Mi Note LTE/Pro  (Virgo/Leo) LineageOS15.1 Project  2017.12.14 ](https://forum.xda-developers.com/t/8-1-0-mi-note-lte-pro-virgo-leo-lineageos15-1-project-2017-12-14.3719175/)
  * []()
  * []()
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



## os ROM

* [mokee - virgo](https://download.mokeedev.com/?device=virgo)

### 刷机成功的例子

#### mokee 7.1（Android 7.1.2） + OpenGApp Arm 7.1

1. 进入 TWRP 3.1.1.0，依次刷入：
    1. MK71.2-virgo-190228-HISTORY.zip
    1. open_gapps-arm-7.1-pico-20220215.zip
1. 重启，等好一会就进去了（中途不要联网检查更新，很慢）

**注意！！！！** `不要恢复出厂设置，会线刷救砖收场`。


#### mokee 8.1.0（Android 8.1.0） + OpenGApp Arm 8.1.0

1. 进入 TWRP 3.1.1.0，依次刷入：
    1. MK81.0-virgo-200215-HISTORY.zip
    1. open_gapps-arm-8.1-pico-20220215.zip


刷好进入系统，提示“Goolge语言服务停止”，确定后也没啥影响。

要输入中文，得先联网，提示正在下载语言包。一会就能输入中文了。

**注意！！！！** `adb connect 上去过会就断掉了`。

#### lineage-15.1-20171212_100912-UNOFFICIAL-virgo.zip

1. 进入 TWRP 3.1.1.0，依次刷入：
    1. lineage-15.1-20171212_100912-UNOFFICIAL-virgo.zip

没法安装Google 拼音输入法，不知道是不是应为没装 GApp和框架的原因。

刷好进入系统，提示“Speech Services by Google has stopped”，确定后也没啥影响。

lineage 15 based on Android 8.1

### 刷机失败的例子

* mokee 10 + OpenGApp Arm 10
    刷到OpenGapp的时候，提示存储空间不足。




















