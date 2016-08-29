---
layout: post
title: hardware acceleration on Android 硬件加速
categories: [android, dev]
tags: [android]
---

参考： <http://developer.android.com/guide/topics/graphics/hardware-accel.html>

* mainfest 中 \<application\> 的 android:hardwareAccelerated=["true" \| "false"] 属性来设置。
* 从Android 3.0 (API level 11)开始支持。
* Hardware acceleration is enabled by default if your Target API level is >=14
* 可以针对不同层级 打开（或关闭）硬件加速，针对Application、Activity、View、Window。



## 打开 hardwareAccelerated = true 影响：

* 会往app进程中加载 OpenGL drivers，消耗 2M～8M。
  * meaning that all drawing operations that are performed on a View's canvas use the GPU。
  * 硬件加速并不是支持所有2D绘图操作，所以某些自定义的view可能会出问题。
    * 哪些不支持，可参见：<http://developer.android.com/guide/topics/graphics/hardware-accel.html#drawing-support>





