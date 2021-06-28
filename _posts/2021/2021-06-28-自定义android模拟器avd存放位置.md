---
layout: post
title: 自定义android模拟器avd存放位置（ANDROID_AVD_HOME）
categories: [ cm, android ]
tags: [  ]
---

* 参考
  * [How can I change the path to android\avd in my Android Studio](https://newbedev.com/how-can-i-change-the-path-to-android-avd-in-my-android-studio)
  * []()
  * []()
  * []()
  * []()
  * []()
---

## 

1. 在需要的地方创建新的avd目录，例如，`/your-data-dir/avd`
1. 配置 `ANDROID_AVD_HOME` 全局变量
    * linux 上配置
        1. 在 `/etc/profile.d/` 下创建 `my-android-avd.sh`
        ~~~
        export ANDROID_AVD_HOME=/your-data-dir/avd
        ~~~
        1. 在Manjaro上，`kmenuedit` 创建的启动项目，可能不会读取新的全局变量设置，注销或者重启下试试。
    * windows 设置，直接到环境变量的地方进行配置就好





















































































