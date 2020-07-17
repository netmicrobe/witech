---
layout: post
title: scrcpy 将 Android 手机屏幕实时投射到电脑
categories: [cm, android]
tags: [scrcpy, mint]
---

* 参考： 
  * [Github - Genymobile/scrcpy](https://github.com/Genymobile/scrcpy)
  * [Build scrcpy](https://github.com/Genymobile/scrcpy/blob/master/BUILD.md)


## 从软件库安装

### Linux

~~~
# ubuntu
apt install scrcpy

# arch aur
yay -S scrcpy
~~~




## 使用

1. 连上手机（打开“usb调试”）
2. 电脑运行 `scrcpy`，GUI启动，立即投射当前手机屏幕

### 多个手机同时连接

~~~
$ adb devices
List of devices attached
26b98700	device
c676c6b3	device

# 连接第1个手机
$ scrcpy -s 26b98700

# 连接第2个手机
$ scrcpy -s c676c6b3
~~~


### `scrcpy -h` 查看帮助。


### 拖动安装apk

从电脑拖动apk，就可以将apk安装到设备。

### 快捷键

Ctrl + b    | back键
Ctrl + h    | home键
Ctrl + s    | app switch
Ctrl + m    | menu键
Ctrl + Up   | 音量上
Ctrl + Down | 音量下
Ctrl + p    | 关机键(turn screen on/off)
Right-click | power on(when screen is off)
Ctrl+o      | turn device screen off (keep mirroring)
Ctrl+n      | expand notification panel
Ctrl+Shift+n| collapse notification panel
Ctrl+c      | copy device clipboard to computer
Ctrl+v      | paste computer clipboard to device
Ctrl+i      | enable/disable FPS counter (print frames/second in logs)





## trouble shooting

### 鼠标、键盘无效

可能需要在手机中设置： Developer options -\> 勾选 "USB debugging(Security settings)"

参考： <https://github.com/Genymobile/scrcpy/issues/70#issuecomment-373286323>









## 依赖包安装

~~~
# runtime dependencies
sudo apt install ffmpeg libsdl2-2.0-0

# client build dependencies
sudo apt install make gcc git pkg-config meson ninja-build \
                 libavcodec-dev libavformat-dev libavutil-dev \
                 libsdl2-dev

# server build dependencies
sudo apt install openjdk-8-jdk
~~~

On old versions (like Ubuntu 16.04), meson is too old. In that case, install it from pip3:

~~~
sudo apt install python3-pip

# 解决 ModuleNotFoundError: No module named 'setuptools' 报错
pip3 install --upgrade setuptools

# 解决 error: invalid command 'bdist_wheel' 报错
pip3 install --upgrade wheel

pip3 install --upgrade meson

# meson 的安装位置 /home/wi/.local/bin/meson
~~~

## 编译 scrcpy 服务器（电脑端）

~~~
export ANDROID_HOME=~/android/sdk

git clone https://github.com/Genymobile/scrcpy
cd scrcpy

# then, build
# Note: ninja must be run as a non-root user (only ninja install must be run as root).
meson x --buildtype release --strip -Db_lto=true
cd x
# 因为GFW，可能会编译失败，可以通过proxy联网： proxychains ninja
ninja

# 安装
sudo ninja install    # without sudo on Windows
~~~

This installs two files:

* /usr/local/bin/scrcpy
* /usr/local/share/scrcpy/scrcpy-server.jar


卸载

~~~
sudo ninja uninstall
~~~












































