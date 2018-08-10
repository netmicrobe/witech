---
layout: post
title: git rebase
categories: [cm, git]
tags: [git, rebase]
---

---

* 参考
  * <http://www.git-scm.com/book/en/Git-Branching-Rebasing>
  * <http://git-scm.com/book/mk/%D0%93%D1%80%D0%B0%D0%BD%D0%B5%D1%9A%D0%B5-%D1%81%D0%BE-Git-Rebasing>

---


## 利用 rebase 修改已经提交的 commit

~~~
* b8852b9 add volley support
* bc23a20 app global config
* d26bb5d IDEA 的 vcs 配置
* 16892cd blank project created by Android Studio Wizzard
~~~

修改 从`d26bb5d`开始的commit ： `git rebase -i d26bb5d^`

从第一个commit开始修改： `git rebase -i --root`



## 调整下工作branch，rebase到master上最新位置。

you’d do your work in a branch and then rebase your work onto origin/master when you were ready to submit your patches to the main project.
 
**git rebase master** 将当前checkout的branch与master找祖先，祖先和当前experiment branch HEAD之间的commit，replay到master上，也可以不用checkout experiment branch，直接运行 `git rebase master experiment`

```
$ git checkout experiment
$ git rebase master   
```

First, rewinding head to replay your work on top of it...
Applying: added staged command
 
下图是起始情况：
![](git_rebase_sample01_before.png)

下图是rebase后的情况：
![](git_rebase_sample01_after.png)





## 跨branch rebasing

server和client，2个branch找祖先，祖先到client-HEAD之间的commit，都后 replay 到master上。

```
git rebase --onto master server client
```

起始情况：

![](git_rebase_sample02_01.png)

执行 `git rebase --onto master server client` 之后：

![](git_rebase_sample02_02.png)


然后做个 ff merge，将client合并到master上：

~~~
git checkout master
git merge client
~~~

![](git_rebase_sample02_03.png)






