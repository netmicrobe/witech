---
layout: post
title: 在 CentOS 6 上使用 openssh
categories: [cm, linux, centos]
tags: [cm, linux, centos, openssh]
---

## 安装配置

### 查看是否安装

```
# yum list \*openssh\*


```

### 启动、关闭、状态查询

* 状态：service sshd status
* 启动：service sshd start
* 关闭：service sshd stop


### 开机自启动

* 查看状态：chkconfig --list sshd
* 设置： chkconfig --level 2345 sshd on







