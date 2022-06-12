---
layout: post
title: 删除远程分支
categories: [cm, git]
tags: [cm, git]
---

* 参考
  * [How to delete remote branches in Git](https://www.educative.io/edpresso/how-to-delete-remote-branches-in-git)


## 删除本地残留branch（remote上已经没有了）

有时候，remote 库的分支被删除，本地还有跟踪分支，例如，origin/some-dev

使用如下命令删除：

~~~sh
# 查看本地branch情况
git branch -a

# 删除残留branch
git branch -dr origin/some-dev
~~~

## 删除本地branch

~~~sh
git branch -d test
~~~


## 删除 remote branch

~~~sh
git push origin --delete test
# 或者，
git push <remote_name> :<branch_name>
~~~
