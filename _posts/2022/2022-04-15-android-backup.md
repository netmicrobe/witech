---
layout: post
title: android backup
categories: [cm, android]
tags: []
---

* 参考
  * [How to extract or unpack an .ab file (Android Backup file)](https://microeducate.tech/how-to-extract-or-unpack-an-ab-file-android-backup-file-closed/)
  * [How to extract or unpack an .ab file (Android Backup file) ](https://stackoverflow.com/questions/18533567/how-to-extract-or-unpack-an-ab-file-android-backup-file)
  * <https://riptutorial.com/android/example/11498/backup>
  * [Gentoo wiki - Android/adb](https://wiki.gentoo.org/wiki/Android/adb)
  * [Android之allowBackup属性](https://blog.csdn.net/mysimplelove/article/details/84073013)
  * [What is "android:allowBackup"?](https://stackoverflow.com/questions/12648373/what-is-androidallowbackup)
  * [Full Phone Backup without Unlock or Root](https://forum.xda-developers.com/t/guide-full-phone-backup-without-unlock-or-root.1420351/)
  * [How to backup and restore your Android device with ADB on Ubuntu](https://net2.com/how-to-backup-and-restore-your-android-device-with-adb-on-ubuntu/)
  * [Android Application 之 allowBackup 属性浅析](https://blog.51cto.com/u_15239532/5144370)
  * []()
  * []()
  * []()
  * []()



androidManifest.xml内allowBackup为true

则可以使用adb backup 备份， adb restore 恢复。

~~~sh
# 备份
adb backup -f egame.ab cn.egame.terminal.cloud5g

# 解压ab文件
( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 egame.ab  ) |  tar xfvz -
~~~


## adb backup 命令说明

~~~
adb backup [-f <file>] [-apk|-noapk] [-obb|-noobb] [-shared|-noshared] [-all] 
           [-system|nosystem] [<packages...>]
-f <filename> specify filename default: creates backup.ab in the current directory

-apk|noapk enable/disable backup of .apks themself default: -noapk

-obb|noobb enable/disable backup of additional files default: -noobb

-shared|noshared backup device's shared storage / SD card contents default: -noshared

-all backup all installed apllications

-system|nosystem include system applications default: -system

<packages> a list of packages to be backed up (e.g. com.example.android.myapp) (not needed if -all is specified)
~~~

For a full device backup, including everything, use

~~~
adb backup -apk -obb -shared -all -system -f fullbackup.ab
~~~

Note: Doing a full backup can take a long time.

In order to restore a backup, use

~~~
adb restore backup.ab
~~~







