---
layout: post
title: android game testing / 游戏测试
categories: [ dev, game ]
tags: [ android, game ]
---



## 自动化测试

* Sikuli Script : <http://www.sikuli.org/>
  Sikuli automates anything you see on the screen. It uses image recognition to identify and control GUI components. It is useful when there is no easy access to a GUI's internal or source code.
* 网易 ATX : <https://github.com/NetEaseGame/ATX>
  ATX(AutomatorX) 是一款开源的自动化测试工具，支持测试iOS平台和Android平台的原生应用、游戏、Web应用。 使用Python来编写测试用例，混合使用图像识别，控件定位技术来完成游戏的自动化。附加专用的IDE来完成脚本的快速编写。
  * [testerhome - ATX专区](https://testerhome.com/topics/node78)


## 流畅度测试

* FPS Meter
  * 能通过悬浮的形式显示游戏实时帧数、最高帧数、最低帧数以及平均帧数（最近一分钟内）等信息，
  * 使用它需要手机获取Root权限
  * 使用FPS Meter需要在开发者选项中打开“停用HW叠加层”

* GameBench
  * <https://www.gamebench.net/>
  * 一款游戏“跑分”应用
  * 可以显示游戏的帧数曲线，CPU占用率以及内存占用，是一种功能较强大的帧数显示方法
  * 需要获取Root权限，下图是GameBench显示帧数曲线的截图
  * com.gamebench.metricscollector

* 易大师
  * 一款国产游戏跑分应用
  * 可以显示游戏的平均帧数，绘制一分钟内的帧数曲线，CPU占用率以及内存占用率。
  * 只能针对做过适配的游戏进行帧数测试
  * 不需要获取root权限

* Adreno Profiler
  * 高通的工具（当然也仅针对高通处理器的手机）
  * 需要手机连接电脑，然后通过adb读取到手机的实时帧数，绘制成曲线，同时可以把数据调出，
  * 使用Excel可以自行处理这些数据
  * 一款提供给开发者的软件，所以除了显示帧数它还有很多关于GPU的调试功能


### GameBench

#### 原理研究

参考：
* <https://stackoverflow.com/a/38981550/3316529>
* <https://chromium.googlesource.com/chromium/src/build/+/fefabac95d6aee4d941111e67f606dc50dfe9dd1/android/pylib/perf/surface_stats_collector.py#215>
* <https://android.googlesource.com/platform/frameworks/native/+/86efcc0/services/surfaceflinger/FrameTracker.cpp#217>
* [通过 dumpsys SurfaceFlinger 分析Android 系统图层](http://blog.csdn.net/haima1998/article/details/38060403)
* [adb shell dumpsys SurfaceFlinge 分析](http://blog.csdn.net/dddd0216/article/details/74978918)
* [Dumpsys SurfaceFlinger layer debugging](http://bamboopuppy.com/dumpsys-surfaceflinger-layer-debugging/)


(1) `adb shell dumpsys SurfaceFlinger --latency-clear`

(2) `adb shell dumpsys SurfaceFlinger --latency <window name>`


~~~
adb shell dumpsys SurfaceFlinger --latency com.android.settings/com.android.settings.SubSettings

RefreshPeriod <-- Time in nano seconds
desiredPresentTime actualPresentTime frameReadyTime <-- Time in nano seconds
desiredPresentTime actualPresentTime frameReadyTime
desiredPresentTime actualPresentTime frameReadyTime
...
~~~


































