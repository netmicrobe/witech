---
layout: post
title: logcat 命令行，过滤日志的方法
categories: [android, cm]
tags: [android, logcat]
---

## 根据 Tag过滤

* `adb logcat -s tag-name`
* 多个tag用逗号隔开

~~~ shell
adb logcat -s "DEBUG", "InputDispatcher"
~~~



## 根据 严重级别过滤

~~~ shell
# error 级别的log
adb logcat *:E
~~~












