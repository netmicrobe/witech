---
layout: post
title: 使用gitea镜像github等外部仓库，关联git,scm,gitlab
categories: [cm, git]
tags: []
---

* 参考
  * [使用gitea通过码云完整克隆github源码库到本地备份（Windows Docker环境）](https://blog.csdn.net/u014038143/article/details/106789620)
  * []()
  * []()
  * []()
  * []()
  * []()
  * []()



Gitea 有镜像功能：

1. 页面右上角 + 号菜单 》 New Migration
1. 选择Github 或者 其他平台
1. Migrate / Clone From URL: 输入clone地址
1. 勾选 This repository will be a mirror （项目会定期同步，默认8小时一次）
1. 选择 owner 和 repo name
1. 点击 Migrate Repository 创建。

* **问题** 从github的网络质量感人，特别repo体积很大的时候，经常失败。

所以，可以从 gitee.com 绕一下。

1. 在gitee上先导入github库
    页面右上角 + 号菜单 》 从 Gitlab / Gitlab 上导入仓库
1. 在 gitea 上导入 gitee的库
    导入完成后，进入项目的 Settings \> Mirror Settings
    更新 `Clone From URL` 成 github 的url
    点击 Update Settings





















































