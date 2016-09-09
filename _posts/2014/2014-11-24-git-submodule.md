---
layout: post
title: git submodule
categories: [cm, git]
tags: [cm, git]
---

## 新增 submodule

```
git submodule add
git submodule add git@github.com:yashiro1899/wheat.git node_modules/wheat
git submodule add git://github.com/majutsushi/tagbar.git .vim/bundle/tagbar
```

## pull submodule

```
git submodule foreach
git submodule foreach --recursive git pull origin master
```

或者，到submodule各自的目录下一个一个执行 git pull

每个submodule pull之后，parent project中的引用commit id也是需要更新的，parent project也要add 和 commit一次。
---
git submodule update --remote

Git will go into your submodules and fetch and update for you.

$ git submodule update --remote DbConnector
以上命令默认认为checkout master branch，如果要该branch，在.gitmodules里边修改，然后再update:

$ git config -f .gitmodules submodule.DbConnector.branch stable     加 -f .gitmodules 将对所有人有效，否则只在本地有效。
$ git submodule update --remote

还可以带上rebase或者merge参数：
git submodule update --remote --rebase
git submodule update --remote --merge

## push submodules

$ git push --recurse-submodules=check

--recurse-submodules 可以赋值 check 或者 on-demand，check和on-demand具体区别我也不太清楚。。。。
on-demand是先push submodule的，最后push parent project。

## clone submodule

### clone 時把 submodule 一起抓下來

```
git clone --recursive
或
git clone --recursive git@github.com:yashiro1899/icecube.git
```

### 单独 clone submodule

如果已經抓下來才發現 submodule 是空的，可以用以下指令去抓，init 會在 _.git/config 下註冊 remote repo 的 URL 和 local path：

```
git submodule init
git submodule update --recursive
```

或是合併成一行

```
git submodule update --init --recursive 也可以
```

如果 upstream 有人改過 .gitmodules，那 local 端好像也是用這個方法 update。




## 刪除 submodule

想删除 submodule，貌似 git 没给出便捷的指令啊，只能手动来了：

```
$ git rm --cached node_modules/wheat && rm -rf node_modules/wheat/
```

同时修改 .gitmodules，把不用的 submodule 刪掉

還沒完喔！還要修改 .git/config 的內容，跟 .gitmodules 一樣，把需要移除的 submodule 刪掉，最後再 commit。



## submodule 的 remote URL 有變動

git submodule sync：如果 submodule 的 remote URL 有變動，可以在 .gitmodules 修正 URL，然後執行這個指令，便會將 submodule 的 remote URL 更正。



## 查看有哪些submodule

```
git submodule
```

## 查看submodule的log

```
git log -p --submodule
```


## Useful Aliases

```
$ git config alias.sdiff '!'"git diff && git submodule foreach 'git diff'"
$ git config alias.spush 'push --recurse-submodules=on-demand'
$ git config alias.supdate 'submodule update --remote --merge'
```


## 参考

* <http://www.git-scm.com/book/en/v2/Git-Tools-Submodules>
* <http://www.kafeitu.me/git/2012/03/27/git-submodule.html>
* <http://ju.outofmemory.cn/entry/44286>
* <http://blog.chh.tw/posts/git-submodule/>