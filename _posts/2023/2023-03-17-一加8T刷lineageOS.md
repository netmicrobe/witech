---
layout: post
title: 一加8T刷lineageOS，关联 
categories: [ ]
tags: []
---

* 参考
  * [lineageos.org - Install LineageOS on kebab](https://wiki.lineageos.org/devices/kebab/install)
  * [lineageos.org - Build for kebab](https://wiki.lineageos.org/devices/kebab/build)
  * []()
  * []()


### 从 OxygenOS KB2005_11_C.33 刷到 lineageOS 20 / Android 13

1. 起点
    型号： KB2005
    版本号： OxygenOS KB2005_11_C.33
    Android: 12
    基带版本： Q_V1_p14,Q_V1_P14
    内核版本：  4.19.157-perf+
    硬件版本：  KB2005_11
1. 确认DDR类型（是DDR4或DDR5）
    1. 方法一： `adb shell getprop ro.boot.ddr_type` 或 `adb shell cat /proc/devinfo/ddr_type`
        * On OOS 11 you can find the phone's DDR type using getprop ro.boot.ddr_type. A result of 0 means DDR4 and 1 means DDR5.
        * On OOS 12 root之后，使用 `adb shell cat /proc/devinfo/ddr_type`
            ~~~sh
            cat /proc/devinfo/ddr_type
            Device version:         DDR5
            ~~~
    1. 方法二： 
        参考： <https://forum.xda-developers.com/t/ddr-type.4453647/post-86982049>
        1. 拨号`*#800#` 打开 feedback app，选择 Other -\> Other general 
        1. 按下开始搜集，提示是否重启时，选择继续（不重启）
        1. 将sdcard上的日至拷贝出来
        `adb pull /sdcard/Android/data/com.oplus.logkit/files/Log/<这个文件夹根据手机中实际情况>@other/recovery_log .`
        1. 搜索ddr5 或 ddr4
            `find . -type f | xargs grep --color -i 'ddr5\|ddr4'`
        1. 出现如下字样估计是 ddr4
            * `ddr_type is: Device version: DDR4`
            * `ddr5 is false`
            * `the ddr type of dev is ddr4`
            * `is_ddr5 is 0 , partition name xbl_config_lp5 , target path /dev/null`
            * `is_ddr5 is 0 , partition name xbl_lp5 , target path /dev/null`
            * `is_ddr5 is 0 , partition name xbl_config , target path /dev/block/bootdevice/by-name/xbl_config_b`
            * `is_ddr5 is 0 , partition name xbl , target path /dev/block/bootdevice/by-name/xbl_b`
            * `Current system is non ddr5 and current partition is xbl_lp5, skip hash verification`
            * `Current system is non ddr5 and current partition is xbl_config_lp5, skip hash verification`
            * `update_attempter_android.cc(355)] ddr_type is: Device version: DDR4`
    
1. ==================================================================
1. 确保使用 Android 13 Firmware
    1. 升级 firmware，参考： [Update firmware on kebab](https://wiki.lineageos.org/devices/kebab/fw_update)
1. 获取最新OTA升级包
    * 从 <https://t.me/OnePlusOTA> tg群中获取
    * Google Play 下载 [Oxygen Updater](https://play.google.com/store/apps/details?id=com.arjanvlek.oxygenupdater&pli=1)
        1. 安装到 Oneplus 8T 上，下载最新OTA升级包。
        1. 下载好的升级包，就在 /sdcard/ 下面。
1. 使用 [payload-dumper-go](https://github.com/ssut/payload-dumper-go) 提取OTA升级包中的文件。
    参考： [How to extract img(boot.img, etc...) from payload.bin using payload-dumper-go](https://forum.xda-developers.com/t/guide-how-to-extract-img-boot-img-etc-from-payload-bin-using-payload-dumper-go.4468781/)
    1. 从下载的OTA升级包（zip包）中解压出： payload.bin
    1. 将 payload.bin 拷贝到 payload-dumper-go.exe 同目录
    1. 执行： `payload-dumper-go.exe payload.bin`，会在目录上新建个目录，存放提取出来的img文件
1. 进入 LineageOS recovery， “Advanced” -> “Enable ADB”
1. Recovery -\> “Advanced” -\> “Enter fastboot”
1. 电脑端使用命令刷img
    ~~~sh
    fastboot flash --slot=all abl abl.img
    fastboot flash --slot=all aop aop.img
    fastboot flash --slot=all bluetooth bluetooth.img
    fastboot flash --slot=all cmnlib64 cmnlib64.img
    fastboot flash --slot=all cmnlib cmnlib.img
    fastboot flash --slot=all devcfg devcfg.img
    fastboot flash --slot=all dsp dsp.img
    fastboot flash --slot=all featenabler featenabler.img
    fastboot flash --slot=all hyp hyp.img
    fastboot flash --slot=all imagefv imagefv.img
    fastboot flash --slot=all keymaster keymaster.img
    fastboot flash --slot=all logo logo.img
    fastboot flash --slot=all mdm_oem_stanvbk mdm_oem_stanvbk.img
    fastboot flash --slot=all modem modem.img
    fastboot flash --slot=all multiimgoem multiimgoem.img
    fastboot flash --slot=all qupfw qupfw.img
    fastboot flash --slot=all spunvm spunvm.img
    fastboot flash --slot=all storsec storsec.img
    fastboot flash --slot=all tz tz.img
    fastboot flash --slot=all uefisecapp uefisecapp.img
    ~~~
1. 根据DDR类型，输入正确的 XBL 文件
    For DDR type 0 (DDR4):
    ~~~sh
    fastboot flash --slot=all xbl_config xbl_config.img
    fastboot flash --slot=all xbl xbl.img
    ~~~
    For DDR type 1 (DDR5):
    ~~~sh
    fastboot flash --slot=all xbl_config xbl_config_lp5.img
    fastboot flash --slot=all xbl xbl_lp5.img
    ~~~


1. ==================================================================
1. 解锁
    注意：解锁后所有数据丢失，系统重置！！
    ~~~sh
    # 重启进入bootloader, 执行如下命令，
    # 或者 关闭手机，同时按下 音量上 + 音量下 + 电源键
    adb reboot bootloader
    
    fastboot devices
    fastboot oem device-info
    fastboot oem unlock
    ~~~

1. ==================================================================
1. 刷recovery之前，刷人 dtbo.img 、 vbmeta.img
  ~~~sh
  fastboot flash dtbo <dtbo>.img
  fastboot flash vbmeta <vbmeta>.img
  ~~~
1. 刷入 recovery
  ~~~sh
  fastboot flash recovery <recovery_filename>.img
  ~~~
1. 进入 recovery
  执行 `fastboot reboot recovery`，或者关机后，同时按下 `Volume Down` + `Power`
1. 确保firmware分区一致性，防止变砖
    1. 下载 [copy-partitions-20220613-signed.zip](https://mirrorbits.lineageos.org/tools/copy-partitions-20220613-signed.zip)
        MD5 sum : 79f2f860830f023b7030c29bfbea7737
        SHA-256 sum : 92f03b54dc029e9ca2d68858c14b649974838d73fdb006f9a07a503f2eddd2cd.
    1. 刷入 `copy-partitions-20220613-signed.zip`
        1. On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
        1. On the host machine, sideload the package using: `adb sideload copy-partitions-20220613-signed.zip`
    1. 重启到recovery： tapping “Advanced”, then “Reboot to recovery”

1. ==================================================================
1. 刷入 LineageOS 20
1. Recovery 中恢复下出厂设置： `Factory Reset` -\> `Format data / factory reset`
1. 返回 main menu
1. Sideload the LineageOS .zip package
    1. On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
    1. On the host machine, sideload the package using: `adb sideload filename.zip`
    正常会显示 `Total xfer: 1.00x`，
    但是，停在 47% 显示`adb: failed to read command: Success`.
    或者，显示`adb: failed to read command: No error` or `adb: failed to read command: Undefined error: 0`，
    都是正常的。

1. 刷 Google Apps
1. 重启进入 Recovery
1. Sideload the MindTheGapps.zip package
    1. On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
    1. On the host machine, sideload the package using: `adb sideload MindTheGapps-13.0.0-arm64-20221025_100653.zip`
    显示 `Signature verification failed` 是正常的，因为GApps没有使用lineageos官方签名，选择 YES 继续就行。
        有时候会输入失败，Recovery 中恢复下出厂设后，再试试。

1. MindTheGapps 刷入成功，屏幕显示 `Install completed with status 0`
    ~~~
    MindTheGapps installer
    ****************************
    Extracting files
    Mounting partitions
    /mnt/system mounted
    /product mounted
    /system_ext mounted
    Generating addon.d file
    Preparing files for copying
    Copying files
    Cleaning up files
    Unmounting partitions
    Done!

    Install completed with status 0
    ~~~
1. 重启进入 LineageOS 系统，第一次启动大约 15分钟左右，特别长时间进入不了系统，估计就什么地方有问题了。

1. ==================================================================
1. 安装其他App 
1. lineageOS 和 MindTheGapps 都比较简练，还有些必须的app要安装下
    MindTheGapps 只包含了必要Google Apps 框架和 Play Store
1. 配置Google账号
1. 进入 Play Store 安装中文输入法： GBoard
1. 


### 实例

### lineage-20.0-20230302-nightly-kebab-signed.zip

* lineage-20.0-20230302-nightly-kebab-signed.zip
    版本号： lineage_kebab-userdebug 13 TQ1A.230205.002 3a48ea0afd
    LineageOS 版本： 20-20230302-NIGHTLY-kebab
    Android: 13
* MindTheGapps-13.0.0-arm64-20221025_100653.zip
    Play Store: 版本 30.4.17-21 [0] [PR] 445549118
    Google: 版本 13.21.16.26.arm64

~~~
$ md5sum *
e68c6e125b69509257c942d60179f99c  boot.img
79f2f860830f023b7030c29bfbea7737  copy-partitions-20220613-signed.zip
1165f6c5b2147e398150745422259ec7  dtbo.img
ec9b154cbf41b1aebd9f4c01bc2a88d7  lineage-20.0-20230302-nightly-kebab-signed.zip
d4b2b6dd8e5426cf7d4d9bd6ffe18e6b  recovery.img
3abd2db7de98b1d1439afc50144fd70e  super_empty.img
74d986bd809da327af26068604930c4c  vbmeta.img
~~~~

* 问题
    * 屏幕自动调光，时灵时不灵

* 优点
    * 系统性能高，响应速度快
    * Phone App 可录音




