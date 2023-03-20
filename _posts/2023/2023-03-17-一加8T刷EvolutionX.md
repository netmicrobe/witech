---
layout: post
title: 一加8T刷EvolutionX，关联 kebab, android, rom, oneplus
categories: [ ]
tags: []
---

* 参考
  * []()
  * [ROM 13.0_r30 OFFICIAL  Evolution X 7.6.2  03/05/2023](https://forum.xda-developers.com/t/rom-13-0_r30-official-evolution-x-7-6-2-03-05-2023.4480927/#post-87295275)
  * []()
  * []()
  * []()
  * []()
  * []()





## EvolutionX

* 没有自带 Google Apps，刷完系统rom，要刷GApps


## First Time Install (8T & 9R)

1. Be on the latest OOS13 (F.62 for 8T & F.21 for 9R)
2. Download `copy_partitions`, `vbmeta`, `recovery`, and rom for your device from here
3. Reboot to bootloader
4. flash
    ~~~sh
    fastboot flash vbmeta vbmeta.img
    fastboot flash recovery recovery.img
    fastboot reboot recovery
    ~~~
5. While in recovery, navigate to Apply update -> Apply from ADB
6. `adb sideload copy_partitions.zip` (press "yes" when signature verification fails) and then reboot to recovery
7. Repeat step 5 and adb sideload rom.zip (replace "rom" with actual filename)
8. Format data, reboot to system

Please note that if you are not on F.15 (kebab) or F.19 or above (lemonades) firmware, your proximity sensor will cease to function until you update to said firmware!!

## Update (8, 8 Pro, 8T & 9R)

1. Reboot to recovery
2. While in recovery, navigate to Apply update -> Apply from ADB
3. adb sideload rom.zip (replace "rom" with actual filename)
4. Reboot to system


## Firmware update:

FLASHING THE WRONG DDR TYPE WILL `SEMI BRICK` YOUR DEVICE. THE ONLY WAY TO RECOVER FROM THIS IS BY PURCHASING [AN EDL DEEP FLASH CABLE](https://www.amazon.com/Deep-Flash-Qualcomm-Cable-Octopus/dp/B06XB76BH3?tag=xdaforum01-20) AND USING IT IN-CONJUNCTION WITH MSMTOOL!!

### Spoiler: Method 1

1. Check your DDR type using the following command:

    `adb shell getprop ro.boot.ddr_type`

    0 = ddr4
    1 = ddr5

    if getprop returns an empty value, use the following commands instead (requires root):
    ~~~sh
    adb shell
    su
    cat /proc/devinfo/ddr_type
    ~~~

    DDR4 = DDR4
    DDR5 = DDR5

2. Download and flash the firmware zip that matches your device and DDR type:

    [8T (kebab)](https://www.mediafire.com/folder/2gpefcni2siwo/OnePlus_8T_(KB200x))


3. Reboot to recovery and then sideload the ROM.
































