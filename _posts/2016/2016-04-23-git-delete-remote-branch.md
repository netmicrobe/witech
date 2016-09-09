---
layout: post
title: 删除远程分支
categories: [cm, git]
tags: [cm, git]
---

有时候，remote 库的分支被删除，本地还有跟踪分支，例如，origin/some-dev

使用如下命令删除：

git branch -dr origin/some-dev
