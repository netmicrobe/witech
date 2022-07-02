---
layout: post
title: arch-linux-adb-无法连接手机，报错：no-permissions，关联 android,udev,lsusb
categories: [ cm, linux ]
tags: []
---

* 参考
    * []()
    * []()


### adb 无法 连接 手机，报错： no permissions

* 参考
    * [wiki.archlinux.org - Android Debug Bridge](https://wiki.archlinux.org/title/Android_Debug_Bridge)
    * []()
    * []()
    * []()


1. 使用 `lsusb` 找到手机的 `vendor id` 和 `product id`
    没插手机执行一下 `lsusb` ，插上再执行下，对比下就能找到
1. 添加 udev rules： `/etc/udev/rules.d/51-android.rules`
    文件内容：
    ~~~
    SUBSYSTEM=="usb", ATTR{idVendor}=="[VENDOR ID]", MODE="0660", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="[VENDOR ID]", ATTR{idProduct}=="[PRODUCT ID]", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="[VENDOR ID]", ATTR{idProduct}=="[PRODUCT ID]", SYMLINK+="android_fastboot"
    ~~~
1. 重新查一下手机，udev应该就能自动识别新规则了
1. 如果不行手动reload rule：
    ~~~sh
    udevadm control --reload
    udevadm trigger
    ~~~
















































