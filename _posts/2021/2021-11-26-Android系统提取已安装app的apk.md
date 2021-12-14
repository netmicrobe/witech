---
layout: post
title: Android系统提取已安装app的apk
categories: [cm, android]
tags: [adb, android]
---

* 参考
  * [How to Extract APK File of Android App Without Root](https://beebom.com/how-extract-apk-android-app/)
  * []()
  * []()
  * []()
  * []()



~~~bash
adb shell pm list packages

adb shell pm path com.sdu.didi.psnger
package:/data/app/com.sdu.didi.psnger-zSCS03i2itPZSSnYvVXlig==/base.apk

adb pull /data/app/com.sdu.didi.psnger-zSCS03i2itPZSSnYvVXlig==/base.apk .
~~~
































