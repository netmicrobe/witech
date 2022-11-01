---
layout: post
title: 关闭office upload center 上载中心
categories: [ cm, windows ]
tags: []
---

* 参考：
  * <http://www.liangshunet.com/ca/201306/645476639.htm>
  * []()
  * []()
  * []()


### 问题现象

windows 10 右下角状态栏突然出现 office上载中心。

### 解决

1. 任务管理器，关闭进程 `MSOUC.EXE`、 `MSOSYNC.EXE`
1. 计划任务，删除或禁用【Microsoft】 【Office】【Office 15 Subscription Heartbeat】
1. 在开机自启动中禁止 MSOSYNC.EXE
    1. 任务管理器 》 启动 选项页
    2. 禁止 上载中心 启动
