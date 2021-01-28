---
layout: post
title: 在Android使用aapt工具查看app信息
categories: [cm, android]
tags: [termux, ssh, aapt]
---

* 参考： 
  * [stackoverflow.com - Get Application Name/ Label via ADB Shell or Terminal](https://stackoverflow.com/a/38799204)
  * [Easily Build Android APKs on Device in Termux](https://sdrausty.github.io/docsBuildAPKs/)




1. 找出包名对应的基础包地址，如下例子，就是`/data/app/com.google.android.apps.inbox-1/base.apk`
    ~~~
    $  adb shell pm list packages -f com.google.android.apps.inbox
    package:/data/app/com.google.android.apps.inbox-1/base.apk=com.google.android.apps.inbox
    ~~~

1. termux上安装 aapt
    ~~~
    apt install aapt
    ~~~
    装完，可执行文件在： `/data/data/com.termux/files/usr/bin/aapt`

1. 执行 `adb shell aapt dump badging <apk-location>`
    termux 中 或 电脑ssh脸上termux 执行都可以，ssh在电脑操作更方便写
    `aapt dump badging` 可以看到 application-label（app的显示名称） versionCode, versionName, sdkversion
    ~~~
    $  aapt dump badging /data/app/com.google.android.apps.inbox-1/base.apk
    ...
    application-label:'Inbox'
    application-label-hi:'Inbox'
    application-label-ru:'Inbox'
    ...
    ~~~









