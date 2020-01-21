---
layout: post
title: 小米手机monkey测试失败，报错 SecurityException
categories: [cm, android]
tags: [monkey, testing]
---

* 参考： 
  * [Android 怎么获取 INJECT_EVENTS（小米手机）](https://blog.csdn.net/zhaoqi5705/article/details/53455597)
  * []()

* 问题：
  monkey SecurityException: Injecting to another application requires INJECT_EVENTS permission
  
  小米的Android有这个限制。

* 解决：
  设置 --》 更多设置 --》 开发者选项 --》USB调试（安全设置）







