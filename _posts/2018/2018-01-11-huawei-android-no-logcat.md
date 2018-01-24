---
layout: post
title: 部分华为手机不显示logcat问题原因是手机底层开关没打开
categories: [ cm, android ]
tags: [ android, gradle ]
---

* 参考： 
  * <http://itindex.net/detail/50026-%E5%8D%8E%E4%B8%BA-%E6%89%8B%E6%9C%BA-logcat>

1）进入工程模式

   有两种方式可以进入工程模式：
     a. 在拨号界面输入`*#*#2846579#*#*`
     b. 若是小米4.0系统(MIUI)，进入“设置-->全部设置-->原厂设置-->工程模式”


2) 打开Log

    1. 依次进入“后台设置--\>2.LOG设置--\>LOG开关”，选择“LOG打开”；返回上一个界面，点击“LOG级别设置”，选择“VREBOSE”

    2. 返回到图1所示二面，选择“6. Dump & Log”,打开开关“打开Dump & Log”


3) 重启手机

