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



## 根据包名过滤

~~~
adb logcat --pid=$(adb shell pidof -s pkg_name)

# 使用 ::-1 截掉pid末尾的\t制表符，cygwin有这个问题
adb logcat --pid=${`adb shell pidof -s pkg_name`::-1}
target-pid=$(adb shell pidof -s cn.egame.terminal.cloud5g);adb logcat --pid=${target-pid::-1}
~~~








