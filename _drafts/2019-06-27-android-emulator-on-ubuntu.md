---
layout: post
title: Ubuntu 上使用 Android 模拟器 / emulator
categories: [cm, android]
tags: [mint]
---

* 参考： 
  * [Run apps on the Android Emulator](https://developer.android.com/studio/run/emulator)
  * []()



* Android 模拟器不能在32位Windows上运行。


## AVD

图形界面： Android Studio -\> Configure -\> AVD Manager





## Trouble Shooting


### 创建AVD时，“/dev/kvm permission denied.”

* 参考：
  * <https://stackoverflow.com/a/45749003>

~~~
sudo apt install qemu-kvm

# check the ownership of /dev/kvm
ls -al /dev/kvm

# add your user to the kvm group
sudo adduser $USER kvm
~~~

然后重启电脑再试试。




### 命令行执行 avdmanager, sdkmanager 报错"ClassNotFoundException:...XmlSchema"

* 参考
  * <https://stackoverflow.com/a/51644855>

~~~
~$ avdmanager
Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema
	at com.android.repository.api.SchemaModule$SchemaModuleVersion.<init>(SchemaModule.java:156)
	at com.android.repository.api.SchemaModule.<init>(SchemaModule.java:75)
	at com.android.sdklib.repository.AndroidSdkHandler.<clinit>(AndroidSdkHandler.java:81)
	at com.android.sdklib.tool.AvdManagerCli.run(AvdManagerCli.java:213)
	at com.android.sdklib.tool.AvdManagerCli.main(AvdManagerCli.java:200)
Caused by: java.lang.ClassNotFoundException: javax.xml.bind.annotation.XmlSchema
	at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:583)
	at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:190)
	at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:499)
	... 5 more
~~~

解决：

Linux/MAC:

~~~
export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
~~~

Windows:

~~~
set JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
~~~

And to save it permanently you can exports the JAVA_OPTS in your profile file on linux (.zshrc, .bashrc and etc.) or add as environment permanently on Windows.

补充： Java 11 以后Java EE modules就不存在啦，这个方法没用。只能降级Java 版本。或者等Google更新。



### Missing emulator engine program for 'x86' CPU

* 参考
  * [Update Your Path For The New Android Emulator Location](https://www.stkent.com/2017/08/10/update-your-path-for-the-new-android-emulator-location.html)
  * <https://stackoverflow.com/a/49511666>


使用 `${ANDROID_SDK_ROOT}/tools/emulator` 就会报错： 

~~~
PANIC: Missing emulator engine program for 'x86' CPU.
~~~

使用 `${ANDROID_SDK_ROOT}/emulator/emulator` **就不会**。


* 解决方法

在 `.bashrc` 中将emulator的搜索路径设置到 tools 目录前

~~~
export PATH=$PATH:$ANDROID_HOME/emulator::$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
~~~

检查效果： `which emulator`




### 模拟器无法启动


可能有如下原因：
1. 正在使用的app占用了 VT-x，例如，virtualbox
2. 没装 ia32-libs，可以先装下： `sudo apt install ia32-libs`
    * 参考： <https://askubuntu.com/a/143321>


* 错误提示
  ~~~
  statvfs('/home/someuser/.android/avd/Pixel_API_28.avd/snapshots/default_boot/ram.img') failed: No such file or directory
  Warning: QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root' ((null):0, (null))
  emulator: INFO: QtLogger.cpp:66: Warning: QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root' ((null):0, (null))


  ioctl(KVM_CREATE_VM) failed: 16 Device or resource busy
  qemu-system-x86_64: failed to initialize KVM: Device or resource busy
  ~~~



* 启动模拟器，virtualbox 无法启动，提示：
  ~~~
  VT-x is being used by another hypervisor (VERR_VMX_IN_VMX_ROOT_MODE).
  VirtualBox can't operate in VMX root mode. Please disable the KVM kernel extension, recompile your kernel and reboot (VERR_VMX_IN_VMX_ROOT_MODE).


  Result Code: 
  NS_ERROR_FAILURE (0x80004005)
  Component: 
  ConsoleWrap
  Interface: 
  IConsole {872da645-4a9b-1727-bee2-5585105b9eed}
  ~~~



### 模拟器和VirutalBox同时运行

* 参考：
  * [Using KVM and VirtualBox side by side](https://www.dedoimedo.com/computers/kvm-virtualbox.html)
  * <https://askubuntu.com/a/403593>
  * []()
  * []()

* **问题**

* 启动模拟器，virtualbox 无法启动，提示：
  ~~~
  VT-x is being used by another hypervisor (VERR_VMX_IN_VMX_ROOT_MODE).
  VirtualBox can't operate in VMX root mode. Please disable the KVM kernel extension, recompile your kernel and reboot (VERR_VMX_IN_VMX_ROOT_MODE).
  ~~~

* 启动 VirtualBox，模拟器无法启动，报错：
  ~~~
  statvfs('/home/someuser/.android/avd/Pixel_API_28.avd/snapshots/default_boot/ram.img') failed: No such file or directory
  ioctl(KVM_CREATE_VM) failed: 16 Device or resource busy
  qemu-system-x86_64: failed to initialize KVM: Device or resource busy
  ~~~



* **分析**

* VirtualBox can't operate in VMX root mode. 
* The Linux supports insertion and removal of kernel modules on the fly, without a reboot. use `insmod` and `rmmod` commands.



* **分析**

~~~
# to see what modules are loaded into memory

$ sudo lsmod | grep vbox
vboxpci                24576  0
vboxnetadp             28672  0
vboxnetflt             28672  0
vboxdrv               475136  4 vboxpci,vboxnetadp,vboxnetflt

$ sudo lsmod | grep kvm
kvm_intel             208896  0
kvm                   626688  1 kvm_intel
irqbypass              16384  1 kvm
~~~

VirtualBox uses `vboxdrv` and `vboxnetflt` drivers, while KVM uses `kvm` and `kvm_intel` drivers.

`kvm_intel` is specific to Intel architecture. `kvm_amd` for AMD platforms.

解决问题的思路是，先卸载kvm模块，启动 VirtualBox 后，再装载 kvm 相关模块。

~~~
# unload KVM modules.
/sbin/rmmod kvm_intel
/sbin/rmmod kvm
~~~

~~~
sudo updatedb
sudo locate kvm | grep kvm.ko
sudo locate kvm | grep kvm-intel.ko

# insert the one that matches your running kernel.
/sbin/insmod /lib/modules/`uname -r`/kernel/arch/x86/kvm/kvm.ko
/sbin/insmod /lib/modules/`uname -r`/kernel/arch/x86/kvm/kvm-intel.ko
~~~


* **解决**

~~~
#!/bin/bash

# to enable VirtualBox and disable KVM

/sbin/rmmod kvm_intel
/sbin/rmmod kvm
/etc/init.d/vboxdrv start
~~~

~~~
#!/bin/bash

# to load KVM and stop VirtualBox

/etc/init.d/vboxdrv stop
/sbin/insmod /lib/modules/`uname -r`/kernel/arch/x86/kvm/kvm.ko
/sbin/insmod /lib/modules/`uname -r`/kernel/arch/x86/kvm/kvm-intel.ko
~~~








