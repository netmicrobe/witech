---
layout: post
title: VirtualBox VM/虚拟机：Windows 系统虚拟硬盘扩大容量，压缩磁盘上内容
categories: [ cm, vm ]
tags: [VirtualBox, vdi]
---

* 参考
  * [VirtualBox – how to reduce virtual disk sizes](https://better-coding.com/solved-virtualbox-how-to-reduce-virtual-disk-size/)
  * <https://forums.virtualbox.org/viewtopic.php?t=78744>
  * <https://www.howtogeek.com/312883/how-to-shrink-a-virtualbox-virtual-machine-and-free-up-disk-space/>


## Windows 7

### 删除补丁安装包

`C:\Windows\SoftwareDistribution\DataStore` 和 `C:\Windows\SoftwareDistribution\Download` 下的所有文件。

### Windows 7 中压缩磁盘内容

1. 资源管理器中右键点击磁盘（如C:），右键菜单选择属性
1. “常规选”项卡 -》磁盘清理
1. “工具选”项卡 -》碎片整理


### sdelete

* <https://technet.microsoft.com/en-us/sysinternals/bb897443>
* <https://docs.microsoft.com/zh-cn/sysinternals/downloads/sdelete>

删除的文件其实还在虚拟硬盘中，只有将内容全写0，VirtualBox才能真正压缩。
`sdelete` 就是干写0的事情的。


This will write zeros to all the free disk space on drive C:.
As the SDelete page on Microsoft’s website notes, the -z option is “good for virtual disk optimization”.

~~~
sdelete.exe c: -z
~~~

执行完上述操作然后关机。再运行 VBoxManage 来 compact disk 试试。


#### `VBoxManage modifymedium disk your-disk-file.vdi --compact`

从40155 MB压缩到了 40124 MB，效果一般。

~~~
>VBoxManage modifymedium disk win7x86.vdi --compact
~~~




## Ubuntu 18.04

### 使用 zerofree 工具

* 参考： <http://manpages.ubuntu.com/manpages/trusty/man8/zerofree.8.html>

1. 安装 zerofree
    ~~~
    sudo apt-get install zerofree
    ~~~
2. 重启系统，BIOS界面按`ESC`进入`recovery mode`
    ![](zerofree.png)
3. Zero unused space
    ~~~
    # 找到目标分区
    df -h
    # Zero unused space, -v 显示进度
    zerofree -v /dev/sda1
    ~~~


### 压缩vdi

1. 先使用 zerofree
2. 再使用 VBoxManage
    `VBoxManage modifymedium disk <DISK_LOCATION> --compact`



## VirtualBox 5.1

### 扩大虚拟硬盘容量

#### `VBoxManage modifymedium disk your-disk-file.vdi --resize your-new-size-MB`

下面例子，原来50G（C:），执行命令很快，虚拟盘扩展到100G，
再启动Windows，磁盘管理器看，多了50G未分配空间，在上面新建分区才能使用。

~~~、
>VBoxManage modifymedium disk win7x86.vdi --resize 102400
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
~~~

### 压缩磁盘


#### 如何找到当前要压缩的vdi文件

可以在菜单File -- Virtual Media Manager 中查看。

或者，

~~~
VBoxManage.exe list hdds
~~~





### 考虑删除不用的snapshot来节约空间

VirtualBox allows you to create snapshots for each virtual machine. These contain a full image of the virtual machine when you created the snapshot, allowing you to restore it to a previous state. These can take a lot of space.





### snapshot 使用






### VBoxManage 工具

VBoxManage.exe 这个工具程序在VirtualBox安装目录下，可以设置到path中。


~~~
>VBoxManage -help | find "medium"
  closemedium               [disk|dvd|floppy] <uuid|filename>
                            [--medium none|emptydrive|additions|
  showmediuminfo            [disk|dvd|floppy] <uuid|filename>
  createmedium              [disk|dvd|floppy] --filename <filename>
  modifymedium              [disk|dvd|floppy] <uuid|filename>
  clonemedium               [disk|dvd|floppy] <uuid|inputfile> <uuid|outputfile>
  mediumproperty            [disk|dvd|floppy] set <uuid|filename>
  encryptmedium             <uuid|filename>
  checkmediumpwd            <uuid|filename>
~~~

~~~
>VBoxManage showmediuminfo disk win7x86.vdi
UUID:           08b51f97-43b2-4b3b-964d-89c829988f19
Parent UUID:    base
State:          created
Type:           normal (base)
Location:       D:\VirtualBox_VMs\win7x86-32bit\win7x86\win7x86.vdi
Storage format: VDI
Format variant: dynamic default
Capacity:       51200 MBytes
Size on disk:   5385 MBytes
Encryption:     disabled
In use by VMs:  win7x86 (UUID: 3338da73-9c7d-415d-b91d-a2046810f79b) [win7x86 和 win7x86_tmqq 的链接基础 (UUID: 95beefd7-7132-496a-b89f-3c23e1b7688b)]
Child UUIDs:    e33c82fb-8f81-4f65-a001-d3bc18569009
                8c71e5fc-e760-4b65-a688-d65c026132dc
~~~




