---
layout: post
title: git remote, push, pull
categories: [cm, git]
tags: [cm, git]
---

## git remote

git remote -v     显示当前remote版本库配置
git remote add new-remote git:///path/to/your/repo.git    添加remote库引用
git branch -r    显示所有remote分支
git remote set-url new-remote git:///path/to/your/new-repo.git 更新远程库地址
git remote set-url --push new-remote git:///path/to/your/new-repo.git 只改push地址
git remote rename myremote my-new-remote  远程库引用改名
git remote update    fetch所有注册了的远程库
git remote rm new-remote   删除远程库引用




## git push

git push <remote>
只会推送remote上有的branch，默认是对应的同名branch。
默认不会将tag上传。

git push
默认remote是origin

git push <remote> <new-branch>
将本地新的branch推送到remote版本库。





## git pull & fetch

git pull <remote>
将remote上同名branch的更新拉取到本地，并merge。
默认会下载remote上的tag。

git pull
省略remote，默认是origin

git pull --rebase
使用rebase而不是merge

可以设置branch默认rebase
git config branch.<branch-name>.rebase true
设置之后在<branch-name>在与远程branch合并时，采用rebase，而非merge

git config branch.autosetuprebase true
本地跟踪分支创建时，自动设置branch.<branch-name>.rebase为true。





## 不获取远程库的tag

fetch时不获取remote上的tag

```
git fetch --no-tags file:///path/to/repos/hello-world.git \
    refs/head/*:refs/remotes/hello-world/*
```

--no-tags 可以简写成 -n

注册远程库的时候也可以指明不要download tags

```
git remote add --no-tags hello-world \
    file:///path/to/repos/hello-world.git
```












