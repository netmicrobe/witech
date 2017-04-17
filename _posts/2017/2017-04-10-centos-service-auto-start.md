---
layout: post
title: chkconfig 配置 CentOS 6 服务自启动
categories: [cm, linux]
tags: [centos, chkconfig]
---

## 服务自启动情况查看

```
chkconfig --list
```

某个服务自启动情况

```shell
# 查看opensssh服务器的自启动配置
chkconfig --list sshd
```

## 配置自启动

```shell
# openssh服务自启动
chkconfig sshd on
```