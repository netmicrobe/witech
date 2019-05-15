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
    * 勾选“显示USB外置硬盘”
    * 设备：目标USB外置硬盘
    * 镜像文件：选择1803及以前版本的windows（1809版本的WTG有问题，会蓝屏）
    * 镜像选项：Windows To Go
    * 分区类型：MBR
    * 目标系统类型：BIOS 或 UEFI
    * 不需要勾选：“添加对旧BIOS修正”、“使用Rufus MBR配合BIOS ID”
    * 卷标：w10togo
    * 文件系统：NTFS
    * 簇大小：4096字节

    设置好，点击“开始”，然后等一会。

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

    ~~~
    # 备份分区到镜像文件，并用 7za 压缩
    dd if=/dev/sda1 bs=1048576 conv=sync,noerror status=progress | 7za a -si -t7z -mx=1 -m0=LZMA2 -mmt=8  /path/to/backup.img.7z

    # 从镜像文件恢复
    7za x /path/to/backup.img.7z -so | dd of=/dev/sda1 status=progress

    # 7z 的多线程
    # https://stackoverflow.com/a/39931605
    -t7z -m0=LZMA2:d64k:fb32 -ms=8m -mmt=30 -mx=1       压缩级别1（最快），30个线程
    # https://www.experts-exchange.com/questions/28727860/What-7zip-Command-Line-Enables-Multithreading.html
    -t7z  -mx=9 -m0=LZMA2 -mmt14
    ~~~



## 在Mac上使用dd进行备份和恢复

~~~
diskutil ummountDisk /dev/disk2
# status=progress 不支持
# bs=1M 不支持，只能写成 bs=1048576
sudo dd if=/dev/disk2s1 bs=1048576 count=分区实际使用多少兆+几兆的余量 conv=sync,noerror  | bzip2 -f > /Volumes/Lexar/t5w10_1803.img.bz2
~~~




## partition 4k alignment  分区4K对齐




Device       Start         End           Sectors       Size     Type
/dev/sdd1    63            1953523088    1953523026    931.5G   NTFS
/dev/sdd2    1953523089    1953524112       1024       512K     EFI


/dev/sdd1    2048    1953521663    1953519616    931.5G    NTFS
/dev/sdd2    1953523089     1953524112      1024        512K     EFI



[ubuntu forum - Thread: Installers fdisk and 4k aligned SSD](https://ubuntuforums.org/showthread.php?t=2096128)

The 4k alignment usually refers to the Start sector of the first partition, and it's usually 2048 (that means 1MiB if you calculate 2048 sectors of 512B each).
The rule is more or less that the first sector has to be divisible by 8. Most commonly used value is 2048.

Try listing the disks with parted using sectors as units:
`sudo parted -l unit s`


[What Is Partition Alignment, and Why Should I Care?](https://www.howtogeek.com/270358/how-to-speed-up-your-solid-state-drive-by-re-aligning-its-partitions/)


How to Check if Your Partitions Are Correctly Aligned

1. Windows 运行 `msinfo32`
1. Components -\> Storage -\> Disks
1. Scroll down in the left pane, locate your SSD, and find the “Partition Starting Offset” value below it.
1. Check if this number is evenly divisible by 4096.

How to Fix Incorrectly Aligned Partitions

1. use the free version of MiniTool Partition Wizard
    <https://www.partitionwizard.com/free-partition-manager.html>
1. launch the partition manager, right-click the partition you want to align, and select “Align”.


[How do I check whether partitions on my SSD are properly aligned?](https://askubuntu.com/a/240006)

Parted has an align-check build in.

parted /dev/sda
align-check opt n
n is the partition you want to check.


[Partition Alignment](https://www.thomas-krenn.com/en/wiki/Partition_Alignment)

fdisk

The -S 32 -H 64 flags will however definitely align along the one megabyte boundary (32 sectors per track by 64 heads by 512 bytes equals 1,048,576 bytes or 1 megabyte). 


With regard to util-linux-ng versions after 2.17.1, fdisk will align on the one megabyte boundary, if DOS compatibility mode has been disabled.

The recommended settings for newer versions of fdisk are:[9]

* Use the fdisk utility from util-linux-ng versions 2.17.2 or later
* Read the fdsik warnings.
* Deactivate DOS compatibility mode (the `-c` flag).
* Use sectors as display units (the `-u` flag).
* Use the `+size(M, G)` option in order to specify the end of a partition.













































































