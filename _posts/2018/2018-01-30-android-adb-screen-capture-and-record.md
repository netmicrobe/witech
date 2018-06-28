---
layout: post
title: 使用 android adb命令 录像 screenrecord 和 截屏 screencap
date: 2018-01-30 11:35:18 +0800
categories: [ cm, android ]
tags: [ android ]
---


* 参考： 
  * <https://developer.android.com/studio/command-line/adb.html>



## 快速截屏&录屏的 Windows 脚本

### screencap.bat

* 用法：`screencap your-filename`
* 效果：命令执行目录生成截图文件：`your-filename.png`

~~~ bat
@echo off
adb shell screencap /sdcard/%1.png & adb pull /sdcard/%1.png . & adb shell rm -f /sdcard/%1.png
~~~

* 帮助

~~~ shell
shell@trltechn:/ $ screencap -h
screencap -h
usage: screencap [-hp] [-d display-id] [FILENAME]
   -h: this message
   -p: save the file as a png.
   -d: specify the display id to capture, default 0.
If FILENAME ends with .png it will be saved as a png.
If FILENAME is not given, the results will be printed to stdout.
~~~


### screenrecord.bat

* 用法：`screenrecord your-filename`
* 效果：命令执行目录生成截图文件：`your-filename.mp4`


~~~ bat
@echo off
adb shell screenrecord /sdcard/%1.mp4 & adb pull /sdcard/%1.mp4 . & adb shell rm -f /sdcard/%1.mp4
~~~





## 截屏

~~~
screencap filename
~~~

例如：

~~~
adb shell screencap /sdcard/screen.png
~~~

截屏并下载

~~~
$ adb shell
shell@ $ screencap /sdcard/screen.png
shell@ $ exit
$ adb pull /sdcard/screen.png
~~~




## 录像

~~~
screenrecord [options] filename
~~~

* 4.4 (API level 19) 及以上
* 保存成mp4文件
* 不会录音
* 有些设备不能录像，因为手机本身分辨率很高，用 `--size` 参数来调低分辨率试试
* 有些设备没有 screenrecord 程序，例如华为畅享6s

例子：

~~~
adb shell screenrecord /sdcard/demo.mp4
~~~

Control + C, 停止录像。
否则3分钟后自动停止。 `--time-limit` 参数可以设置录制时长。

录像并下载

~~~
$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4
~~~


### 参数说明

* `--help`                Displays command syntax and options
* `--size widthxheight`   Sets the video size: 1280x720. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder.
* `--bit-rate rate`       Sets the video bit rate for the video, in megabits per second. The default value is 4Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:
  ~~~
  screenrecord --bit-rate 6000000 /sdcard/demo.mp4
  ~~~
* `--time-limit time`     Sets the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes).
* `-rotate`               Rotates the output 90 degrees. This feature is experimental.
* `--verbose`             Displays log information on the command-line screen. If you do not set this option, the utility does not display any information while running



















