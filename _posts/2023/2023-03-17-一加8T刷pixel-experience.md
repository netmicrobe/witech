---
layout: post
title: 一加8T刷pixel-experience，关联 kebab, android, rom, oneplus
categories: [ ]
tags: []
---

* 参考
  * [pixelexperience.org - Install PixelExperience on kebab](https://wiki.pixelexperience.org/devices/kebab/install/)
  * [ROM-13.0-OnePlus8T- PixelExperience -AOSP/UNOFFICIAL - MAR 18, 2023](https://forum.xda-developers.com/t/rom-13-0-oneplus8t-pixelexperience-aosp-unofficial-mar-18-2023.4529051/)
  * []()
  * []()


### PixelExperience 介绍

* 基于 AOSP
* ROM已包含 Google Apps


### 从 OxygenOS KB2005_11_C.33 刷到 PixelExperience 13 / Android 13

1. 起点
    型号： KB2005
    版本号： OxygenOS KB2005_11_C.33
    Android: 12
    基带版本： Q_V1_p14,Q_V1_P14
    内核版本：  4.19.157-perf+
    硬件版本：  KB2005_11
1. ==================================================================
1. 确保使用 Android 13 Firmware

1. ==================================================================
1. 解锁
    注意：解锁后所有数据丢失，系统重置！！
    ~~~sh
    # 重启进入bootloader, 执行如下命令，
    # 或者 关闭手机，同时按下 音量上 + 音量下 + 电源键
    adb reboot bootloader
    
    fastboot devices
    fastboot oem device-info
    fastboot oem unlock
    ~~~ 
 
1. ==================================================================
1. 刷recovery之前，刷人 dtbo.img 、 vbmeta.img
1. 下载 [vbmeta.img](https://gitlab.pixelexperience.org/android/vendor-blobs/wiki_blobs_kebab/-/raw/main/android-13/vbmeta.img?inline=false)
1. 下载 [dtbo.img](https://gitlab.pixelexperience.org/android/vendor-blobs/wiki_blobs_kebab/-/raw/main/android-13/dtbo.img?inline=false)
1. 重启进入 bootloader
    ~~~sh
    fastboot flash vbmeta vbmeta.img
    fastboot flash dtbo dtbo.img
    ~~~

1. ==================================================================
1. 刷入 recovery
1. 下载 recovery，[下载页面](https://download.pixelexperience.org/kebab)
    ~~~sh
    # 重启进入bootloader，或者执行下面命令，或者同时按下 Volume Up + Volume Down + Power
    adb reboot bootloader
    fastboot flash recovery <recovery_filename>.img
    fastboot reboot recovery
    ~~~

1. ==================================================================
1. 刷入 检测脚本，检测firmware 分区一致性
1. 下载 [ copy-partitions-20210323_1922.zip](https://github.com/PixelExperience-Devices/blobs/blob/main/copy-partitions-20210323_1922.zip?raw=true)
1. Sideload the copy-partitions-20210323_1922.zip package:
    On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
    On the host machine, sideload the package using: `adb sideload copy-partitions-20210323_1922.zip`
1. 重启到 recovery


1. ==================================================================
1. 刷入 PixelExperience
1. 下载或自己编译rom
    下载地址： https://download.pixelexperience.org/kebab
    编译：  https://wiki.pixelexperience.org/devices/kebab/build
1. 重启到 recovery
1. 恢复出厂设置： tap Factory Reset, then Format data / factory reset
1. Sideload the PixelExperience .zip package:
    On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
    On the host machine, sideload the package using: `adb sideload filename.zip`

1. 刷完就重启进System，一般 15分钟左右。














