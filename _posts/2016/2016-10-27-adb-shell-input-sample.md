---
layout: post
title: 使用 adb shell input 发送用户事件的 bat 例子
categories: [android, cm, adb]
tags: [cm, android, adb]
---


```bat
@echo off

::adb devices

@echo 开始执行测试

set d=%date:~0,10%
set t=%time:~0,8%
set count=0
@echo 开始测试时间为： %d% %t%
@echo 开始测试时间为： %d% %t% >> .\meminfo_hanguo_miNote.log
@echo 内存使用信息 >> .\meminfo_hanguo_miNote.log　

:start

::echo 启动tv大厅
adb shell input tap 265 862
sleep 7

::第一个游戏
::@echo 点击了第一个游戏
adb shell input tap 246 293
sleep 3
REM 返回
adb shell input keyevent 4
sleep 3

::第二个游戏
::@echo 点击了第二个游戏
adb shell input tap 272 477
sleep 3
adb shell input keyevent 4
sleep 3

::第三个游戏
::@echo 点击了第三个游戏
adb shell input tap 272 651
sleep 3
adb shell input keyevent 4
sleep 3

::第四个游戏
::@echo 点击了第四个游戏
adb shell input tap 272 839
sleep 3
adb shell input keyevent 4
sleep 3

::第五个游戏
::@echo 点击了第五个游戏
adb shell input tap 272 1013
sleep 3
adb shell input keyevent 4
sleep 3

::第六个游戏
::@echo 点击了第六个游戏
adb shell input tap 272 1172
sleep 3
adb shell input keyevent 4
sleep 3
adb shell input keyevent 3

set /a count=count+1
echo 已经执行了第 %count% 次

@echo --------------------------------------------

adb shell dumpsys meminfo cn.egame.terminal.client4g >> .\meminfo_hanguo_miNote.log

@echo 已经执行了第 %count% 次 >> .\meminfo_hanguo_miNote.log

@echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: >> .\meminfo_hanguo_miNote.log

goto start
```
