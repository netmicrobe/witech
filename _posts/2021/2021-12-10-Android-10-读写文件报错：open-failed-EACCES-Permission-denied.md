---
layout: post
title: Android-10-读写 external storage 文件报错：open-failed-EACCES-Permission-denied，高版本工程Manifest要设置 android:requestLegacyExternalStorage="true"，才能兼容老代码
categories: [dev, android]
tags: []
---

* 参考： 
  * [Exception 'open failed: EACCES (Permission denied)' on Android](https://stackoverflow.com/questions/8854359/exception-open-failed-eacces-permission-denied-on-android)
  * []()


## 现象

Android java代码中使用 File 和 FileOutputStream 打开文件，执行时报错：`open failed: EACCES (Permission denied)`

Manifest 里面定义了`READ_EXTERNAL_STORAGE` 和 `WRITE_EXTERNAL_STORAGE` 权限，运行时也require了permission

## 解决

Manafest 里面给 application 添加属性： `<application android:requestLegacyExternalStorage="true"`

