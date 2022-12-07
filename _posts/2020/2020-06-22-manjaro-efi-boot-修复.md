---
layout: post
title: manjaro efi boot 修复
categories: [cm, linux]
tags: [manjaro, efi, boot]
---

* 参考： 
  * [GRUB/Restore the GRUB Bootloader - wiki.manjaro.org](https://wiki.manjaro.org/index.php/Restore_the_GRUB_Bootloader)
  * []()
  * []()


## 查看下grub2信息

查看grub2版本： `grub-install -V`

## 从 ubuntu 修复 manjaro

为啥从ubuntu呢，应为另外一个分区上的mint活得好的的，不用救呀～～～

1. `lsblk -f` 找到 Manjaro 的分区
    例如，我的manjaro 分区是 `/dev/nvme0n1p9` efi 分区是 `/dev/nvme0n1p2`
1. 手动chroot
    ~~~
    sudo mount /dev/nvme0n1p9 /mnt
    sudo mount /dev/nvme0n1p2 /mnt/boot/efi
    cd /mnt
    sudo mount -t proc proc /mnt/proc
    sudo mount -t sysfs sys /mnt/sys
    sudo mount -o bind /dev /mnt/dev
    sudo mount -t devpts pts /mnt/dev/pts/
    sudo chroot /mnt
    ~~~
1. 执行grub命令修复
    ~~~
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck -v
    update-grub
    ~~~
1. 如果报错 update-grub command not found，说明这个脚本在这个distro么有，直接使用实际命令：
    ~~~sh
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    ~~~

### `grub-install` 是提醒错误：`EFI variables are not supported on this system.`

* 现象：
    ~~~
    grub-install: info: copying `/boot/grub/x86_64-efi/core.efi' -> `/boot/efi/EFI/manjaro2/grubx64.efi'.
    grub-install: info: Registering with EFI: distributor = `manjaro2', path = `\EFI\manjaro2\grubx64.efi', ESP at hostdisk//dev/nvme0n1,gpt1.
    grub-install: info: executing efibootmgr --version </dev/null >/dev/null.
    grub-install: info: executing modprobe -q efivarfs.
    EFI variables are not supported on this system.
    grub-install: info: executing efibootmgr -c -d /dev/nvme0n1 -p 1 -w -L manjaro2 -l \EFI\manjaro2\grubx64.efi.
    EFI variables are not supported on this system.
    grub-install: error: efibootmgr failed to register the boot entry: No such file or directory.
    ~~~

* 解决：
  1. 可能是没有EFI方式启动，如果 host 系统运行 `sudo efivar-tester` 也报`EFI variables are not supported`错误。
  2. 如果host 系统运行 `sudo efivar-tester`正常，`sudo modprobe efivarfs` 也能正常加载模块，但是进入 `chroot` 执行 `sudo efivar-tester` 还是报`EFI variables are not supported`错误。
      返回 host系统，挂载 efivarfs： `sudo mount -t efivarfs efivarfs /mnt/sys/firmware/efi/efivars`



## ubuntu efi 修复

ubuntu只能使用ubuntu的系统来进行 `chroot` 后， 用`grub-install`修复。

chroot的挂载和manjaro一样。 `grub-install`命令比manjaro简单。

~~~
grub-install /dev/sdX
grub-install --recheck /dev/sdX
update-grub
~~~








































