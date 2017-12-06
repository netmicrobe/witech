---
layout: post
title: Linux：遍历文件夹，找到最近修改的文件
categories: [cm, linux]
tags: [linux, find]
---

~~~ shell
#!/bin/bash
find $1 -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head
~~~

或者

To find all files that file status was last changed N minutes ago:

~~~ shell
find -cmin -N
~~~

for example:

~~~ shell
find -cmin -5
~~~










