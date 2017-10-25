---
layout: post
title: 使用 git alias (pushall) 将branch 向所有 remote push
categories: [cm, git]
tags: [git, push, alias]
---

* 参考
  * <https://stackoverflow.com/a/18674313>

创建个 pushall alias，命令前加感叹号 `!` 表示是shell 命令。

``` shell
git config --global alias.pushall '!git remote | xargs -L1 -I R git push R '
```

使用方法：

``` shell
# 将 master 分支push到所有remote
git pushall master
```









