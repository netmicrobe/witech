---
layout: post
title: Android-10-读写 external storage 文件报错：open-failed-EACCES-Permission-denied，高版本工程Manifest要设置 android:requestLegacyExternalStorage="true"，才能兼容老代码
categories: [dev, android]
tags: []
---

* 参考： 
  * [Exception 'open failed: EACCES (Permission denied)' on Android](https://stackoverflow.com/questions/8854359/exception-open-failed-eacces-permission-denied-on-android)
  * [Android 10 open failed: EACCES (Permission denied)](https://medium.com/@sriramaripirala/android-10-open-failed-eacces-permission-denied-da8b630a89df)
  * [How to save file to external storage in Android 10 and Above](https://medium.com/@thuat26/how-to-save-file-to-external-storage-in-android-10-and-above-a644f9293df2)
  * [Access documents and other files from shared storage](https://developer.android.com/training/data-storage/shared/documents-files)
  * []()


## 现象

Android java代码中使用 File 和 FileOutputStream 打开文件，执行时报错：`open failed: EACCES (Permission denied)`

Manifest 里面定义了`READ_EXTERNAL_STORAGE` 和 `WRITE_EXTERNAL_STORAGE` 权限，运行时也require了permission

## 解决

Manafest 里面给 application 添加属性： `<application android:requestLegacyExternalStorage="true"`

