---
layout: post
title: adb shell 关机命令
categories: [ dev, android ]
tags: [ adb, shell, shutdown, poweroff, reboot ]
---

* 参考
  * <https://android.stackexchange.com/questions/47989/how-can-i-shutdown-my-android-phone-using-an-adb-command>



## 需要 root 权限


### `reboot -p` 或者 `reboot --poweroff`

* 测试通过：
  * 三星 Note4（Android4.4）
* 测试不通过：


### `adb shell su -c 'am start -a android.intent.action.ACTION_REQUEST_SHUTDOWN --ez KEY_CONFIRM true --activity-clear-task'`

* 接近正常关机的方式

* 测试通过：
  * 三星 Note4（Android4.4）
* 测试不通过：


### `adb shell su -c 'svc power shutdown'`

* 接近正常关机的方式

* 测试通过：
  * 三星 Note4（Android4.4）
* 测试不通过：


### `su -c 'setprop sys.powerctl reboot,recovery'`

* replace reboot,recovery with `reboot` to reboot the device
* replace reboot,recovery with `shutdown` to shutdown the device
  * 关机很快

* 测试通过：
  * 三星 Note4（Android4.4）
* 测试不通过：



### `adb shell su -c 'am start -n android/com.android.internal.app.ShutdownActivity'`

* 测试通过：
* 测试不通过：
  * 三星 Note4（Android4.4）





















