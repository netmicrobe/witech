---
layout: post
title: SVN 无法提交：log属性不接受非 LF 作为行结尾的提交注释
categories: [cm, subversion]
tags: [cm, subversion, linux]
---

## 现象

```
Error: svnmucc: E125005: Cannot accept non-LF line endings in 'svn:log' property
```

或者提示：

```
E125005: 不能接受属性 “svn:log” 的非 LF 行结束符
```

## 解决方法

-F参数指定的log文件，可能是windows换行方式cr+lf，转换成lf的unix换行方式，就好了。。。

windows下进一步解决，可能还是看下svn的设置，先这样了。。

