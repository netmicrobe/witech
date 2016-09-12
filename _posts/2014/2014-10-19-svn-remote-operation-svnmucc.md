---
layout: post
title: 远程操作svn库， svnmucc
categories: [cm, subversion]
tags: [cm, subversion, svnmucc]
---


* 参考：
  * svn-book-html-chunk/svn.advanced.working-without-a-wc.html
  * svn-book-html-chunk/svn.ref.svnmucc.html

  
## svnmucc


虽然svn也能不用working copy操作库，但是每操作一次就要commit，svnmucc克服的这个问题，它的全称是：

Subversion Multiple URL Command Client

见下例：

```
$ svnmucc rm http://svn.example.com/projects/sandbox \
          mkdir http://svn.example.com/projects/sandbox \
          -m "Replace my old sandbox with a fresh new one."
r22 committed by harry at 2013-01-15T21:45:26.442865Z
```

从svn1.8开始，发布包包含svnmucc完善版本。

和svn不同，不在命令行制定log message，是不是弹出编辑器的，svnmucc会使用一个没啥意义的默认message。

### 安全的svnmucc put

使用-r参数可以进行安全的put。

如果-r指定的revision不是最新的revision，则提交报错。

```
$ svnmucc -r 14 put README.tmpfile \
          http://svn.example.com/projects/sandbox/README \
          -m "Tweak the README file."
svnmucc: E170004: Item '/sandbox/README' is out of date
```






