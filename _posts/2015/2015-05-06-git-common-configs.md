---
layout: post
title: git 常用设置/config/配置
categories: [cm, git]
tags: [cm, git, config, alias]
---

## Windows 上的 git 配置

### 常用设置

```
git config --global user.name your-name
git config --global user.email your-email@some-site.com

git config --global alias.l "log --decorate --oneline --graph"
git config --global alias.ll "log --oneline --decorate --graph -10"
git config --global alias.st status
git config --global alias.d diff
git config --global alias.co checkout
git config --global alias.rv 'remote -v'
git config --global alias.pushall '!git remote | xargs -L1 -I R git push R '

git config --global core.quotepath false
git config --global core.autocrlf true
git config --global color.ui true
git config --global core.editor /cygdrive/d/noinstall/notepad_plusplus_git/npp.sh
git config --global core.filemode false
git config --global http.sslverify false
git config --global http.postbuffer 524288000

git config --global diff.tool winmerge
git config --global difftool.winmerge.cmd '/cygdrive/d/Program\(x86\)/WinMerge/git_diff.sh "$LOCAL" "$REMOTE"'
git config --global difftool.winmerge.prompt false
git config --global git_commit_template.txt
```

提高`git status` 执行速度：

~~~
git config core.checkStat minimal
~~~

### git_commit_template.txt

```
# [bugfix feature story task #] [ Subject: One line meaningful description for logs ]
# refs: #
```

### npp.sh

```shell
#!/bin/sh
#/cygdrive/e/notepad_plusplus/notepad++.exe -multiInst -noPlugin -nosession $*
/cygdrive/e/notepad_plusplus_git/notepad++.exe -multiInst -noPlugin -nosession "$(cygpath -w "$*")"
```

### git_diff.sh

```shell
#!/bin/sh
LEFT=`cygpath -d ${1}`
RIGHT=`cygpath -d ${2}`
echo Launching WinMergeU.exe: $LEFT $RIGHT
/cygdrive/e/Program/WinMerge/WinMergeU.exe -e -ub "$LEFT" "$RIGHT"
```

## Linux 下，设置

```
git config --global user.name your-name
git config --global user.email your-email@some-site.com

git config --global alias.l "log --decorate --oneline --graph"
git config --global alias.ll "log --oneline --decorate --graph -10"
git config --global alias.st status
git config --global alias.d diff
git config --global alias.co checkout
git config --global alias.pushall '!git remote | xargs -L1 -I R git push R '

git config --global core.autocrlf input
git config --global color.ui true
git config --global core.filemode false
git config --global http.sslverify false
git config --global http.postbuffer 524288000
```
