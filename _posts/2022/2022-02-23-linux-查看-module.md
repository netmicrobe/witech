---
layout: post
title: linux-查看-module，lsmod，modinfo
categories: [cm, linux]
tags: [mint, debian, ubuntu, apt]
---

* 参考： 
  * [Linux: Find out what kernel drivers (modules) are loaded](https://www.cyberciti.biz/faq/linux-show-the-status-of-modules-driver/)
  * [How to Load and Unload Kernel Modules in Linux](https://www.tecmint.com/load-and-unload-kernel-modules-in-linux/#:~:text=To%20list%20all%20currently%20loaded,%2Fproc%2Fmodules%20like%20this.)
  * []()


`lsmod` 列出加载的所有module

`modinfo {driver-name}` 显示漠哥特定module的信息

`insmod` 加载（插入）module，要给出全路径，例如，插入 speedstep-lib.ko 模块

~~~
insmod /lib/modules/4.4.0-21-generic/kernel/drivers/cpufreq/speedstep-lib.ko 
~~~

`rmmod` 删除 `insmod` 插入的 module

~~~
rmmod /lib/modules/4.4.0-21-generic/kernel/drivers/cpufreq/speedstep-lib.ko 
~~~

`modprobe` 更方便，不需要知道module全路径，可以加载module，也可以卸载。它从 `/lib/modules/$(uname -r)` 搜索模块信息和文件，前提是服从 `/etc/modprobe.d` 下的配置。

~~~bash
# 加载
modprobe speedstep-lib

# 卸载
modprobe -r speedstep-lib
~~~

`modprobe` 能够下划线自动转换，所以 module 名称里面 "-" 和 "_" 等效。























