---
layout: post
title: redmine 中使用subversion 
categories: [cm, redmine]
tags: [cm, redmine, subversion]
---

## 管理员

1. 在server上安装合适版本的subversion客户端，参见：http://www.redmine.org/projects/redmine/wiki/RedmineRepositories

2. 在设置中开启特定scm

Administration->Settings->Repositories->Enabled SCM

## 使用者

在redmine comments中引用revision

r<revision-number> 

例如：

r6

提交后，会自动加上调整到revision 6的链接。