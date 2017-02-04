---
layout: post
title: adb 在 32位的 Ubuntu 上不能执行
categories: [android, cm, adt]
tags: [android, adb]
---

## 问题现象

android SDK Manager 下载的 Plaftform-tools(Rev. 25.0.3) ，adb 无法在 32位的 Ubuntu 上执行，报错：

```
bash: ./platform-tools/adb: cannot execute binary file: 可执行文件格式错误
```

## 分析

SDK Manager 下载的 platform-tools 是在 x64 上编译的，无法使用。

## 解决

下载 [platform-tools_r23.0.1-linux.zip](/wifiles/android/tools/platform-tools_r23.0.1-linux.zip)
包中是 32bit 的adb执行文件，用这些文件覆盖SDK的对应文件。


## 参考

[askubuntu.com - Android sdk on Ubuntu 32bit](http://askubuntu.com/questions/710426/android-sdk-on-ubuntu-32bit)
[Android Open Project, Issue 196866: 	Platform-tools 23.1.0 Linux changed to 64-bit without notice.](https://code.google.com/p/android/issues/detail?id=196866)
[cnblogs - lipeil ./adb: cannot execute binary file](http://www.cnblogs.com/lipeil/p/5442067.html)



