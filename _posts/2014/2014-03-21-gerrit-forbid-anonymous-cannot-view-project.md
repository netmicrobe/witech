---
layout: post
title: gerrit 权限管理 ， 禁止匿名用户查看project
categories: [cm, git]
tags: [cm, git, gerrit]
---

gerrit默认允许匿名用户查看project

projects > all projects > access

在 References: refs/* 配置项目下，调整 Anonymous > Deny

设置后，匿名用户无法查看project；

此时如果对refs/*没有配置【Registered Users > Allow】，登录用户也只能看到作为Owner的project。
