---
layout: post
title: 设置git的 diff tool
categories: [cm, git]
tags: [cm, git, diff]
---

## Windows 下配置 WinMerge 作为 diff tool

### 下载安装winmerge（开源）

### 创建一个包装脚本，git_diff.sh，设置模式为可执行

```
#!/bin/sh
LEFT=`cygpath -d ${1}`
RIGHT=`cygpath -d ${2}`
echo Launching WinMergeU.exe: $LEFT $RIGHT
/cygdrive/e/Program/WinMerge/WinMergeU.exe -e -ub "$LEFT" "$RIGHT"
```

### 告诉git用这个脚本来调用difftool

```
git config --global diff.tool winmerge
git config --global difftool.winmerge.cmd '/cygdrive/e/Program/WinMerge/git_diff.sh "$LOCAL" "$REMOTE"'
git config --global difftool.prompt false
```

### difftool.prompt 默认为true，每次就问：是不是启动，够烦。



### 使用

例如：

```
git difftool HEAD^..HEAD
```





## Linux 下配置 vimdiff

* 参考： <https://stackoverflow.com/a/3713865>

vimdiff 是vim带的一个diff

~~~ shell
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
~~~













