---
layout: post
title: Android flash / 刷机基础知识，关于 recovery, bootloader
categories: [ cm, android ]
tags: [ adb, fastboot, bootloader, root, unlock, flash, recovery ]
---

* 参考
  * <https://www.makeuseof.com/tag/whats-custom-recovery-exploring-cwm-twrp-friends/>
  * <https://tektab.com/2015/10/31/android-bootloaderfastboot-mode-and-recovery-mode-explained/>
  * [TWRP]

[XDA-Developers forum]: http://forum.xda-developers.com/
[TWRP]: http://twrp.me/

## 总览

An Android device consists of several pieces of software, which include the bootloader, radio, recovery, and system. 

* bootloader 
  * the first piece of software that is run when your device turns on — it decides whether to load the recovery, or load Android (“system”) and the radio. 
* radio 
  * simply the controller for your antennas, which give you a cellular connection to your carrier’s towers
* recovery
  * simply put, is a runtime environment (think “mini operating system”) separate from Android that can perform various system-related tasks. The stock recovery on most Android devices can apply OTA (over-the-air) updates, delete user and cache content (for factory reset purposes), and allow external tools from a microSD card to run functions on the device.



* Android booting process, recovery mode, boot-loader/fastboot mode
  * ![](android-booting-process.png)







## Third-party Recovery / Custom Recovery

The top two most popular custom recoveries are **ClockworkMod (CWM)** and **[Team Win Recovery Project (TWRP)][TWRP]**. 

![](cwm_backup.jpg){: style="width=50%"}

![](twrp_recovery.jpg){: style="width=50%"}

TWRP 比 CWM 界面易操作，功能更多些。


### Other Custom Recoveries

If you’re curious about recoveries other than CWM and TWRP, you should definitely check out the [XDA-Developers forum] for more recoveries that support your device. 

Search by going to your device’s subforum and looking for threads with a "Recovery" tag on them.





## 刷机版本


### Stock Android

* <https://www.maketecheasier.com/what-is-stock-android/>

Stock Android, also called “vanilla” Android, is the most basic version of the Android operating system available. 

Stock Android is also typically not reskinned or redesigned by the phone’s manufacturer (OEM).



### ROM

* 参考：
  * <https://www.makeuseof.com/tag/what-are-the-best-custom-android-roms/>

* XDA Developers forums <http://forum.xda-developers.com/>
* CyanogenMod <http://www.cyanogenmod.org/>
* LineageOS
  * <https://lineageos.org>
  * 第三方 ROM CyanogenMod 团队解散，变成了目前的 Lineage OS 团队。
* AOKP <http://aokp.co/>
* Paranoid Android  <https://plus.google.com/107979589566958860409/posts>
* PAC ROM  <http://pac-rom.com/>



## 刷机脚本

### Nexus 5x - bullhead

* flash-all.bat

  ~~~
  @ECHO OFF

  PATH=%PATH%;"%SYSTEMROOT%\System32"
  fastboot flash bootloader bootloader-bullhead-bhz31b.img
  fastboot reboot-bootloader
  ping -n 5 127.0.0.1 >nul
  fastboot flash radio radio-bullhead-m8994f-2.6.41.5.01.img
  fastboot reboot-bootloader
  ping -n 5 127.0.0.1 >nul
  fastboot -w update image-bullhead-opm2.171019.029.zip

  echo Press any key to exit...
  pause >nul
  exit
  ~~~












