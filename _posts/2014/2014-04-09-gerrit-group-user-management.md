---
layout: post
title: gerrit 分组管理project
categories: [cm, git]
tags: [cm, git, gerrit]
---

## 权限继承和分组

```
ssh -p 29418 speedio@localhost gerrit create-project --permissions-only --description "'所有预置的项目'" your_parent_prj
```

\--permissions-only，相当于在页面创建project是，勾选“Only serve as parent for other projects”

这个会在gerrit-site/git下面生成 your_parent_prj.git，是一个独立的project，只是这个project被用来集中管理permission设置。

```
ssh -p 29418 speedio@localhost gerrit create-project --parent your_parent_prj --description "'子项目A'" prj_a
```

相当于网站上创建 project 是，在“Rights Inherit From:”选择刚创建的 **your_parent_prj**,新创建的 **prj_a** 将会从 **your_parent_prj** 继承 permission设置，而不是默认从 All-Projects


## 存放位置分组

```
ssh -p 29418 speedio@localhost gerrit create-project --description "'V7 Builtin Client'" builtin/v7bc
```

将会在 gerrit-site/git 下面创建文件夹 builtin 并将 v7bc.git 放在下面。但是建完之后，网页上无法访问，提示“Bad Request”，不知道为啥！！

注意：这种方式只能通过命令执行创建project，而不能直接在网站上输入“builtin/v7bc”来创建，会报告400错误。



## 参考

<http://127.0.0.1:8080/gerrit/Documentation/cmd-create-project.html>


