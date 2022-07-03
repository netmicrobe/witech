---
layout: post
title: endeavour-os-使用，关联 android, fcitx5, virtualbox, remmina
categories: [ cm, linux ]
tags: []
---

* 参考
    * []()
    * []()

## Android 使用

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

## Virtualbox

~~~sh
sudo pacman -S virtualbox virtualbox-ext-vnc virtualbox-guest-iso virtualbox-guest-utils virtualbox-host-dkms
yay -S virtualbox-ext-oracle
~~~

## 中文输入法

~~~sh
sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-gtk fcitx5-material-color fcitx5-nord fcitx5-qt
~~~

## 远程连接工具

### remmina

~~~sh
yay -S remmina  remmina-plugin-rdesktop freerdp
~~~










































