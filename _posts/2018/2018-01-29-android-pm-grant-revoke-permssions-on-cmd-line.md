---
layout: post
title: 通过命令行调整 android app 的 权限 / grant or remoke permission
categories: [ dev, android ]
tags: [ android, adb ]
---

* Github - TilesOrganization/support - How to use ADB to grant permissions
  * <https://github.com/TilesOrganization/support/wiki/How-to-use-ADB-to-grant-permissions>
* 官方文档 - Android Debug Bridge (adb) - Call package manager (pm)
  * <https://developer.android.com/studio/command-line/adb.html#pm>



## 检查 app permissions

~~~ shell
adb shell dumpsys package com.rascarlo.quick.settings.tiles
~~~



## 赋权 grant permission

`adb shell pm grant package_name permission`

Grant a permission to an app. On devices running Android 6.0 (API level 23) and higher, the permission can be any permission declared in the app manifest. On devices running Android 5.1 (API level 22) and lower, must be an optional permission defined by the app.

### 例子

Grant WRITE_SECURE_SETTINGS permission

~~~ shell
adb shell pm grant com.rascarlo.quick.settings.tiles android.permission.WRITE_SECURE_SETTINGS
~~~

Grant DUMP permission

~~~ shell
adb shell pm grant com.rascarlo.quick.settings.tiles android.permission.DUMP
~~~




## 收回权限 revoke permisson

`revoke package_name permission`

Revoke a permission from an app. On devices running Android 6.0 (API level 23) and higher, the permission can be any permission declared in the app manifest. On devices running Android 5.1 (API level 22) and lower, must be an optional permission defined by the app.


### 例子

~~~
adb shell pm revoke com.name.app android.permission.READ_PROFILE
~~~



## 复原app初始权限

~~~
adb shell pm reset-permissions your.package.name
~~~


## 其他方法

grant your app all of the permissions it requires from the command line

~~~ shell
aapt d permissions ./path/to/your.apk \
  | sed -n \
    -e "s/'//g" \
    -e "/^uses-permission: name=android.permission\./s/^[^=]*=//p" \
  | xargs -n 1 adb shell pm grant com.your.package
~~~







## 其他 permission 相关命令



### 查看 permission groups 的信息

#### 列出所有group

~~~
adb shell pm list permission-groups
~~~

#### 列出某个group信息

~~~
adb shell pm list permissions [options] group

Prints all known permissions, optionally only those in group.

Options:

-g: Organize by group.
-f: Print all information.
-s: Short summary.
-d: Only list dangerous permissions.
-u: List only the permissions users will see.
~~~


~~~
>> ./adb shell pm list permissions -d -g
[...]
group:android.permission-group.CAMERA
  permission:android.permission.CAMERA
[...]
~~~





### set-permission-enforced

`set-permission-enforced permission [true | false]`

Specifies whether the given permission should be enforced.



