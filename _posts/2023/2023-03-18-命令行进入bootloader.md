---
layout: post
title: 命令行进入 bootloader，关联 Android, TWRP, fastboot, adb, recovery
categories: [ ]
tags: []
---

* 参考
  * [How To Boot Into Recovery (TWRP/Stock) From Fastboot Mode](https://droidwin.com/boot-into-recovery-from-fastboot-mode/)
  * []()




系统重启到 bootloader
~~~sh
adb reboot bootloader
~~~

从 bootloader 重启到 recovery
~~~sh
fastboot reboot recovery
~~~

有些设备没有recovery分区，而是 A/B 分区（像小米A3），就要先临时从boot分区进入recovery，然后在安装zip或img文件。
~~~sh
fastboot boot twrp.img
~~~

有recovery分区，而非 A/B 分区，直接刷入 recovery
~~~sh
fastboot flash recovery twrp.img
~~~

A/B 分区的设备，将 recovery 刷入 boot 分区。
~~~sh
fastboot flash boot twrp.img
fastboot reboot recovery
# 然后，将twrp zip文件拷贝到设备，然后twrp中install 这个twrp zip
~~~


~~~sh

~~~


~~~sh

~~~


~~~sh

~~~






