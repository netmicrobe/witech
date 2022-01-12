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
Ctrl + Down | 音量下* d613b10 (HEAD, origin/textpaste) Add a new method for text injection
* cc4e1e2 Add more convenience methods for injection
* 4bbabfb Move injection methods to Device
* ffc5751 Avoid clipboard synchronization loop

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


### 在 Manjaro 上编译

Manjaro 21.1.0 Pahvo

~~~bash
# install dependencies
yay -S meson ffmpeg sdl2 gcc git pkgconf ninja jdk11-openjdk

# config
export ANDROID_SDK_ROOT=~/Android/Sdk
meson x --buildtype release --strip -Db_lto=true

# build
ninja -Cx  # DO NOT RUN AS ROOT

# Install
sudo ninja -Cx install    # without sudo on Windows
~~~

~~~bash
scrcpy --version

scrcpy 1.13

dependencies:
 - SDL 2.0.16
 - libavcodec 58.134.100
 - libavformat 58.76.100
 - libavutil 56.70.100
~~~

~~~bash
# Uninstall
sudo ninja -Cx uninstall  # without sudo on Windows
~~~


#### 在 Manjaro 上交叉编译 Windows上的版本

1. 安装编译工具
    ~~~bash
    yay -S mingw-w64-binutils mingw-w64-headers mingw-w64-gcc mingw-w64-tools
    ~~~

1. 安装依赖包

    ~~~bash
    # 安装过程会不断出现下载失败，解决方法如下
    yay -S mingw-w64-sdl2 mingw-w64-ffmpeg 

    # mingw-w64-make mingw-w64-pkg-config mingw-w64-meson
    ~~~

    * 下载失败的解决办法

        * 报错示例

            ~~~
            curl: (56) OpenSSL SSL_read: Connection reset by peer, errno 104
            ==> ERROR: Failure while downloading https://static.rust-lang.org/dist/2021-07-29/rust-std-1.54.0-x86_64-unknown-linux-gnu.tar.xz
                Aborting...
            error downloading sources: mingw-w64-rust
            ~~~

        * 解决办法

            1. 按照报错提示，使用迅雷下载对应的包
            1. 在 `~/.cache/yay` 搜索对应的包（没下载完全，一般有个 part 后缀），用下载的包覆盖到对应目录
            1. 在继续执行 `yay -S mingw-w64-sdl2 mingw-w64-ffmpeg`


            列一些依赖包的下载链接：
            
            * <https://static.rust-lang.org/dist/rustc-1.55.0-src.tar.xz>
            * <https://ftp.openbsd.org/pub/OpenBSD/distfiles/rust/rustc-1.55.0-src.tar.xz>
            * <https://static.rust-lang.org/dist/2021-07-29/rust-std-1.54.0-x86_64-unknown-* linux-gnu.tar.xz>
            * <https://static.rust-lang.org/dist/2021-07-29/rustc-1.54.0-x86_64-unknown-linux-gnu.tar.xz>

~~~
curl: (7) Failed to connect to cmocka.org port 443 after 594 ms: Connection refused
==> ERROR: Failure while downloading https://cmocka.org/files/1.1/cmocka-1.1.5.tar.xz
    Aborting...
error downloading sources: mingw-w64-cmocka
~~~

            
1. 生成windows执行文件

    ~~~
    ./release.sh
    ~~~




##### 报错： `gpg: keyserver receive failed`

* 现象

~~~
:: PGP keys need importing:
 -> 0E51E7F06EF719FBD072782A5F56E5AFA63CCD33, required by: mingw-w64-icu
==> Import? [Y/n] 
:: Importing keys with gpg...
gpg: keyserver receive failed: No data
problem importing keys
~~~

* 解决方法

~~~
wget https://raw.githubusercontent.com/unicode-org/icu/master/KEYS
gpg --import KEYS
~~~

* 参考： <https://aur.archlinux.org/packages/mingw-w64-icu/#comment-758487>









## 支持中文输入

* 参考
  * [zhihu.com - 阅读源码，分析并解决scrcpy无法正常输入中文的问题](https://zhuanlan.zhihu.com/p/149014163)
  * <https://github.com/Genymobile/scrcpy/tree/d613b10efcdf0d1cf76e30871e136ba0ff444e6e>
  * [Genymobile/scrcpy - Inject UTF-8 text #1426](https://github.com/Genymobile/scrcpy/pull/1426)
  * [Genymobile/scrcpy - Build scrcpy](https://github.com/Genymobile/scrcpy/blob/master/BUILD.md)
  * []()

1. 下载对应支持Unicode输入的源码
    对应的分支：`origin/textpaste`   `d613b10efcdf0d1cf76e30871e136ba0ff444e6e`
    
    ~~~bash
    https://github.com/Genymobile/scrcpy.git
    git co d613b10efcdf0d1cf76e30871e136ba0ff444e6e
    ~~~
1. 编译安装
1. 如果输入中文时出现: 字母也被输入的情况，启动时携带 `--prefer-text`
    1. 我在Manjaro 21.1 上使用 fcitx ，不用 `--prefer-text` 参数也能正常输入中文。




~~~bash
* d613b10 (HEAD, origin/textpaste) Add a new method for text injection
* cc4e1e2 Add more convenience methods for injection
* 4bbabfb Move injection methods to Device            # 从这里都在主线
* ffc5751 Avoid clipboard synchronization loop
~~~



## 屏幕隐私，设置快捷键，一键隐藏scrcpy窗口

1. 创建shell文件 `mini-scrcpy.sh`，并将执行路径配置到PATH中
    ~~~
    #!/bin/bash
    WID_V=$(xdotool search --onlyvisible --class "scrcpy")
    WID=$(xdotool search --class "scrcpy")

    echo "V: $WID_V"
    echo "WID: $WID"

    if [[ -z $WID_V && -n $WID ]]; then
      # already minimized, raise up it
      echo 'already minimized, raise up it'
      xdotool windowactivate $WID
    elif [[ -n $WID_V && -n $WID ]]; then
      # minimize it!
      echo 'minimize it!'
      xdotool windowminimize $WID
    fi
    ~~~
1. 并将`mini-scrcpy.sh`执行路径配置到PATH中
    修改 .bashrc
    ~~~
    export PATH="$PATH:/your-scrpt-path"
    ~~~
1. 设置快捷键
    * manjaro xfce4 上设置快捷键
        1. 在开始菜单输入 `keyboard` 启动 Keyboard 设置程序
        1. Application Shortcuts 添加快捷键，对应命令为 `/your-scrpt-path/mini-scrcpy.sh`
    * 在 KDE 上设置快捷键
        1. 开始菜单 》shortcuts 》Custom Shortcuts 》Edit 》 New 》 Global Shortcut 》 Command/URL
        1. 选择sh文件地址
        1. Apply



