---
layout: post
title: Gerrit 控制 project 的可见权限
categories: [cm, git]
tags: [cm, git, gerrit]
---


参考：<https://review.typo3.org/Documentation/access-control.html#project_owners>

默认 Gerrit 上 project 对所有人可见，默认 All-Projects > Access > Reference ref/* > Read 权限 Allow 给 Anonymous Users。

## 如何配置只有Project Owner 

All-Projects > Access > Reference ref/* > Read 权限 Allow 给 Project Owners。

在对应项目 Access 中创建 REference ref/* > Owners 权限 给对应的组。

* 注意：默认项目的Access 没有 ref/* ，都是 ref/head/* ， 动了 All-Projects 中的 Read 权限，而其他项目中还没 ref/* ，将会导致其他项目不可用！！



