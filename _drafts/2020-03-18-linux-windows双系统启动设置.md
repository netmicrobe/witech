---
layout: post
title: linux-windows双系统启动设置
categories: [cm, linux]
tags: []
---

* 参考： 
  * [迁移win10的efi引导分区到系统固态硬盘](https://blog.csdn.net/Sebastien23/article/details/99691881)
  * [Windows 更换硬盘后通过 BCDBoot 命令修复 UEFI 启动引导](https://weiku.co/article/309/)
  * [Windows 和 GPT 常见问题解答(uefi、GPT、ESP、MSR概念扫盲贴)](https://www.chinafix.com/thread-967034-1-1.html)
  * [microsoft.com - UEFI/GPT-based hard drive partitions](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions)
  * []()
  * []()
  * []()


## Windows

### windows重装、升级导致grub失效

1. 系统管理员身份运行 `cmd`
1. 执行 `bcdedit /set {bootmgr} path \EFI\ubuntu\grubx64.efi`
1. 如果不行，尝试： `bcdedit /deletevalue {bootmgr} path \EFI\ubuntu\grubx64.efi`

### 恢复使用 Windows boot manager

1.  `bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi`


### 迁移win10的efi引导分区到系统固态硬盘

1. Windows安装U盘启动系统，按SHIFT+F10进入命令行。
    ~~~
    diskpart
    list disk
    select disk your-disk-no # Note: Select the disk where you want to add the EFI System partition
    list partition

    select partition your-partition-no # Note: Select the Windows OS partition or your data partition
    shrink desired=100 # 从目前启动盘中挤出 100 M，这里单位是M，数值多少更具要迁移过来的那个EFI分区大小来确定
    create partition efi size=100
    format quick fs=fat32
    assign letter=select

    list partition
    list volume # 记录下Windows系统盘此时的Volume，不一定是C哦，例如，这个命令输出列表里可能是：F
    exit  # 推出 DiskPart..

    bcdboot F:\Windows /s S:
    ~~~

1. 拔掉U盘，重启系统







现在SSD都是4k扇区，老版本ghost11.0.2 又有对齐问题，得用最新版本ghost32 11.5.1 ，勉强凑合。

ghost 12 直接克隆，毫无问题。
至于UEFI启动修复很简单，就是修复一下BCD文件就OK了。比如新盘ESP挂载F:，系统挂载G:盘。然后到F:\EFI\Microsoft\Boot下面，修改设备
bcdedit /store BCD /set {bootmgr} device partition=F:
bcdedit /store BCD /set {memdiag} device partition=F:
bcdedit /store BCD /set {default} device partition=G:
bcdedit /store BCD /set {default} osdevice partition=G:
这些操作可以在UEFI/MBR系统上都能用，BCD对UEFI/MBR或者32/64位都没有太大区别。唯一差别就是一个是winload.exe一个是winload.efi，已经bootmgr多了个path到\EFI\Microsoft\Boot\bootmgfw.efi。所以MBR系统克隆到UEFI也可以用bcdedit修复一下，然后复制\Windows\Boot\EFI，Fonts，Resources重构一个ESP目录。


问	Windows 默认装入了什么分区？
答	Windows 只公开基本数据分区。其他 FAT 文件系统分区也可以被装入，但是不只以编程的方式公开。只有基本数据分区分配了驱动器号和装入点。
装入了 ESP FAT 文件系统，但它不是公开的。这使运行在 Windows 上的程序能更新 ESP 的内容。使用 "mountvol /s" 为 ESP 分配一个驱动器号，以实现对分区的访问。访问 ESP 需要管理员权限。
虽然 MSR 以及从 MSR 创建的任何分区都具备可识别的文件系统，但它们都不是公开的。
Windows 不能识别任何特定于 OEM 的分区或与其他操作系统相关的分区。具备可识别文件系统的无法识别的分区可以当作 ESP 处理。它们将被装入，但不是公开的。与 MBR 磁盘不同，特定于 OEM 的分区和其他操作系统分区之间没有实际的区别，都是“无法识别的”。


答	您可以使用下表中所列的工具访问不同类型的 GPT 磁盘分区。
工具	| Windows	| 固件
Diskpart.efi	|  磁盘分区工具		| 	ESP MSR 数据
Diskpart.exe 	| 磁盘分区工具	ESP MSR 数据		| 
Diskmgmt.msc 	| 逻辑磁盘管理器	ESP 数据		| 
Explorer.exe 	| 文件资源管理器	数据		| 
您也可以使用 Microsoft Platform SDK API 开发属于自己的工具，在 GPT 磁盘分区的原语级别对其进行访问。
问	在 Windows 中如何管理 GPT 磁盘？





* DiskGenies 的系统迁移工具
  DiskGenies -\> 工具 -\> 系统迁移



### BCDboot.exe

在 win8/10 系统中有一条 `BCDboot.exe` 命令，它是一种快速设置系统启动分区或修复系统启动环境的命令行工具。`CDboot.exe` 命令是通过从已安装的 Windows 系统文件夹中复制一小部分启动环境文件来设置/修复系统的。BCDboot 还会在系统分区上创建引导配置 BCD 文件，该文件存储了启动引导项，可让您选择引导已安装的 Windows。

当系统无法启动时，用U盘或光盘启动 Windows PE 环境、或者使用 win8/10 的高级修复模式启动到命令符环境（推荐），然后运行BCDboot命令来修复损坏的系统。

BCDboot 命令通常在 `%WINDIR%\System32` 文件夹内，它运行后从计算机上已有的 Windows 映像复制一套启动环境文件到启动分区（GPT）/目录(MBR)中。

这些启动环境文件包括：从已安装的系统 `%WINDIR%\boot\efi` 文件夹和 `%WINDIR%\System32\boot` 文件夹复制到系统启动分区中。在UEFI+GPT环境下，BCDboot 将文件复制到固件所标识的默认系统启动分区（ESP）。另外，`BCDboot` 还使 `%WINDIR%\System32\Config\BCD-Template` 文件为模板，在系统启动分区上创建新的 BCD（启动菜单）文件，并初始化 BCD 启动环境文件。可以在 BCD-Template 文件中定义特定的 BCD 设置(需要BCB文件编辑器)。

* 在基于 BIOS 的系统上，系统分区是使用主引导记录 (MBR) 磁盘格式的磁盘上的活动分区。BCDboot 会在系统分区上创建 Boot 目录，并将所有需要的引导环境文件都复制到此目录中。
* 在基于 UEFI(统一可扩展固件接口) 的系统上，EFI 系统分区是使用 GUID 分区表 (GPT) 磁盘格式的磁盘上的系统启动分区（ESP）。BCDboot 会创建 `\Efi\Microsoft\Boot` 目录，并将所有需要的引导环境文件都复制到此目录中。


* BCDboot 命令行格式
  ~~~
  BCDBOOT source [/llocale] [/svolume-letter] [/v] [/m [{OS Loader GUID}]] 
  ~~~
  
  各参数的具体含义：
  - source ，例如，c:\windows 系统安装目录
  - /s S: 指定esp分区所在磁盘，例如，这里是S盘
  - /f uefi 指定启动方式为uefi，注意之间的空格一定要输入。
  - /l zh-cn 指定uefi启动界面语言为简体中文

* 示例

1. BIOS+MBR 常用
    `bcdboot C:\Windows /l zh-cn`
    解释：从系统盘`C:\Windows`目录中复制启动文件，并创建BCD（中文）启动菜单，从而修复系统启动环境。
2. UEFI+GPT 常用
　　`bcdboot C:\Windows /s S: /f uefi /l zh-cn`
　　解释：用DG等工具先将ESP分区装载为S盘，从系统盘C:\Windows目录中复制UEFI格式的启动文件到ESP分区中，修复系统。






## Ubuntu

`efibootmgr` 工具可以管理efi启动项







## 设置硬盘分区表格式（GPT 还是 MBR）

### 使用 diskpart

1. 以管理员权限运行 cmd， 执行 `diskpart` 进入工具命令行界面
1. 改成GPT分区表
    ~~~
    list volume
    list disk
    select disk your-disk-no
    convert gpt
    ~~~

### 使用 DiskGenies 分区工具

1. 启动winpe，使用DiskGenies分区工具
1. 在 DiskGenies 中选中磁盘
1. 菜单“硬盘” 》转换分区表类型为：MBR格式 / GPT
1. 重启，开始windows安装。






