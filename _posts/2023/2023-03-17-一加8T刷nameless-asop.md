---
layout: post
title: 一加8T刷nameless-asop，关联 kebab, android, rom, oneplus
categories: [ ]
tags: []
---

* 参考
  * [Install For OnePlus 8/8 Pro & 8T/9R](https://nameless.wiki/getting-started/install/for_8_9R)
  * [Installation instructions](https://telegra.ph/Installation-instructions-07-23-2)
  * []()
  * []()


### 介绍

* 基于 AOSP
* 

## 刷机

1. 刷系统之前的准备
    ~~~sh
    fastboot flash boot boot.img

    fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img

    fastboot flash --disable-verity --disable-verification vbmeta_system vbmeta_system.img

    fastboot flash recovery recovery.img

    fastboot reboot recovery
    ~~~

1. 刷系统

    Reboot your phone to recovery mode, click "Install update" -> "ADB Sideload"

    ~~~sh
    adb sideload Nameless-AOSP_kebab-13.0-20230209-0720-Official.zip
    ~~~

1. Recovery 中恢复下出厂设置： `Factory Reset` -\> `Format data / factory reset`

1. 重启进入系统。


## 实例

### Nameless-AOSP_kebab-13.0-20230209-0720-Official.zip

* Nameless-AOSP_kebab-13.0-20230209-0720-Official.zip
    版本号： 
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
        * 相机： com.oneplus.camera
            版本 5.9.78


* 问题
    * Phone App 是 `com.google.android.dialer`， `不可`录音

* 优点
    * 自带GApps






