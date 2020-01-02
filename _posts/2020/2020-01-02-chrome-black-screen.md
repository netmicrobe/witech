---
layout: post
title: chrome 启动黑屏
categories: [cm, chrome]
tags: []
---

* 参考： 
  * [CSDN- 熊猫都爱吃 - chrome黑屏解决](https://blog.csdn.net/jjddrushi/article/details/79155421)
  * [知乎 - win10下谷歌浏览器黑屏问题？](https://www.zhihu.com/question/64447202/answer/816991260)
  * [关于部分AMD R5机器chrome或百分浏览器下黑屏花屏问题](http://www.centbrowser.cn/forum/forum.php?mod=viewthread&tid=4900)


### 问题现象

chrome启动后，chrome窗口一片漆黑啊，点右上角还可以关闭窗口。估计时图形渲染的问题。

### 测试环境

OS: Windows 10
CPU/GPU: Ryzen 3400g

### 解决办法

1. 方法一：“设置”中关闭“使用硬件加速模式”
    添加 “-disable-gpu” 参数启动chrome，
    进入“设置” -\> 高级 -\> 系统 -\> 关闭“用硬件加速模式”

2. 方法二：改变“Choose ANGLE graphics backend”的设置值
    1. 添加 “-disable-gpu” 参数启动chrome，
    1. 在chrome或者百分浏览器下地址栏输入“chrome://flags"
    1. 搜索“Choose ANGLE graphics backend”，在“Available” 和 “Unavailable” 选项页都翻一下
    1. 将“Default”改成“D3D11” 
        * 改成“OpenGL”缩放chrome窗口，内容显示有问题






