---
layout: post
title: 上传git项目到gerrit
categories: [cm, git]
tags: [cm, git, gerrit]
---

### 创建项目，创建时不要选择“Create initial empty commit”

### 在本地git目录，设置remote

例如：

git remote add origin ssh://user-acount@localhost:29418/the-project-name

创建完成，可以使用 git remote -v 查看是否成功。

可以从.git/config查看，多了如下内容：

```
[remote "origin"]
        url = ssh://speedio@192.168.251.72:29418/builtin.v7bc
        fetch = +refs/heads/*:refs/remotes/origin/*
```

### 上传项目到gerrit

```
git push master
```

### 创建track关系

上传之后本地的master和origin/master实际还未有track关系，所以创建track关系：

```
git branch --set-upstream master origin/master
```

可以从.git/config查看，多了如下内容：

```
[branch "master"]
        remote = origin
        merge = refs/heads/master
```

### 最后，可以执行下git pull看看：

```
$ git pull
Already up-to-date.
```

参考：
http://stackoverflow.com/a/2286030/3316529


