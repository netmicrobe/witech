---
layout: post
title: 一加8T刷lineageOS，关联 
categories: [ ]
tags: []
---

* 参考
  * [lineageos.org - Install LineageOS on kebab](https://wiki.lineageos.org/devices/kebab/install)
  * [lineageos.org - Build for kebab](https://wiki.lineageos.org/devices/kebab/build)
  * []()
  * []()


### 从 OxygenOS KB2005_11_C.33 刷到 lineageOS 20 / Android 13

1. 起点
    型号： KB2005
    版本号： OxygenOS KB2005_11_C.33
    Android: 12
    基带版本： Q_V1_p14,Q_V1_P14
    内核版本：  4.19.157-perf+
    硬件版本：  KB2005_11

1. 确保使用 Android 13 Firmware
1. 

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

1. 刷recovery之前，刷人 dtbo.img 、 vbmeta.img
  ~~~sh
  fastboot flash dtbo <dtbo>.img
  fastboot flash vbmeta <vbmeta>.img
  ~~~
1. 刷入 recovery
  ~~~sh
  fastboot flash recovery <recovery_filename>.img
  ~~~
1. 进入 recovery
  执行 `fastboot reboot recovery`，或者关机后，同时按下 `Volume Down` + `Power`
1. 确保firmware分区一致性，防止变砖
    1. 下载 [copy-partitions-20220613-signed.zip](https://mirrorbits.lineageos.org/tools/copy-partitions-20220613-signed.zip)
        MD5 sum : 79f2f860830f023b7030c29bfbea7737
        SHA-256 sum : 92f03b54dc029e9ca2d68858c14b649974838d73fdb006f9a07a503f2eddd2cd.
    1. 刷入 `copy-partitions-20220613-signed.zip`
        1. On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
        1. On the host machine, sideload the package using: `adb sideload copy-partitions-20220613-signed.zip`
    1. 重启到recovery： tapping “Advanced”, then “Reboot to recovery”

1. 刷入 LineageOS 20
1. Recovery 中恢复下出厂设置： `Factory Reset` -\> `Format data / factory reset`
1. 返回 main menu
1. Sideload the LineageOS .zip package
    1. On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
    1. On the host machine, sideload the package using: `adb sideload filename.zip`
    正常会显示 `Total xfer: 1.00x`，
    但是，停在 47% 显示`adb: failed to read command: Success`.
    或者，显示`adb: failed to read command: No error` or `adb: failed to read command: Undefined error: 0`，
    都是正常的。

1. 刷 Google Apps
1. 重启进入 Recovery
1. Sideload the MindTheGapps.zip package
    1. On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
    1. On the host machine, sideload the package using: `adb sideload MindTheGapps-13.0.0-arm64-20221025_100653.zip`
    显示 `Signature verification failed` 是正常的，因为GApps没有使用lineageos官方签名，选择 continue 继续就行。
1. 
1. 重启进入 LineageOS 系统，第一次启动大约 15分钟左右，特别长时间进入不了系统，估计就什么地方有问题了。
1. 
1. 
1. 
1. 
1. 













