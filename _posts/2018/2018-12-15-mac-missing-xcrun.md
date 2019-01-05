---
layout: post
title: High Sierra (10.13) 升级到 Mojave(10.14)执行命令报错 missing xcrun
categories: [ cm, mac-os ]
tags: []
---

* 参考
  * [MAC 10.11 命令行报错，如何修复](https://www.v2ex.com/t/217534)




### 现象

High Sierra (10.13) 升级到 Mojave(10.14)执行命令 git 报错 missing xcrun

~~~
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools ), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
~~~

### 解决

~~~
xcode-select --install
~~~

