---
layout: post
title: jmeter 启动，命令行报错，注册表无法读取  Could not open or create prefs root node Software
description: 
categories: [cm, jmeter]
tags: [cm, jmeter]
---

参考 <http://blog.csdn.net/lihenair/article/details/18728879>

## 解决办法

* <http://stackoverflow.com/questions/20698493/jmeter-starts-with-warning-message>
* <http://www-01.ibm.com/support/docview.wss?uid=swg21496098>

### Problem(Abstract)

```
After running a clemb command under Windows 7 with Modeler 14.1 the following error is produced:

java.util.prefs.WindowsPreferences <init> 
WARNING: Could not open/create prefs root node Software\JavaSoft\Prefs 
at root 0x80000002. Windows RegCreateKeyEx(...) returned error code 5.
```

### Cause

The error occurs because java.util.prefs.WindowsPreferences is trying to save information in HKEY_LOCAL_MACHINE\Software\JavaSoft\Prefs instead of under HKEY_CURRENT_USER\Software\JavaSoft\Prefs.

java.util.prefs.WindowsPreferences需要保存信息到HKEY_LOCAL_MACHINE\Software\JavaSoft\Prefs而不是HKEY_CURRENT_USER\Software\JavaSoft\Prefs。

### Environment

Windows 7 64-bit

### Resolving the problem

The work around is to login as the administrator and create the key HKEY_LOCAL_MACHINE\Software\JavaSoft\Prefs.

以管理员身份登录，创建 HKEY_LOCAL_MACHINE\Software\JavaSoft\Prefs项

虽然Jmeter不会保存任何东西到该项，仍会将信息保存到HKEY_LOCAL_MACHINE\Software\JavaSoft\Prefs。
