---
layout: post
title: 无法向gerrit上push annotated tag，remote rejected
categories: [cm, git]
tags: [cm, git, gerrit]
---

无法向gerrit上push annotated tag，报告如下错误

```
 ! [remote rejected] qalink_v2.1.0_rc1 -> qalink_v2.1.0_rc1 (prohibited by Gerrit)
```

* 原因

是因为用户权限不够。

* 解决 - 1

将tag签名，然后在上传


* 解决 - 2
 
修改 access 权限：添加 

Reference: refs/tags/*

添加 权限：Push Annotated Tag

