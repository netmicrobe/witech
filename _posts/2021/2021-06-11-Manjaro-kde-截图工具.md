---
layout: post
title: Manjaro-kde-截图工具
categories: [cm, linux]
tags: [manjaro, kde, spectacle]
---

* 参考： 
    * [How do I set the hotkey Print to Rectangular Region in Spectacle?](https://askubuntu.com/questions/1079626/how-do-i-set-the-hotkey-print-to-rectangular-region-in-spectacle)
    * []()
    * []()
    * []()




## spectacle

KDE自带截图工具。

* 快捷键

`Meta + Shift + Print` 截图一块选定区域
`Meta + Print` 截图当前窗口
`PrintScreen` 截图整个屏幕，并呼出截图工具界面。
`Shift + Print` 截图整个桌面

* 快捷键配置： System Settings \> Shortcuts \> Spectacle


### 使用spectacle进行区域截图进剪贴板

* 参考： 
  * [reddit - Spectacle (save to clipboard in background mode)](https://www.reddit.com/r/kde/comments/f8seng/spectacle_save_to_clipboard_in_background_mode/fiow84z?utm_source=share&utm_medium=web2x&context=3)

默认没有这个快捷键需要自己创建。

1. 系统菜单搜索 custom Shortcuts 启动
1. 创建一个自定义的shortcut, 右键菜单 New \> Gloabl Shortcut \> Command/URL
    Trigger: Ctrl + Print
    Action: `spectacle -b -r -c`



