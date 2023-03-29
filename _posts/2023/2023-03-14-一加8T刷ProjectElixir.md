---
layout: post
title: ProjectElixir刷到一加8T，关联 oneplus, kebab
categories: [ ]
tags: []
---

* 参考
    * [ProjectElixir 一加8T 刷机指南](https://github.com/ProjectElixir-Devices/Wiki/blob/tiramisu/kebab.md)
    * [Official Site](https://projectelixiros.com)
      * <https://github.com/Project-Elixir/docs>
      * [Project Elixir • Devices](https://github.com/ProjectElixir-Devices)
      * <https://github.com/ProjectElixir-Devices/Wiki>
    * [Official Site - Oneplus8T - Download](https://projectelixiros.com/device/kebab)
      * <https://www.pling.com/p/1962779/>
  * []()
  * []()


### 从 evolution X 7.6.8c1 刷到 ProjectElixir 3.6


1. 进入 evolution X 的 recovery
1. Recovery 中恢复下出厂设置： `Factory Reset` -\> `Format data / factory reset`
1. sideload the ProjectElixir 3.6 .zip package


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



## 实例

### evolution_kebab-ota-tq2a.230305.008.c1-03272133-unsigned.zip

* evolution_kebab-ota-tq2a.230305.008.c1-03272133-unsigned.zip
    版本号： evolution_kebab-userdebug 13 TQ2A.230305.008.C1 1679967184 release-keys
    EvolutionX 版本： 7.6.8c1
    型号变成： Pixel 7 Pro
    Android: 13
    * 自带GApps
        Play Store: 版本 33.1.17-21 [0] [PR] 487561732
        Google: 版本 13.37.11.29.arm64



* 问题
    * Phone App `不可`录音

* 优点
    * 自带GApps












