---
layout: post
title: google Nexus 和 Pixel 设备刷机
categories: [ cm, android ]
tags: [ android, image-file ]
---

* [Google - 刷机包下载和说明](https://developers.google.com/android/images)
* [Google - Android SDK Platform-Tools package](https://developer.android.com/studio/releases/platform-tools.html)
* [菊部制造 - Nexus 5X的Android 8.0 Oreo刷机步骤](https://www.jubuzz.com/reprint/418.html)




## Flashing instructions 刷机步骤

### 下载

1. 下载对应机型的刷机文件，例如，Nexus 5X 对应的 bullhead 的刷机包 bullhead-opm1.171019.011-factory-3be6fd1c.zip ， 有1G大小呀
2. 下载最新的刷机工具 fastboot.exe 包含在 Android SDK Platform-Tools package 中。


### 配置

1. 将 fastboot.exe 配置到 PATH 中，以便刷机脚本能找到它


### 进入 fastboot 模式

1. 通过 usb 连接手机和电脑
1. 设置手机进入 fastboot mode ，根据如下几种方法：
    1. 手机开机状态执行 `adb reboot bootloader`
    2. 使用组合键：关机 》开机 并立即按下组合键，参考 [如何进入fastboot模式](https://source.android.com/setup/running#booting-into-fastboot-mode)
        * Nexus 5X的组合键：按住【音量下】，然后按住【电源键】


### 解锁 bootloader

* 2015年及以后的设备 (例如：Nexus 5X, Nexus 6P, Pixel, Pixel XL, Pixel 2 or Pixel 2 XL device):
  ~~~
  fastboot flashing unlock
  ~~~

* For Pixel 2: To flash the bootloader, Pixel 2's boot loader must be updated to at least Oreo MR1's version first. This may be done by applying an over-the-air (OTA) update, or sideloading a [full OTA](https://developers.google.com/android/ota) with the instructions on that page.

* For Pixel 2 XL only: the critical partitions may also need to be unlocked before flashing. The unlock can be performed with this command, and should NOT be done on other devices:
  ~~~
  fastboot flashing unlock_critical
  ~~~

* 其他老设备： `fastboot oem unlock`

结果成功，设备会跳出提示页面，说会删除所有数据。


### 刷机

1. 解压 bullhead-opm1.171019.011-factory-3be6fd1c.zip
2. 在命令行执行 `flash-all` 脚本，脚本会安装 bootloader, baseband firmware(s), and operating system.
3. 脚本执行完后，手机会重启



### 在将手机锁回去

1. 重启进入 fastboot 模式
2. 执行 `fastboot flashing lock` 或 `fastboot oem lock`



## 附录

### fastboot mode 组合键

|Device|Code name|Keys|
|Pixel XL|marlin|Press and hold Volume Down, then press and hold Power.|
|Pixel|sailfish|Press and hold Volume Down, then press and hold Power.|
|hikey|hikey|Link pins 1 - 2 and 5 - 6 of J15.|
|Nexus 6P|angler|Press and hold Volume Down, then press and hold Power.|
|Nexus 5X|bullhead|Press and hold Volume Down, then press and hold Power.|
|Nexus 6|shamu|Press and hold Volume Down, then press and hold Power.|
|Nexus Player|fugu|Press and hold Power.|
|Nexus 9|volantis|Press and hold Volume Down, then press and hold Power.|
|Nexus 5|hammerhead|Press and hold both Volume Up and Volume Down, then press and hold Power.|
|Nexus 7|flo|Press and hold Volume Down, then press and hold Power.|
|Nexus 7 3G|deb|Press and hold Volume Down, then press and hold Power.|
|Nexus 10|manta|Press and hold both Volume Up and Volume Down, then press and hold Power.|
|Nexus 4|mako|Press and hold Volume Down, then press and hold Power.|
|Nexus 7 (2012)|grouper|Press and hold Volume Down, then press and hold Power.|
|Nexus 7 3G (2012)|tilapia|Press and hold Volume Down, then press and hold Power.|
|Nexus Q|phantasm|Power the device then cover it with one hand after the LEDs light up and until they turn red.|
|Galaxy Nexus GSM|maguro|Press and hold both Volume Up and Volume Down, then press and hold Power.|
|Galaxy Nexus (Verizon)|toro|Press and hold both Volume Up and Volume Down, then press and hold Power.|
|Galaxy Nexus (Sprint)|toroplus|Press and hold both Volume Up and Volume Down, then press and hold Power.|
|Motorola Xoom|wingray|Press and hold Volume Down, then press and hold Power.|
|Nexus S|crespo|Press and hold Volume Up, then press and hold Power.|
|Nexus SG|crespo4g|Press and hold Volume Up, then press and hold Power.|

或者，不用组合键，执行 `adb reboot bootloader` 进入 fastboot 模式。

























