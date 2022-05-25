---
layout: post
title: Google-Service-和-Play-Store安装，关联 GMS, android, root, 刷机， magisk， zygote
categories: []
tags: []
---

* 参考
  * [GApps free - microG is all you need!](https://forum.xda-developers.com/t/gapps-free-microg-is-all-you-need.3553620/page-4)
  * [Can I Flash Gapps over HydrogenOS to Replace the Chinese Incomplete GMS to Pure GMS？](https://forum.xda-developers.com/t/can-i-flash-gapps-over-hydrogenos-to-replace-the-chinese-incomplete-gms-to-pure-gms.4186247/#post-83961701)
  * []()



## opengapps

<https://opengapps.org>



## WeebGapps

* <https://t.me/s/WeebGAppsChannel>

使用 magisk 安装。也可以使用 TWRP 安装。

5.0.0 开始支持 Android 12，文件名中添加uninstall，再安装就达到卸载的效果，例如文件名改为`WeebGApps-uninstall-arm-arm64-11.0-5.0.0.zip`



## nik gapps

* <https://nikgapps.com>
* <https://t.me/NikGapps>
* 下载链接： <https://sourceforge.net/projects/nikgapps/files/>

A Custom Google Apps Package that Suits Everyone Needs! Supports Android 12L (SL), 12 (S), 11 (R), 10 (Q) and 9 (Pie) with Regular Updates

需要使用 TWRP 安装。


## NanoDroid



## MindTheGapps



## microG

* 参考
  * [microG Project](https://microg.org)
  * []()

[microG Project](https://microg.org) is a free software clone of Google’s proprietary core libraries and applications 。

用来替代Google的GMS core、Service Framework等Google控制的组件。

* `Service Core (GmsCore)` is a library app, providing the functionality required to run apps that use Google Play Services or Google Maps Android API (v2).

[More details and installation instructions](https://github.com/microg/android_packages_apps_GmsCore/wiki)

* `Services Framework Proxy (GsfProxy)` is a small helper utility to allow apps developed for Google Cloud to Device Messaging (C2DM) to use the compatible Google Cloud Messaging service included with GmsCore.

[Read GmsCore documentation for details](https://github.com/microg/android_packages_apps_GmsCore/wiki)

* `Unified Network Location Provider (UnifiedNlp)` is a library that provides Wi-Fi- and Cell-tower-based geolocation to applications that use Google’s network location provider. It is included in GmsCore but can also run independently on most Android systems.

[More details and installation instructions](https://github.com/microg/android_packages_apps_UnifiedNlp/blob/master/README.md)

* `Maps API (mapsv1)` is a system library, providing the same functionality as now deprecated Google Maps API (v1).

[More details and installation instructions](https://github.com/microg/android_frameworks_mapsv1)

* `Store (Phonesky)` is a frontend application providing access to the Google Play Store to download and update applications. Development is in early stage and there is no usable application yet.



## MagiskGApps - GApps for Magisk

* [官网](https://mg.pixel-fy.com)
* [github 项目](https://github.com/wacko1805/magiskgapps)
* 下载地址
  * <https://sourceforge.net/projects/magiskgapps/files/r/>
  * <https://mg.pixel-fy.com/download.html>

* [reddit.com - MagiskGApps - GApps for Magisk](https://www.reddit.com/r/Android/comments/kuy36f/magiskgapps_gapps_for_magisk/)


MagiskGApps is an open source GApps package to be used with Magisk. 

* Why MagiskGApps?

MagiskGApps can be uninstalled, meaning it can be installed temporarily
It can be used to change other GApps packages previously installed, meaning a device with core gapps can be changed to stock without wiping the data partition
Super easy to flash and update

* Requirements

Android 11
64-bit Architecture







