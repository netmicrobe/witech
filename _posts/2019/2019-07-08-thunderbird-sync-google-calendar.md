---
layout: post
title: 在 linux mint 19.1 tessa 上使用 ThunderBird 与 Google Calendar 同步
categories: [cm, linux]
tags: [mint, 日历]
---

* 参考： 
  * [How To Sync Google Calendar To The Linux desktop](https://www.addictivetips.com/ubuntu-linux-tips/sync-google-calendar-to-the-linux-desktop/)
  * [5个Linux最佳日历应用程序](http://mos86.com/57909.html)
  * [Best Linux Calendar App: Top 20 Reviewed for Linux Users](https://www.ubuntupit.com/best-linux-calendar-app-top-20-reviewed-for-linux-users/)


## Linux上的日历程序介绍

1. KOrganizer ： For KDE 
1. Evolution
1. ThunderBird 的插件 "Lightning" 和 "Provider for Google Calendar"
    * 支持与Google Canlendar 同步
1. GNOME Calendar
1. [California](https://wiki.gnome.org/Apps/California)
1. Google Calendar indicator
    * [How to Add Google Calendar Integration to Ubuntu](https://www.maketecheasier.com/add-google-calendar-integration-ubuntu/)
1. Orage
    * Xfce 上的Canlendar，很简洁，支持创建事件提醒。 


## ThunderBird 与 Google Canlendar 同步

1. 安装雷鸟： `sudo apt install thunderbird`，一般发行版都自带雷鸟
1. 下载插件 *.xpi 文件
    * [Lighting插件](https://addons.thunderbird.net/en-US/thunderbird/addon/lightning/)
    * [Provider for Google Calendar插件](https://addons.thunderbird.net/en-US/thunderbird/addon/provider-for-google-calendar/)

1. 设置 ThunderBird 代理： 菜单 Edit -\> Preference -\> Advanced -\> Network & Disc Space -\> Settings...

1. 打开ThunderBird，菜单 Tools -\> Add ons ，将 xpi 插件文件拖到窗口中进行安装。
1. 重启ThunderBird
1. 打开Calendar -\> 右键菜单 New Calendar... -\> On the Network -\> Google Calendar
1. "Locate your calendar"窗口输入 google 帐号，继续，打开窗口加载Google网页继续认证。







