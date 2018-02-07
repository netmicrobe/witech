---
layout: post
title: Windows 启动管理器
categories: [cm, windows]
tags: [boot]
---

* 参考：
  * <https://answers.microsoft.com/zh-hans/windows/forum/windows_10-windows_install/win10%e4%b8%8ewin7%e5%90%af%e5%8a%a8%e7%ae%a1/f0436065-45e9-46db-98eb-8c0f02771c9a>
  * <http://itbbs.pconline.com.cn/notebook/13403067.html>
  * <https://www.jianshu.com/p/c6e7ca1e0250>


### 删除无用的启动项

1. `bcdedit /enum`
~~~
Windows 启动加载器
-------------------
标识符                  {current}
device                  boot
path                    \Windows\system32\winload.exe
description             Windows 10 Pro x64
locale                  zh-CN
loadoptions             DDISABLE_INTEGRITY_CHECKS
inherit                 {bootloadersettings}
nointegritychecks       Yes
osdevice                boot
systemroot              \Windows
resumeobject            {16e6c2b2-6e6c-11e6-ba96-f9b46bba3310}
nx                      OptIn

实模式启动扇区
---------------------
标识符                  {d0fc0861-43c3-11e6-8d12-9c2a70d0a2c4}
device                  partition=C:
path                    \NST\nst_linux.mbr
description             Ubuntu(用不了)
~~~

2. 找到那个要删除的项目 id，删除之

~~~
bcdedit /delete {d0fc0861-43c3-11e6-8d12-9c2a70d0a2c4}
~~~





### 重建系统引导文件

1. 命令提示符（管理员）
2. `bcdboot %windir% /l zh-cn`











































  
  