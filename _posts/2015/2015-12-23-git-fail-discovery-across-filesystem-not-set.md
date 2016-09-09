---
layout: post
title: GIT_DISCOVERY_ACROSS_FILESYSTEM not set
categories: [cm, git]
tags: [cm, git]
---

在windows + cygwin 中，移动 git 项目的文件夹，有时候会提示 

error: opening .git/config: Permission denied


执行 chmod -R 777 .git ， 仍然提示 

fatal: Not a git repository (or any parent up to mount point /cygdrive/d)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

此时 执行 **git init** 重新初始化一下，就好了。


