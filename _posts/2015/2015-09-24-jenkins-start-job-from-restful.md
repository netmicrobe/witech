---
layout: post
title: jenkins 远程控制job启动
description: 
categories: [cm, jenkins]
tags: [cm, jenkins]
---


## 远程启动job

示例：立即启动 statsvn2db 这个job

http://<your-host>/jenkins/job/statsvn2db/build?delay=0sec

示例：延迟 30 秒，启动指定job

http://<your-host>/jenkins/job/statsvn2db/build?delay=30sec

等价： http://<your-host>/jenkins/job/statsvn2db/build?delay=30


## 远程启动带参数的job

http://server/job/myjob/buildWithParameters?PARAMETER=Value

例如：    http://server/job/myjob/buildWithParameters?token=TOKEN&PARAMETER=Value

参考：<https://wiki.jenkins-ci.org/display/JENKINS/Parameterized+Build>

## 远程调用帮助

所在job后面添加 /api 会显示相应的帮助，例如：

http://<your-host>/jenkins/job/statsvn2db/api   显示statsvn2db 这个job相关的远程调用帮助文档










