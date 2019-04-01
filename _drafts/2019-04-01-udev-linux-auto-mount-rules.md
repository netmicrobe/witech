---
layout: post
title: udev 自动挂载规则 / auto mount rules
categories: [cm, linux]
tags: [udev]
---

* 参考： 
  * [Writing udev rules](http://reactivated.net/writing_udev_rules.html)
  * []()
  * []()
  * []()



## 介绍

udev is the "new" way of managing /dev directories, designed to clear up some issues with previous /dev implementations, and provide a robust path forward. In order to create and name /dev device nodes corresponding to devices that are present in the system, udev relies on matching information provided by sysfs with rules provided by the user. This documentation aims to detail the process of rule-writing, one of the only udev-related tasks that must (optionally) be performed by the user.

`udev` 是替代 `devfs` 管理 `/dev` 目录的新方法，利用 `sysfs` 和用户自定义规则来自动挂载移动存储设备。

`sysfs` 是从 2.6 kernel 开始的新文件系统，能够输出连接系统的硬件信息，`udev` 可以利用这些信息来创建 device node。 sysfs is mounted at /sys and is browseable.


### Built-in persistent naming schemes

udev provides out-of-the-box persistent naming for storage devices in the /dev/disk directory. To view the persistent names which have been created for your storage hardware, you can use the following command:

~~~
# ls -lR /dev/disk
~~~

This works for all storage types. 





## Rule writing


### Rule files 

udev reads a series of rules files. These files are kept in the `/etc/udev/rules.d` directory, and they all must have the `.rules` suffix.

Default udev rules are stored in `/etc/udev/rules.d/50-udev.rules`. 

`/etc/udev/rules.d/`中的文件一般按照文件名排序（lexical order）解析, 为了在Default rules之前生效，自定的rules建议写到`/etc/udev/rules.d/10-local.rules`。

### semantics

* In a rules file, lines starting with "#" are treated as comments.
* Every other non-blank line is a rule. 
* Rules cannot span multiple lines.
* One device can be matched by more than one rule. 
* It is important to understand that udev will not stop processing when it finds a matching rule, it will continue searching and attempt to apply every rule that it knows about.


### Rule syntax

* Each rule is constructed from a series of key-value pairs, which are separated by commas.
* match keys are conditions used to identify the device which the rule is acting upon.
* When all **match** keys in a rule correspond to the device being handled, then the rule is applied and the actions of the **assignment* keys are invoked.

  * 例子
  ~~~
  KERNEL=="hdb", NAME="my_spare_disk"
  ~~~

  The above rule includes one **match** key __(KERNEL)__ and one **assignment** key __(NAME)__.

  * the match key is related to its value through the **equality operator (==)**
  * the assignment key is related to its value through the **assignment operator (=)**.



#### Basic Rules

* common match keys
  * KERNEL - match against the kernel name for the device
  * SUBSYSTEM - match against the subsystem of the device
  * DRIVER - match against the name of the driver backing the device

* The most basic assignment keys
  * NAME - the name that shall be used for the device node
  * SYMLINK - a list of symbolic links which act as alternative names for the device node


If you wish to provide alternate names for this device node, you use the symbolic link functionality. With the SYMLINK assignment, you are actually maintaining a list of symbolic links, all of which will be pointed at the real device node. To manipulate these links, we introduce a new operator for appending to lists: +=. You can append multiple symlinks to the list from any one rule by separating each one with a space.

~~~
KERNEL=="hdb", NAME="my_spare_disk"
~~~

The above rule says: match a device which was named by the kernel as hdb, and instead of calling it hdb, name the device node as my_spare_disk. The device node appears at /dev/my_spare_disk.

~~~
KERNEL=="hdb", DRIVER=="ide-disk", SYMLINK+="sparedisk"
~~~

The above rule says: match a device which was named by the kernel as hdb AND where the driver is ide-disk. Name the device node with the default name and create a symbolic link to it named sparedisk. Note that we did not specify a device node name, so udev uses the default. In order to preserve the standard /dev layout, your own rules will typically leave the NAME alone but create some SYMLINKs and/or perform other assignments.

~~~
KERNEL=="hdc", SYMLINK+="cdrom cdrom0"
~~~

The above rule is probably more typical of the types of rules you might be writing. It creates two symbolic links at /dev/cdrom and /dev/cdrom0, both of which point at /dev/hdc. Again, no NAME assignment was specified, so the default kernel name (hdc) is used.


#### Matching sysfs attributes

can identify devices based on advanced properties such as vendor codes, exact product numbers, serial numbers, storage capacities, number of partitions, etc.

Many drivers export information like this into sysfs, and udev allows us to incorporate sysfs-matching into our rules, using the ATTR key with a slightly different syntax.

例如，

~~~
SUBSYSTEM=="block", ATTR{size}=="234441648", SYMLINK+="my_disk"
~~~



#### Device hierarchy

The Linux kernel actually represents devices in a tree-like structure, and this information is exposed through sysfs and useful when writing rules. For example, the device representation of my hard disk device is a child of the SCSI disk device, which is in turn a child of the Serial ATA controller device, which is in turn a child of the PCI bus device. It is likely that you will find yourself needing to refer to information from a parent of the device in question, for example the serial number of my hard disk device is not exposed at the device level, it is exposed by its direct parent at the SCSI disk level.

* KERNELS - match against the kernel name for the device, or the kernel name for any of the parent devices
* SUBSYSTEMS - match against the subsystem of the device, or the subsystem of any of the parent devices
* DRIVERS - match against the name of the driver backing the device, or the name of the driver backing any of the parent devices
* ATTRS - match a sysfs attribute of the device, or a sysfs attribute of any of the parent devices




#### String substitutions

略，参考 <http://reactivated.net/writing_udev_rules.html#strsubst>





#### String matching

udev allows you to use shell-style pattern matching. There are 3 patterns supported:

~~~
* - match any character, zero or more times
? - match any character exactly once
[] - match any single character specified in the brackets, ranges are also permitted
~~~

例子： 

The first rule matches all floppy disk drives, and ensures that the device nodes are placed in the /dev/floppy directory, as well as creating a symbolic link from the default name.  `%n` `%k` 之类的字符串含义，参见 “String substitutions”

~~~
KERNEL=="fd[0-9]*", NAME="floppy/%n", SYMLINK+="%k"
~~~

The second rule ensures that hiddev devices are only present in the /dev/usb directory.

~~~
KERNEL=="hiddev*", NAME="usb/%k"
~~~






## Finding information from sysfs

### sysfs tree

`sysfs` 把设备的信息都存到 /sys 的各级目录结构中。

这些个目录结构中，有各种link和实际设备对于的device nodes文件夹（top-level device paths）。

Top-level device paths can be classified as sysfs directories which contain a dev file, the following command will list these for you:

~~~
# find /sys -name dev
~~~

### 磁盘容量

When you write rules based on sysfs information, you are simply matching attribute contents of some files in one part of the chain. For example, I can read the size of my hard disk as follows:

~~~
# cat /sys/block/sda/size
234441648
~~~


### udevinfo 命令

udevinfo 命令直接打印出设备信息。

注意，Ubuntu上使用 `udevadm`，往下看。

~~~
# udevinfo -a -p /sys/block/sda

  looking at device '/block/sda':
    KERNEL=="sda"
    SUBSYSTEM=="block"
    ATTR{stat}=="  128535     2246  2788977   766188    73998   317300  3132216  5735004        0   516516  6503316"
    ATTR{size}=="234441648"
    ATTR{removable}=="0"
    ATTR{range}=="16"
    ATTR{dev}=="8:0"

  looking at parent device '/devices/pci0000:00/0000:00:07.0/host0/target0:0:0/0:0:0:0':
    KERNELS=="0:0:0:0"
    SUBSYSTEMS=="scsi"
    DRIVERS=="sd"
    ATTRS{ioerr_cnt}=="0x0"
    ATTRS{iodone_cnt}=="0x31737"
    ATTRS{iorequest_cnt}=="0x31737"
    ATTRS{iocounterbits}=="32"
    ATTRS{timeout}=="30"
    ATTRS{state}=="running"
    ATTRS{rev}=="3.42"
    ATTRS{model}=="ST3120827AS     "
    ATTRS{vendor}=="ATA     "
    ATTRS{scsi_level}=="6"
    ATTRS{type}=="0"
    ATTRS{queue_type}=="none"
    ATTRS{queue_depth}=="1"
    ATTRS{device_blocked}=="0"

  looking at parent device '/devices/pci0000:00/0000:00:07.0':
    KERNELS=="0000:00:07.0"
    SUBSYSTEMS=="pci"
    DRIVERS=="sata_nv"
    ATTRS{vendor}=="0x10de"
    ATTRS{device}=="0x037f"
~~~


#### udevadm  

~~~ shell
udevadm info -q path -n /dev/sda1
udevadm info -q all -n /dev/sda1

udevadm info -a -p $(udevadm info -q path -n /dev/sda1)
~~~

~~~ shell
# you can list the partitions with:
sudo fdisk -l

# or
sudo blkid
~~~




#### usbview

GUI工具，参考 <http://www.kroah.com/linux/usb/>










## Advanced topics

### Controlling permissions and ownership

udev allows you to use additional assignments in rules to control ownership and permission attributes on each device.

The `GROUP` assignment allows you to define which Unix group should own the device node. 

~~~
KERNEL=="fb[0-9]*", NAME="fb/%n", SYMLINK+="%k", GROUP="video"
~~~

The `OWNER` key, perhaps less useful, allows you to define which Unix user should have ownership permissions on the device node.

~~~
KERNEL=="fd[0-9]*", OWNER="john"
~~~


udev defaults to creating nodes with Unix permissions of 0660 (read/write to owner and group). If you need to, you can override these defaults on certain devices using rules including the MODE assignment. As an example, the following rule defines that the inotify node shall be readable and writable to everyone:

~~~
KERNEL=="inotify", NAME="misc/%k", SYMLINK+="%k", MODE="0666"
~~~




### Using external programs to name devices

利用 外部程序 和 %k %n等参数来命名device，“String substitutions”高级版呀，此处略，参考：

<http://reactivated.net/writing_udev_rules.html#external-naming>




### Running external programs upon certain events

此处略，参考：

<http://reactivated.net/writing_udev_rules.html#external-run>



### Environment interaction

udev provides an ENV key for environment variables which can be used for both matching and assignment.

**In the assignment case**, you can set environment variables which you can then match against later. 例如： 

~~~
KERNEL=="fd0", SYMLINK+="floppy", ENV{some_var}="value"
~~~

**In the matching case**, you can ensure that rules only run depending on the value of an environment variable.

~~~
KERNEL=="fd0", ENV{an_env_var}=="yes", SYMLINK+="floppy"
~~~



### Additional options

Another assignment which can prove useful is the OPTIONS list. A few options are available:

* **all_partitions** - create all possible partitions for a block device, rather than only those that were initially detected
* **ignore_device** - ignore the event completely
* **last_rule** - ensure that no later rules have any effect

For example, the rule below sets the group ownership on my hard disk node, and ensures that no later rule can have any effect:

~~~
KERNEL=="sda", GROUP="disk", OPTIONS+="last_rule"
~~~




## Examples



### USB Printer

I power on my printer, and it is assigned device node /dev/lp0. Not satisfied with such a bland name, I decide to use udevinfo to aid me in writing a rule which will provide an alternative name:

~~~
# udevinfo -a -p $(udevinfo -q path -n /dev/lp0)
  looking at device '/class/usb/lp0':
    KERNEL=="lp0"
    SUBSYSTEM=="usb"
    DRIVER==""
    ATTR{dev}=="180:0"

  looking at parent device '/devices/pci0000:00/0000:00:1d.0/usb1/1-1':
    SUBSYSTEMS=="usb"
    ATTRS{manufacturer}=="EPSON"
    ATTRS{product}=="USB Printer"
    ATTRS{serial}=="L72010011070626380"vide an alternative name:
~~~

My rule becomes:

~~~
SUBSYSTEM=="usb", ATTRS{serial}=="L72010011070626380", SYMLINK+="epson_680"
~~~


### USB Hard Disk

A USB hard disk is comparable to the USB camera I described above, however typical usage patterns are different. In the camera example, I explained that I am not interested in the sdb node - it's only real use is for partitioning (e.g. with fdisk), but why would I want to partition my camera!?

Of course, if you have a 100GB USB hard disk, it is perfectly understandable that you might want to partition it, in which case we can take advantage of udev's string substitutions:

~~~
KERNEL=="sd*", SUBSYSTEMS=="scsi", ATTRS{model}=="USB 2.0 Storage Device", SYMLINK+="usbhd%n"
~~~

This rule creates symlinks such as:

~~~
/dev/usbhd - The fdiskable node
/dev/usbhd1 - The first partition (mountable)
/dev/usbhd2 - The second partition (mountable)
~~~







## Testing and debugging


### Putting your rules into action

udev will not automatically reprocess all devices and attempt to apply the new rule(s). For example, To make the symbolic link show up, you can either disconnect and reconnect your camera, or alternatively in the case of non-removable devices, you can run `udevtrigger`.

If your kernel does not have inotify support, new rules will not be detected automatically. In this situation, you must run `udevcontrol reload_rules` after making any rule file modifications for those modifications to take effect.



### udevtest

If you know the top-level device path in sysfs, you can use `udevtest` to show the actions which udev would take. 

~~~
# udevtest /class/sound/dsp
main: looking at device '/class/sound/dsp' from subsystem 'sound'
udev_rules_get_name: add symlink 'dsp'
udev_rules_get_name: rule applied, 'dsp' becomes 'sound/dsp'
udev_device_event: device '/class/sound/dsp' already known, remove possible symlinks
udev_node_add: creating device node '/dev/sound/dsp', major = '14', minor = '3', mode = '0660', uid = '0', gid = '18'
udev_node_add: creating symlink '/dev/dsp' to 'sound/dsp'
~~~

Note the /sys prefix was removed from the udevtest command line argument, this is because udevtest operates on device paths. Also note that udevtest is purely a testing/debugging tool, it does not create any device nodes, despite what the output suggests!


















































































































































