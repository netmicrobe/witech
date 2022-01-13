---
layout: post
title: linux ： 文件夹下的所有文件按时间顺序排列
categories: [cm, linux]
tags: [linux, find]
---

* 参考：
  * <http://stackoverflow.com/questions/5566310/how-to-recursively-find-and-list-the-latest-modified-files-in-a-directory-with-s>

## 方法 一

~~~ shell
find . -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head
~~~

或者

~~~ shell
find $1 -type f | xargs stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head
~~~

~~~
stat --printf="%y %n\n" $(ls -tr $(find * -type f))
~~~

Updated: If there are spaces in filenames, you can use this modification

~~~
OFS="$IFS";IFS=$'\n';stat --printf="%y %n\n" $(ls -tr $(find . -type f));IFS="$OFS";
~~~

## 方法二 

~~~bash
# 顺序
ls -tl

# 逆序
ls -trl
~~~









