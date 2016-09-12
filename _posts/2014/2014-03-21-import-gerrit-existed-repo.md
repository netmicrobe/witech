---
layout: post
title: 将已有的git库导入gerrit
categories: [cm, git]
tags: [cm, git, gerrit]
---

在 gerrit 创建一个新project，不要有 init commit。

添加gerrit库地址

```
git add gerrit-remote-name git://path/to/your.git
```

直接用对refs/heads/*有权限的帐号：

```
git push gerrit-remote-name master
```
