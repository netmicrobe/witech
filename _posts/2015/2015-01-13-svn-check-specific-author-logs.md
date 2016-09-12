---
layout: post
title: svn log 查看某个特定作者的提交 , specific author
categories: [cm, subversion]
tags: [cm, subversion]
---

```
svn log | sed -n '/USERNAME/,/-----$/ p' 
```

It will show you every commit made by the specified user (USERNAME).
