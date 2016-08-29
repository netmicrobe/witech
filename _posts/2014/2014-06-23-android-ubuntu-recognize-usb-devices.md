---
layout: post
title: android ： ubuntu 识别usb设备
description: 
categories: [android, cm]
tags: [android, ubuntu]
---

### lsusb读出设备的vendor id 和 product id

例如，华为S8600

$ lsusb

Bus 001 Device 008: ID 12d1:1031 Huawei Technologies Co., Ltd. 

12d1 是vendor id

1031 是product id

### 设置usb的使用权限

修改或者创建 /etc/udev/rules.d/51-android.rules

$ sudo vi /etc/udev/rules.d/51-android.rules

添加对应的设备配置：

# Huawei 的所有USB设备进行设置，赋予ethan用户使用权限

SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0666", OWNER="ethan"

或者，指明具体设备：

# Google Nexus 7 16 Gb

SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4e42", MODE="0666", OWNER="your-login"    # MTP mode with USB debug on

或者，将USB权限赋予某个用户组：

SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666", GROUP="plugdev"

### 重启udev服务

$ sudo service udev restart


### 重新拔掉数据线，再插上，即可使用了.

参考：
* android.4.0.docs/tools/device.html
* <http://developer.android.com/tools/device.html>
* <http://bernaerts.dyndns.org/linux/74-ubuntu/245-ubuntu-precise-install-android-sdk>
* <http://source.android.com/source/initializing.html>
* <http://esausilva.com/2010/05/13/setting-up-adbusb-drivers-for-android-devices-in-linux-ubuntu/>

```
Manufacturer	USB Vendor ID 															
Acer	0502
Dell	413c
Foxconn	0489
Garmin-Asus	091E
HTC (Older Phones)	0bb4
HTC (Newer phones) 																18d1
Huawei	12d1
Kyocera	0482
LG	1004
Motorola	22b8
Nexus One/S	18d1
Nvidia	0955
Pantech	10A9
Samsung	04e8
Sharp	04dd
Sony Ericsson	0fce
ZTE	19D2
```