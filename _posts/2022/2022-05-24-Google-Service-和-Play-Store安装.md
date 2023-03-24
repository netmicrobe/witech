---
layout: post
title: Google-Service-和-Play-Store安装，关联 GMS, android, root, 刷机， magisk， zygote
categories: []
tags: []
---

* 参考
  * [GApps free - microG is all you need!](https://forum.xda-developers.com/t/gapps-free-microg-is-all-you-need.3553620/page-4)
  * [Can I Flash Gapps over HydrogenOS to Replace the Chinese Incomplete GMS to Pure GMS？](https://forum.xda-developers.com/t/can-i-flash-gapps-over-hydrogenos-to-replace-the-chinese-incomplete-gms-to-pure-gms.4186247/#post-83961701)
  * [Download and install the latest GApps: Open GApps, NikGApps, FlameGApps, and more](https://www.xda-developers.com/download-google-apps-gapps/?newsletter_popup=1)
  * []()
  * []()



## opengapps

<https://opengapps.org>

2023-03,目前只支持到 Android 12L。


## NikGApps

* <https://nikgapps.com>
* <https://t.me/NikGapps>
* [下载地址](https://nikgapps.com/downloads)
    * <https://sourceforge.net/projects/nikgapps/files/>
* [XDA discussion thread on NikGApps](https://forum.xda-developers.com/t/3915866/)

由 XDA Senior Member [Nikhil](https://forum.xda-developers.com/m/nikhil.4867515/) 创建。

需要使用 TWRP 安装。

Android 版本支持：  10 - 13

特点：
* Android Go package for lower-end devices
* 可以 dirty flash



## FlameGApps

* [Download FlameGApps](https://flamegapps.github.io/download)
* [XDA discussion thread on FlameGApps](https://forum.xda-developers.com/t/4020917/)

Formerly known as ExLiteGApps, the FlameGApps project is the brainchild of XDA Senior Member [ayandebnath](https://forum.xda-developers.com/m/ayandebnath.9661715/)

Android Version Support: Android 10 to Android 12/12L.
Platform Support: Arm64.


## BiTGApps

With less than 90MB size, BiTGApps from XDA Senior Member [TheHitMan](https://forum.xda-developers.com/m/thehitman.8569961/) is a distinctive minimalist distribution. 

* [Download BiTGApps](https://bitgapps.github.io/)
* [XDA discussion thread on BiTGApps](https://forum.xda-developers.com/t/4012165/)

Android Version Support: Android Nougat (7.1) to Android 13.
Platform Support: Arm, Arm64.



## LiteGApps

Founded by XDA Senior Member [Wahyu6070](https://forum.xda-developers.com/m/wahyu6070.9507265/), LiteGApps is a unique distribution that covers a wide variety of use cases. You can install it through recovery or as a Magisk module.

* [Download LiteGApps](https://litegapps1.github.io/index.html)
* [XDA discussion thread on LiteGApps](https://forum.xda-developers.com/t/4146013/)

Android Version Support: Android 5.0 Lollipop to Android 13.
Platform Support: Arm, Arm64.



## WeebGapps

* <https://t.me/s/WeebGAppsChannel>

使用 magisk 安装。也可以使用 TWRP 安装。

5.0.0 开始支持 Android 12，文件名中添加uninstall，再安装就达到卸载的效果，例如文件名改为`WeebGApps-uninstall-arm-arm64-11.0-5.0.0.zip`




## NanoDroid



## MindTheGapps

Maintained by LineageOS contributor Alessandro Astone, AKA XDA senior member [aleasto](https://forum.xda-developers.com/m/aleasto.4742143/), MindTheGapps is yet another compact GApps distribution. This one is particularly known in the community for being the officially recommended GApps solution by the LineageOS team for its custom ROM.

* [Download MindTheGapps](http://downloads.codefi.re/jdcteam/javelinanddart/gapps)
   * Mirror: <https://androidfilehost.com/?w=files&flid=322935>
* Android Version Support: Android 10 to Android 13. You can also find separate packages for Android TV. Notably, it hosts legacy packages for Android 9 Pie and Android 8.1 Oreo as well.
* Platform Support: Arm, Arm64 (x86 too, but only for legacy Android builds).
* Variants: None. There's only a single variant with no customization options. It provides everything required to make use of Google systems and nothing more.


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


Originated as a fork of NikGApps, MagiskGapps by [wacko1805](https://github.com/wacko1805) is a completely systemless distribution of Google apps. 

* 特点
  * open source
  * 和Magisk配合使用，随用随装，随时可卸载，不需要清除系统分区

Android Version Support: Android 11 to Android 13.
Platform Support: Arm64.






