---
layout: post
title: ProjectElixir刷到一加8T，关联 oneplus, kebab
categories: [ ]
tags: []
---

* 参考
  * [ProjectElixir 一加8T 刷机指南](https://github.com/ProjectElixir-Devices/Wiki/blob/tiramisu/kebab.md)
  * []()
  * []()
  * []()


### 从 OxygenOS KB2005_11_C.33 刷到 ProjectElixir 3.6

1. 起点
    型号： KB2005
    版本号： OxygenOS KB2005_11_C.33
    Android: 12
    基带版本： Q_V1_p14,Q_V1_P14
    内核版本：  4.19.157-perf+
    硬件版本：  KB2005_11

1. 解锁
    注意：解锁后所有数据丢失，系统重置！！
    ~~~sh
    adb reboot bootloader
    fastboot devices
    fastboot oem device-info
    fastboot oem unlock
    ~~~
1. 
1. 
1. 
1. 


### Installation Guide For Project Elixir on Kebab

From version 3.4
Based on OOS13 firmware
Will only work for Oneplus 8T(9R builds are given seperately)

#### Firmware Instructions:

1. Method 1: If from OOS11 or OOS12

    1. Unlock bootloader
    1. 下载 OOS13 fw ： [下载链接](https://mega.nz/folder/W7JhwTAT#Yu6cxqvJcAC28cy0m_kkQA)
    1. It will flash fw after detecting the ddr type so don't worry about bricking the device
    1. Flash the fw using this [recovery](https://github.com/Wishmasterflo/device_oneplus_opkona/releases/download/R12.1_V13/OrangeFox-R12.1-Unofficial-OPKONA-V13.img)
    1. Follow from Method 2

1. Method 2: If from OOS13

    1. Unlock bootloader
    1. Download the rom and flash via this [recovery](https://github.com/Wishmasterflo/device_oneplus_opkona/releases/download/R12.1_V13/OrangeFox-R12.1-Unofficial-OPKONA-OOS13-V13.img)
    1. Follow the clean flash instructions given below


1. Clean Flash:

    1. Download the latest build
    1. Take a backup for safe side
    1. Boot to Recovery of your choice
    1. Flash or Sideload the rom
    1. Go back to recovery and select Format Data
    1. Reboot

1. DIRTY FLASH [A13 to A13]
    1. Boot to recovery
    1. Flash or Sideload the rom
    1. Reboot



## OOS / OxygenOS Firmware


* [OOS Mega 下载链接](https://mega.nz/folder/W7JhwTAT#Yu6cxqvJcAC28cy0m_kkQA)
  可下载 Oneplus 6 - Oneplus 9 的 OOS.














