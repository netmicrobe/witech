---
layout: post
title: android-ui自动化测试之uiautomator.md
categories: [ testing, android ]
tags: [ uiautomator ]
---

* 参考：
  * 《腾讯Android自动化测试实战》
  * [uiobject 方式遍历list items](https://stackoverflow.com/a/35308116)
  * []()
  * []()





## UiAutomator


### 一般测试流程

1. 分析UI元素，获取元素属性
1. 开发测试代码，模拟用户操作。
1. 编译测试代码成jar，push到手机。
1. 在手机上运行测试，搜集测试结果。


### 获取元素信息的方法

1. 使用uiautomatorviewer工具

`./sdk/tools/bin/uiautomatorviewer`


### 开发

#### 创建 Project

创建Java Project（而不是Android Project），加入依赖： `android.jar`、`uiautomator.jar`， 2个jar都在 `./sdk/platforms/android-xx` 目录。
android-19 以上的新增 `UiSelector.resourceId` 系列方法，能通过resource id 定位元素。


#### 开发用例

* 每个用例都继承自 `UiAutomatorTestCase`
* `setUp()` 先于每个用例执行。进行用例执行的准备。
* `tearDown()` 后于每个用例执行。搜集用例结果，恢复环境。
* 一个 Class 可以包含多个用例 testXXX()，但不建议耦合、存在顺序依赖关系。
* 

#### 示例一：

~~~

~~~







































