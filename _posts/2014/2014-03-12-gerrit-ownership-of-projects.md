---
layout: post
title: gerrit ： Ownership of the project
categories: [cm, git]
tags: [cm, git, gerrit]
---

gerrit默认有一个Project Owners的Group，这个组只是在定义全局权限定义时，指代具体项目的owner group。

根据官方文档：

Access rights assigned to this group are always evaluated within the context of a project to which the access rights apply.

如何设置某个project 的owner group呢？

enter some project > Access > Edit 配置权限

Add Permission... > Owner 在这里添加Owner Group！！(别忘提前创建好Group)

* 参考
  * <http://www.mediawiki.org/wiki/Gerrit/Project_ownership>
  * <http://review.cyanogenmod.org/Documentation/access-control.html#project_owners>

