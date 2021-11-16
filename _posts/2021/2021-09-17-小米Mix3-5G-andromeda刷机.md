---
layout: post
title: 小米Mix3-5G-andromeda刷机
categories: [cm, android]
tags: [ rom, adb, fastboot, bootloader, root, unlock, twrp ]
---

* 参考： 
  * [Unofficial twrp 3.3.1 Root Xiaomi MI Mix 3 5G](https://unofficialtwrp.com/twrp-331-root-xiaomi-mi-mix-3-5g/)
  * [How to Install Official TWRP Recovery on Xiaomi Mi Mix 3 5G and Root it](https://www.getdroidtips.com/twrp-recovery-xiaomi-mi-mix-3-5g/)
  * []()
  * []()


## 下载

* ROM
  * [Mi MIX 3 5G (andromeda) MIUI Downloads](https://xiaomifirmwareupdater.com/archive/miui/andromeda/)
  * [Mi MIX 3 5G (andromeda) Europe (EEA) Fastboot & Recovery ROM](https://xiaomirom.com/en/rom/mi-mix-3-5g-andromeda-europe-fastboot-recovery-rom/)
  * []()
  * []()

* TWRP
  * [Official TWRP](https://dl.twrp.me/andromeda/)
  * []()

* 小米刷机工具 MiFlash
  * [Xiaomi Flash Tool](https://xiaomiflashtool.com/)
  * [Xiaomi Flash Tool - All Versions](https://androidmtk.com/download-xiaomi-mi-flash-tool)
  * [Download Xiaomi Flash Tool all versions](https://www.xiaomiflash.com/download/)
  * [Mi Flash Unlock: The official bootloader unlocking tool](https://miui.blog/any-devices/mi-flash-unlock/)
  * <http://www.miui.com/unlock/download.html>
  * []()
  * []()

## 刷 TWRP

~~~
adb devices
adb reboot bootloader
fastboot devices
fastboot flash recovery twrp-3.5.2_9-0-andromeda.img
fastboot boot twrp-3.5.2_9-0-andromeda.img
~~~

## 用TWRP 安装 magisk

1. 挂载手机存储到电脑，将 `Magisk-v21.4.zip` 拷贝到手机根目录
1. Install ， 选择 `Magisk-v21.4.zip`
1. 刷完，清空 cache 后重启。
1. 


## MiFlash 线刷


* **注意** 
  * 刷机工具最下方，**不要选择** **不要选择** **不要选择** “clean all and lock”，选择“Clean All”
  * 不要刷miui global的版本，刷进去，启动提示rom无法在此设备运行，woc，刷 miui eea 欧洲版

1. 下载 MiFlash 工具
    [Xiaomi Flash Tool](https://xiaomiflashtool.com/)
    
    这次使用的版本： `MiFlash20210226`

2. 下载 线刷fastboot版本
    <https://xiaomifirmwareupdater.com/archive/miui/andromeda/>
    (请检查文件后缀名是否为".tgz"，如果为".gz" 请重新命名后缀为".tgz"）
    
    下载 EEA 欧洲版，刷成功过：andromeda_eea_global_images_V12.0.7.0.PEMEUXM_20210526.0000.00_9.0_eea_3bae1ef62a.tgz
    虽然最后MiFlash 提示，`error: Not catch checkpoint (\$fastboot -s .* lock), flash is not done`

3. 进入Fastboot模式
    关机状态下，同时按住 音量下+电源键 进入Fastboot模式将手机USB连接电脑。

4. 线刷包下载完成后解压，打开线刷包文件夹

5. 打开刷机工具，贴入线刷包的解压路径
6. 刷机工具，点击“加载设备”，刷机程序会自动识别手机；点击“刷机”后开始刷机。
7. 然后等待，工具显示刷机成功，手机会自动开机。





















