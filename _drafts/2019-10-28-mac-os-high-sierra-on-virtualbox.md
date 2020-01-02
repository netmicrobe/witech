---
layout: post
title: 在Virtualbox 5.x 中安装 High Sierra
categories: [cm, vm]
tags: [mac, high-sierra]
---

* 参考： 
  * [
HIGHSIERRAAMD 10.13.2 VM FOR VIRTUAL BOX - UPDATED 5/29/2018 (10.13.3 COMBOUPDATE INSTALL)](https://forum.amd-osx.com/viewtopic.php?t=4029)
  * []()



配置的vmdk文件下载地址：

* 分辨率 1920x1080 <http://bit.ly/10_13_2VM>
* 分辨率 1280x1024 <http://bit.ly/2IZjtfq>

如下文本假设加载了 1920x1080 的 vmdk 文件： macOS.10.13.2-1920x1080.vmdk


1. 新建虚拟电脑 HighSierra 
    * 类型： Mac OS X
    * 版本： macOS 10.13 High Sierra(64-bit)
    * 内存： 8192
    * 虚拟硬盘： 使用已有的，选中下载的vmdk文件
1. 选中刚创建的虚拟机 HighSierra 设置属性：
    * 系统：
      * Boot Order：勾掉软盘
      * Processor： 选2个
    * 显示
      * 显存大小：128M
1. 已管理员权限打开命令行，执行：
    ~~~
    VBoxManage modifyvm "HighSierra" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
    VBoxManage setextradata "HighSierra" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "MacPro6,1"
    VBoxManage setextradata "HighSierra" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
    VBoxManage setextradata "HighSierra" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
    VBoxManage setextradata "HighSierra" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
    VBoxManage setextradata "HighSierra" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
    VBoxManage setextradata "HighSierra" VBoxInternal2/EfiGopMode 5
    VBoxManage setextradata "HighSierra" VBoxInternal2/EfiGraphicsResolution 1920x1080
    VBoxManage setextradata "HighSierra" "VBoxInternal/Devices/efi/0/LUN#0/Config/PermanentSave" 1
    ~~~
1. 启动VM，快速按下 `F2` 进入 BIOS
1. 选择 `Boot Maintenance Manager` -\> `Boot Options` -\> `Add Boot Options`
    选择第一个 EFI -\> `<EFI>` -\> `<CLOVER>` -\> `<CLOVERX64.efi>`
    回车 Input the description，输入 Clover，然后 Commit Changes and Exit
1. `Boot Maintenance Manager` -\> `Boot Options` -\> `Change Boot Order`
    按 `+` 将 Clover 启动项调整到 第一个， F10 保存。
1. `Boot Maintenance Manager` -\> `Reset System` 重启后，进入一个有金属质感的启动界面“Boot macOS from HFS+ volume”，选择从硬盘启动。

别升级，升级还要再进BIOS去调整。详见参考文档。

关机总是停在 CPU halted




