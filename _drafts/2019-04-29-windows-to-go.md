---
layout: post
title: 在 移动固态硬盘 pssd 上安装 windows to go
categories: [cm, windows]
tags: [ssd, wtg]
---

* 参考： 
  * []()
  * []()



1. rufus 制作 windows to go 

2. 调整分区
    
    `df -h` 查看ssd的kernal name
    `sudo umount -f /dev/sdx`，否则在GParted中看到ntfs系统分区是锁定状态，无法操作
    启动GParted调整分区，我ssd有1T，缩小windows系统分区到200G，其他做data分区

3. ntfs分区读写问题
    
    ubuntu默认已经安装 ntfs-3g ，但是会以 read-only 方式挂载刚弄好的ntfs分区。
    需要重新挂载一下： `sudo mount -o rw,remount /dev/sdXy`
    
    如果remount还无效，umount 之后再mount还报错如下，使用 `sudo ntfsfix /dev/sdXY` 修复ntfs分区（奇怪的是，修不修复，windows下分区的读写都好好的），
    * 参考 
      * <https://askubuntu.com/a/566381>
      * <https://www.mkyong.com/linux/ubuntu-status-14-the-disk-contains-an-unclean-file-system/>

    ~~~
    $ sudo mount -t ntfs -o defaults,locale=zh_CN.utf8 /dev/sdXy /media/ubuntu/your-part-label

    The disk contains an unclean file system (0, 0).
    Metadata kept in Windows cache, refused to mount.
    Falling back to read-only mount because the NTFS partition is in an
    unsafe state. Please resume and shutdown Windows fully (no hibernation
    or fast restarting.)
    ntfs-3g-mount: failed to access mountpoint /media/wi/t5data: No such file or directory
    ~~~


4. 用 `dd` 备份win10
    * ref
      * <https://www.opentechguides.com/how-to/article/centos/171/linux-disk-clone.html>
      * <https://wiki.archlinux.org/index.php/Dd>
      * <https://www.cyberciti.biz/faq/unix-linux-dd-create-make-disk-image-commands/>
      * [How to clone disks with Linux dd command](https://www.howtoforge.com/tutorial/linux-dd-command-clone-disk-practical-example/)

    * `dd` 是全分区拷贝，
      例如，200G的分区，无论使用了多少空间，统统备份出200G，
      压缩程序会将空白内容压缩，30G的已使用空间，压缩完镜像文件是5个多G，
      所以，文件体积到不是问题，关键慢，dd & gzip一个200G的分区，花了40多分钟（90M/s）。
      恢复回去也是同样的慢，花了1个多小时（45M/s）！！（可能也有文件系统是ntfs的原因）
      另外，对空数据的写回操作，还会浪费ssd擦写寿命。
      
    * 可以用count参数来精确拷贝分区上已使用的数据，应该会快些吧。 count 的值 = (分区已使用字节数 + 1) / bs参数

    ~~~
    # 备份分区到镜像文件，并用 gzip 压缩
    dd if=/dev/sdb1 bs=64M conv=sync,noerror status=progress | gzip -c > /path/to/backup.img.gz

    # 从镜像文件恢复
    gunzip -c /path/to/backup.img.gz | sudo dd of=/dev/sdb1 status=progress
    ~~~

    ~~~
    # 备份分区到镜像文件，并用 bzip2 压缩
    dd if=/dev/sda1 bs=64M conv=sync,noerror status=progress | bzip2 -9f > /path/to/backup.img.bz2

    # 从镜像文件恢复
    bunzip2 -dc /path/to/backup.img.bz2 | dd of=/dev/sda1 status=progress
    ~~~

















