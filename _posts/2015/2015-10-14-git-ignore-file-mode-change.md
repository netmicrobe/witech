---
layout: post
title: 让git忽略掉文件权限检查
categories: [cm, git]
tags: [cm, git]
---


有时 git diff 执行显示文件内容没变化，但是有 old mode xxx new mode

原因是文件的权限，被chmod变化了，这种变化也被 diff 识别出来了

让git忽略掉文件权限检查： 

```
git config core.fileMode false
```

参考：http://www.cnblogs.com/flyme/archive/2011/10/27/2226729.html
