---
layout: post
title: 使用 find -depth -maxdepth -mindepth 命令列出一定层级范围的文件夹或文件
categories: [cm, linux]
tags: [linux, find]
---


* 参考：
  * <https://stackoverflow.com/a/4509648>

~~~
find . -maxdepth 1 -type d -exec ls -ld "{}" \;
~~~

~~~
find . -maxdepth 2 -mindepth 2
~~~





