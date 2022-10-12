---
layout: post
title: virtualbox6进行屏幕录制.md，关联 
categories: [ cm ]
tags: []
---

* 参考
  * []()
  * []()

测试环境：
Virtualbox 6.1.38
Qt5.15


1. 设置虚拟机
1. Settings \> Display \> Recording \> 勾选 Enable Recording
    * Recording Mode: Video/Audio
    * File Path: 保存录屏文件的地方，格式为 webm
    * Frame Size: 1600x900
        1080p显示器，全屏显示virtualbox窗口，1600x900 的分辨率差不多占用大部分屏幕了。
        如果选择一个很小的分辨率，如， 1024x768, 而虚拟机显示窗口实际比这个分辨率要大，那么录制的视频，只是屏幕中央 1024x768 的一块图像。
    * Screen: 勾选 Screen2
        使用双屏幕，把要录制的窗口，放到第二屏，从而在第一屏能正常干其他事情。
1. 启动虚拟机
    系统启动时，默认就开始录制，会导致很卡，先从菜单命令关闭： View \> Recording
1. 将要录制内容移到第二屏，开始录制 View \> Recording
1. 关闭录制，也是同样的菜单项 View \> Recording。

* 问题：

1. 录制的时候，虚拟机变卡。
    CPU 配置： 4 CPU    i9-7940x 3.1G 默频
1. 录制视频中的音频也明显卡顿。
    * Audio 的 设置
        Host Audio Driver: PulseAudio
        Audio Controller: Intel HD Audio
        Extended Feature: 勾选 Enable Audio Output ； 勾选 Enable Audio Input

以上问题可能是虚拟机性能不足导致，也可能是virtualbox本身问题，后面可以试一下 OBS Studio 软件。





