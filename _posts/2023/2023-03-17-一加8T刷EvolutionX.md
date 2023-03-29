---
layout: post
title: 一加8T刷EvolutionX，关联 kebab, android, rom, oneplus
categories: [ ]
tags: []
---

* 参考
  * []()
  * [ROM 13.0_r30 OFFICIAL  Evolution X 7.6.2  03/05/2023](https://forum.xda-developers.com/t/rom-13-0_r30-official-evolution-x-7-6-2-03-05-2023.4480927/#post-87295275)
  * []()
  * []()
  * []()
  * []()
  * []()





## EvolutionX

* 没有自带 Google Apps，刷完系统rom，要刷GApps


## First Time Install (8T & 9R)

1. Be on the latest OOS13 (F.62 for 8T & F.21 for 9R)
2. Download `copy_partitions`, `vbmeta`, `recovery`, and rom for your device from here
3. Reboot to bootloader
4. flash
    ~~~sh
    fastboot flash vbmeta vbmeta.img
    fastboot flash recovery recovery.img
    fastboot reboot recovery
    ~~~
5. While in recovery, navigate to Apply update -> Apply from ADB
6. `adb sideload copy_partitions.zip` (press "yes" when signature verification fails) and then reboot to recovery
7. Repeat step 5 and adb sideload rom.zip (replace "rom" with actual filename)
8. Format data, reboot to system

Please note that if you are not on F.15 (kebab) or F.19 or above (lemonades) firmware, your proximity sensor will cease to function until you update to said firmware!!

## Update (8, 8 Pro, 8T & 9R)

1. Reboot to recovery
2. While in recovery, navigate to Apply update -> Apply from ADB
3. adb sideload rom.zip (replace "rom" with actual filename)
4. Reboot to system


## Firmware update:

FLASHING THE WRONG DDR TYPE WILL `SEMI BRICK` YOUR DEVICE. THE ONLY WAY TO RECOVER FROM THIS IS BY PURCHASING [AN EDL DEEP FLASH CABLE](https://www.amazon.com/Deep-Flash-Qualcomm-Cable-Octopus/dp/B06XB76BH3?tag=xdaforum01-20) AND USING IT IN-CONJUNCTION WITH MSMTOOL!!

### Spoiler: Method 1

1. Check your DDR type using the following command:

    `adb shell getprop ro.boot.ddr_type`

    0 = ddr4
    1 = ddr5

    if getprop returns an empty value, use the following commands instead (requires root):
    ~~~sh
    adb shell
    su
    cat /proc/devinfo/ddr_type
    ~~~

    DDR4 = DDR4
    DDR5 = DDR5

2. Download and flash the firmware zip that matches your device and DDR type:

    [8T (kebab)](https://www.mediafire.com/folder/2gpefcni2siwo/OnePlus_8T_(KB200x))


3. Reboot to recovery and then sideload the ROM.


## 实例

### ProjectElixir_3.6_kebab-13.0-20230222-1307-OFFICIAL.zip

* ProjectElixir_3.6_kebab-13.0-20230222-1307-OFFICIAL.zip
    版本号： aosp_kebab-userdebug 13 TQ1A.230205.002 1677071239 release-keys
    ProjectElixir 版本： 3.6
    型号变成： KB2000
    Android: 13
    * 自带GApps
        * Play Store: com.android.vending
            版本 30.4.21-21 [0] [PR] 475636937
        * Google: com.google.android.googlequicksearchbox
            版本 13.21.17.29.arm64
        * 电话： com.google.android.dialer
            版本 86.2.468079596
        * 通讯录： com.google.android.contacts
            版本 3.68.0.449257315
        * 短信： com.google.android.apps.messaging
            版本 messages.android_20220809_01_RC02_alldpi.arm64-v8a.phone
        * 相机： org.lineageos.aperture
            版本 13  versionCode 33
        * 拼音输入法
            com.google.android.inputmethod.latin-11.9.06.452014594-preload-arm64-v8a-Gboard.apk


* 问题
    * Phone App `不可`录音

* 优点
    * 自带GApps
    * 不用手动下载GBoard来支持拼音输入，自动识别中文环境，下载语言包，下载好就可以直接使用中文拼音输入了。
























