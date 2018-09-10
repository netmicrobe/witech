---
layout: post
title: 安装xposed
categories: [ cm, android ]
tags: [android, xposed]
---

---

* 参考
  * [Xposed Module Repository - Xposed Installer](http://repo.xposed.info/module/de.robv.android.xposed.installer)
  * [Xposed Framework: What It Is and How to Install It](https://www.lifewire.com/xposed-framework-4148451)
  * <https://forum.xda-developers.com/xposed>

---

## 介绍

Xposed is a framework for modules that can change the behavior of the system and apps without touching any APKs.

The basic idea is that after installing an app called Xposed Installer, you can use it to find and install other apps/mods that can do a wide variety of things. Some might provide little tweaks to the OS like hiding the carrier label from the status bar, or larger functionality changes to third-party apps like auto-saving incoming Snapchat messages.




## 安装

### Android 4.0.3 up to Android 4.4 且 root

1. 下载 xposed框架 apk
    * Support/Discussion URL: <http://forum.xda-developers.com/xposed>
    * Source code URL: <https://github.com/rovo89/XposedInstaller>
    * Package: de.robv.android.xposed.installer
    * Version name: 2.7 experimental1
    * Release type: Experimental (high risk of bugs)
    * Download: [de.robv.android.xposed.installer_v33_36570c.apk (770.28 KB)](https://dl-xda.xposed.info/modules/de.robv.android.xposed.installer_v33_36570c.apk)
    * MD5 checksum: 36570c6fac687ffe08107e6a72bd3da7
    * Uploaded on: Thursday, June 19, 2014 - 15:19


2. 启动 Xposed Installer，进入“框架” 》“安装/更新”，安装成功后，自动重启

3. 重启后，进入Xposed，点击“下载”，即可下载各种module
    例如，fake lbs 经纬度的模块：（Mock Location）定位修改




































