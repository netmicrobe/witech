---
layout: post
title: 命令行使用android模拟器avd
categories: [ cm, android ]
tags: [ avd, emulator ]
---

* 参考
  * [Android模拟器启动失败之emulator错误集锦](http://www.dongchunlin.com/2017/07/24/emulator-error-fail/)
  * [developer.android.com - Start the emulator from the command line](https://developer.android.com/studio/run/emulator-commandline)
  * []()
  * []()
  * []()
---



### 列出可用avd

~~~ shell
avdmanager list avd

# 或

emulator -list-avds
~~~


### 启动 avd

~~~ shell
emulator -avd Nexus7_API30_ARM
~~~


* 启动x86 image 报错 ，关了vbox虚拟机就可以启动了

~~~
emulator -avd Nexus7_API30_ARM
emulator: Android emulator version 30.7.4.0 (build_id 7453540) (CL:N/A)
handleCpuAcceleration: feature check for hvf
Fontconfig warning: "/usr/share/fontconfig/conf.avail/05-reset-dirs-sample.conf", line 6: unknown element "reset-dirs"
cannot add library /Volumes/silo/android/sdk/emulator/qemu/linux-x86_64/lib64/vulkan/libvulkan.so: failed
added library /Volumes/silo/android/sdk/emulator/lib64/vulkan/libvulkan.so
cannot add library /Volumes/silo/android/sdk/emulator/lib64/vulkan/libvulkan.so.1: full
ioctl(KVM_CREATE_VM) failed: 16 Device or resource busy
qemu-system-x86_64: failed to initialize KVM: Device or resource busy
~~~


* 启动arm image 报错，最终 Android 11 的模拟器还是没法启动 arm image

~~~
emulator -avd Nexus7_API30_ARM

emulator: Android emulator version 30.7.4.0 (build_id 7453540) (CL:N/A)
Fontconfig warning: "/usr/share/fontconfig/conf.avail/05-reset-dirs-sample.conf", line 6: unknown element "reset-dirs"
emulator: WARNING: Your AVD has been configured with an in-guest renderer, but the system image does not support guest rendering.Falling back to 'swiftshader_indirect' mode.
cannot add library /Volumes/silo/android/sdk/emulator/qemu/linux-x86_64/lib64/vulkan/libvulkan.so: failed
added library /Volumes/silo/android/sdk/emulator/lib64/vulkan/libvulkan.so
cannot add library /Volumes/silo/android/sdk/emulator/lib64/vulkan/libvulkan.so.1: full
emulator: INFO: ignore sdcard for arm at api level >= 30
emulator: INFO: GrpcServices.cpp:315: Started GRPC server at 127.0.0.1:8554, security: Local
emulator: INFO: EmulatorAdvertisement.cpp:93: Advertising in: /run/user/1000/avd/running/pid_7775.ini
qemu-system-aarch64: PCI bus not available for hda
~~~





## 排查错误

### 执行avdmanager报错：java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema

原因我的arch linux 安装的 openjdk-15，安装了openjdk-8，用 `archlinux-java set java-8-openjdk` 切换为 java 8 就好了。



### avd 启动报错：Qt library not found at ../emulator/lib64/qt/lib

~~~ shell
emulator -avd Nexus7_API30_ARM
~~~


详细报错：

~~~
[140276254512960]:ERROR:android/android-emu/android/qt/qt_setup.cpp:28:Qt library not found at ../emulator/lib64/qt/lib
Could not launch '/home/wi/../emulator/qemu/linux-x86_64/qemu-system-aarch64': No such file or directory
~~~

解决方法：

可能使用的 `emulator` 不对，应该使用 `SDK-HOME/emulator` 目录下的 ，而不是 `tools` 目录下的。








































































