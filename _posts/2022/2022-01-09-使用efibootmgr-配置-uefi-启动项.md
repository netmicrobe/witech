---
layout: post
title: 使用 efibootmgr 配置 uefi 启动项，关联 多系统, linux, grub, os-prober, UEFI
categories: [cm]
tags: []
---

* 参考： 
    * [UEFI 与Linux基础：一_cgm88s的专栏-程序员宝宝_linux uefi](https://www.cxybb.com/article/cgm88s/91830509)
    * [Gentoo wiki - Efibootmgr](https://wiki.gentoo.org/wiki/Efibootmgr)
    * [Efibootmgr + nvme: How to create entry with custom label](https://ask.fedoraproject.org/t/efibootmgr-nvme-how-to-create-entry-with-custom-label/19757/2)
    * []()
    * []()
    * []()
    * []()




* EFI 启动项，没法重命名，只能删除后，新建
* MSI 主板 BIOS 能读取的启动项有限，x299 carbon 只有 5个！！
    设置位置： BIOS 》Settings 》Boot 》UEFI Hard Disk Drive BBS Priorites


~~~bash
# 查看当前启动项
efibootmgr

# 查看当前启动项，更详细的信息（包含efi启动文件位置）
efibootmgr -v


# 查看 /boot 下面的启动文件
tree /boot/ -L 3
# 或
find . -type f -name "*.efi"

# 创建启动项 -----------
# 创建从 /dev/sda 第二个分区 启动，启动项lable 为 Gentoo
efibootmgr -c -d /dev/sda -p 2 -L "Gentoo" -l '\efi\boot\bootx64.efi'

# nvme 上创建启动项的例子
efibootmgr -c -d /dev/nvme0n1p5 -p 1 -L "manjaro" -l '\efi\manjaro\grubx64.efi'
~~~


* 删除 boot 项

~~~sh
# 找到 boot entry 编号
efibootmgr

# 删除对应编号的boot entry
# 比如，sudo efibootmgr -b E -B to remove the Boot000E entry.
efibootmgr -b 编号 -B
~~~



## grub

* 参考： 
    * [wiki.archlinux.org - Grub](https://wiki.archlinux.org/title/GRUB)
    * [wiki.archlinux.org - Using_arch-chroot](https://wiki.archlinux.org/title/Chroot#Using_arch-chroot)
    * []()
    * []()


### 注册 当前的grub 到 EFI启动项目中

使用 `grub-install` ， 等同于使用 `efibootmgr --create`

`grub-install` creates the `/boot/grub` directory 

### 创建 `grub.cfg`

使用 `grub-mkconfig` 创建 `grub.cfg`

~~~sh
grub-mkconfig -o /boo/grub/grub.cfg
~~~

`/boot/grub/grub.cfg` 是 grub 的主配置文件。生成配置文件的时候，如果不指定详细的配置参数，那么会自动根据当前所在系统或`chroot`到的目标系统，来自动生成配置，为每个安装的linux kernel 添加 `menuentry` 或 `submenu` 。

如果新增或删除了一个kernel，可以再次执行下 `grub-mkconfig` 来刷新 grub 启动菜单。

也可以手动编辑`/etc/grub.d/40_custom` ，来添加 menuentry后，执行下 `grub-mkconfig` 来刷新 grub 启动菜单。

也可以手动添加`/boot/grub/custom.cfg` ，这个不用再执行 `grub-mkconfig` 刷新，因为 `/etc/grub.d/41_custom` 脚本之前已经包含这个逻辑。


如果 `chroot` 到目标系统，执行 `grub-mkconfig` 生成 grub.cfg 时候报错：`grub-probe: error: failed to get canonical path of /dev/sdaX` ， 试着使用 `arch-chroot`


`/etc/default/grub` 和 `/etc/grub.d/`的脚本文件，会影响 grub 配置文件的生成。**TODO** 这些脚本的具体功能，还不太清楚？？？


* 查找其他已安装的OS

`grub-mkconfig` 利用 `os-prober` 查找其他已安装的OS。

如果报错： `Warning: os-prober will not be executed to detect other bootable partitions` ，那么通过编辑 `/etc/default/grub` 来允许使用 `os-prober`

~~~
GRUB_DISABLE_OS_PROBER=false
~~~

据说 `os-prober` 有安全风险，有些发行版可能默认禁用。


### 手动创建 grub.cfg

* refer
    * [Manually_generate_grub.cfg](https://wiki.archlinux.org/title/Talk:GRUB#Manually_generate_grub.cfg)


* 基本的Grub配置文件包含的配置项：

    * `(hdX,Y)` is the partition Y on disk X, partition numbers starting at 1, disk numbers starting at 0
    * `set default=N` is the default boot entry that is chosen after timeout for user action
    * `set timeout=M` is the time M to wait in seconds for a user selection before default is booted
    * `menuentry "title" {entry options}` is a boot entry titled title
    * `set root=(hdX,Y)` sets the boot partition, where the kernel and GRUB modules are stored (boot need not be a separate partition, and may simply be a directory under the "root" partition (`/`)

### Boot menuentry 例子

"Shutdown" menu entry
~~~
menuentry "System shutdown" {
	echo "System shutting down..."
	halt
}
~~~

"Restart" menu entry
~~~
menuentry "System restart" {
	echo "System rebooting..."
	reboot
}
~~~

"UEFI Firmware Settings" menu entry
~~~
if [ ${grub_platform} == "efi" ]; then
	menuentry 'UEFI Firmware Settings' --id 'uefi-firmware' {
		fwsetup
	}
fi
~~~

UEFI Shell

You can launch UEFI Shell by placing it in the root of the EFI system partition and adding this menu entry:

~~~
menuentry "UEFI Shell" {
	insmod fat
	insmod chain
	search --no-floppy --set=root --file /shellx64.efi
	chainloader /shellx64.efi
}
~~~

gdisk

Download the [gdisk EFI application](https://wiki.archlinux.org/title/Gdisk#gdisk_EFI_application) and copy `gdisk_x64.efi` to `esp/EFI/tools/`.

~~~
menuentry "gdisk" {
	insmod fat
	insmod chain
	search --no-floppy --set=root --file /EFI/tools/gdisk_x64.efi
	chainloader /EFI/tools/gdisk_x64.efi
}
~~~

Chainloading a unified kernel image

If you have a unified kernel image generated from following Secure Boot or other means, you can add it to the boot menu. For example:

~~~
menuentry "Arch Linux" {
	insmod fat
	insmod chain
	search --no-floppy --set=root --fs-uuid FILESYSTEM_UUID
	chainloader /EFI/Linux/Arch-linux.efi
}
~~~

双系统

Assuming that the other distribution is on partition sda2:

~~~
menuentry "Other Linux" {
	set root=(hd0,2)
	linux /boot/vmlinuz (add other options here as required)
	initrd /boot/initrd.img (if the other kernel uses/needs one)
}
~~~

Alternatively let GRUB search for the right partition by UUID or file system label:

~~~
menuentry "Other Linux" {
    # assuming that UUID is 763A-9CB6
    search --no-floppy --set=root --fs-uuid 763A-9CB6

    # search by label OTHER_LINUX (make sure that partition label is unambiguous)
    #search --no-floppy --set=root --label OTHER_LINUX

    linux /boot/vmlinuz (add other options here as required, for example: root=UUID=763A-9CB6)
    initrd /boot/initrd.img (if the other kernel uses/needs one)
}
~~~



### grub shell

从 rescue 模式 切换到 normal 模式，以便使用更多命令。

~~~
grub rescue> set prefix=(hdX,Y)/boot/grub
grub rescue> insmod (hdX,Y)/boot/grub/i386-pc/normal.mod
rescue:grub> normal
~~~

#### 从shell启动系统

使用 `chainloading`， Chainloading 表示加载另外一个 boot-loader

Chainloading a partition's VBR

~~~
set root=(hdX,Y)
chainloader +1
boot
~~~~

For example to chainload Windows stored in the first partition of the first hard disk,

~~~
set root=(hd0,1)
chainloader +1
boot
~~~

Chainloading a disk's MBR or a partitionless disk's VBR

~~~
set root=hdX
chainloader +1
boot
~~~

Chainloading Windows/Linux installed in UEFI mode

~~~
insmod fat
set root=(hd0,gpt4)
chainloader (${root})/EFI/Microsoft/Boot/bootmgfw.efi
boot
~~~

`insmod fat` 用来加载 FAT 文件系统 ，才能访问 EFI 分区。 上例，`(hd0,gpt4)` or `/dev/sda4` 就是 EFI分区。


#### Using the rescue console

rescue 模式下可以使用命令： `insmod`, `ls`, `set`, `unset`

`set` modifies variables and `insmod` inserts new modules to add functionality.

开始修复grub之前，必须先知道 `/boot` 分区的位置，才能找到 grub。

~~~
grub rescue> set prefix=(hdX,Y)/boot/grub
~~~

添加 linux 模板来引入 `linux` 和 `initrd` 命令。

~~~sh
grub rescue> insmod i386-pc/linux.mod

#或
grub rescue> insmod linux
~~~

An example, booting Arch Linux:

~~~
set root=(hd0,5)
linux (hdX,Y)/vmlinuz-linux root=/dev/sda6
initrd (hdX,Y)/initramfs-linux.img
boot
~~~

上例子， `(hd0,5)` 是 EFI 分区，`/dev/sda6` 是 linux 分区。

成功启动进linux系统之后，可以开始修复grub了，比如， 修改`grub.cfg` 或者 重装GRUB。

























