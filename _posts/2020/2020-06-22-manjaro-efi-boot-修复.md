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




## 从 ubuntu 修复 manjaro

为啥从ubuntu呢，应为另外一个分区上的mint活得好的的，不用救呀～～～

1. `lsblk -f` 找到 Manjaro 的分区
    例如，我的manjaro 分区是 `/dev/nvme0n1p9` efi 分区是 `/dev/nvme0n1p2`
1. 手动chroot
    ~~~
    mount /dev/nvme0n1p9 /mnt
    mount /dev/nvme0n1p2 /mnt/boot/efi
    cd /mnt
    mount -t proc proc /mnt/proc
    mount -t sysfs sys /mnt/sys
    mount -o bind /dev /mnt/dev
    mount -t devpts pts /mnt/dev/pts/
    chroot /mnt
    ~~~
1. 执行grub命令修复
    ~~~
    sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck -v
    sudo update-grub
    ~~~


























