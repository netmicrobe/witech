---
layout: post
title: git status 执行很慢
categories: [cm, git]
tags: []
---

* 参考： 
  * [git status slow on exFAT with exfat-utils](https://renepasing.de/2018/11/26/git-status-slow-on-exfat-with-exfat-utils/)


repo 在 exfat 的u盘上，`git status` 慢的让人发指！！

自从进行了如下设置，神清气爽：

~~~
git config core.checkStat minimal
~~~

从 [git-config](https://git-scm.com/docs/git-config/2.8.2)引用的说明：

>**core.checkStat**
>Determines which stat fields to match between the index and work tree. The user can set this to default or minimal. Default (or explicitly default), is to check all fields, including the sub-second part of mtime and ctime.







