---
layout: post
title: Cygwin：中文字符显示乱码的问题汇总
categories: [cm, cygwin]
tags: [cm, cygwin, git]
---

* 问题

git status 命令中文显示乱码

* 解决方法

执行git 命令：

```
git config --global core.quotepath false
```
