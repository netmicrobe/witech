---
layout: post
title: git-status-显示全路径
categories: [cm, git]
tags: []
---

* 参考： 
    * [How can I run “git status” and just get the filenames](https://stackoverflow.com/a/5238537)
    * []()



~~~
git status --porcelain

# 去掉修改标识
git status --porcelain | sed s/^...//
~~~


