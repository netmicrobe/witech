---
layout: post
title: android监控GPU使用率
categories: [ cm, android ]
tags: [adb]
---

* 参考
  * [Android性能测试（内存、cpu、fps、流量、GPU、电量）——adb篇](https://www.jianshu.com/p/6c0cfc25b038)
  * []()
  * []()


## Simple System Monitor

* Simple System Monitor
  * com.dp.sysmonitor.app
  * 3.7.5


在 Play Store 下载 Simple System Monitor，可以开启悬浮窗看系统资源曲线，包括 GPU使用情况。

不过手机要 **root**


## adb 采集GPU占用率，Qualcomm Adreno系列

打印 GPU usage，在 骁龙835 / Adreno 540 的 root 手机上试过可以

~~~
adb shell su -c  "cat /sys/class/kgsl/kgsl-3d0/gpubusy" | awk '{print $1/$2}'
~~~

Gpu使用率获取：会得到两个值，（前一个/后一个）*100%=使用率

~~~
adb shell cat /sys/class/kgsl/kgsl-3d0/gpubusy
~~~

Gpu工作频率：

~~~
adb shell cat /sys/class/kgsl/kgsl-3d0/gpuclk
adb shell cat /sys/class/kgsl/kgsl-3d0/devfreq/cur_freq
~~~

Gpu最大、最小工作频率：

~~~
adb shell cat /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
adb shell cat /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
~~~

Gpu可用频率

~~~
adb shell cat /sys/class/kgsl/kgsl-3d0/gpu_available_frequencies
adb shell cat /sys/class/kgsl/kgsl-3d0/devfreq/available_frequencies
~~~

Gpu可用工作模式：

~~~
adb shell cat /sys/class/kgsl/kgsl-3d0/devfreq/available_governors
~~~

Gpu当前工作模式：

~~~
adb shell cat /sys/class/kgsl/kgsl-3d0/devfreq/governor
~~~



