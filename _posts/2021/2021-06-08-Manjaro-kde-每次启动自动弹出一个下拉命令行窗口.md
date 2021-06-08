---
layout: post
title: Manjaro-kde-每次启动自动弹出一个下拉命令行窗口
categories: [cm, linux]
tags: [manjaro, kde]
---

* 参考： 
    * []()
    * []()

1. 系统菜单 》Autostart
1. 删除里面的 `Yakuake` 条目

* autostart 条目存放在： `/$HOME/.config/autostart`

* `Yakuake` 条目其实是一个名为`org.kde.yakuake.desktop`的xdesktop文件

~~~
[Desktop Entry]
Name=Yakuake
GenericName=Drop-down Terminal
Exec=yakuake
Icon=yakuake
Type=Application
Terminal=false
Categories=Qt;KDE;System;TerminalEmulator;
Comment=A drop-down terminal emulator based on KDE Konsole technology.
X-DBUS-StartupType=Unique
X-KDE-StartupNotify=false
X-DBUS-ServiceName=org.kde.yakuake
~~~





