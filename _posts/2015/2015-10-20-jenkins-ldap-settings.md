---
layout: post
title: jenkins LDAP 配置
description: 
categories: [cm, jenkins]
tags: [cm, jenkins]
---

jenkins > 设置 > Configure Global Security > 安全域

```
服务器
192.168.253.72

root DN
dc=duzzle,dc=com

User search filter
uid={0}

Group search filter
(& (cn={0}) (objectclass=groupOfNames))

Manager DN
cn=Manager,dc=duzzle,dc=com

Manager Password
*******
```