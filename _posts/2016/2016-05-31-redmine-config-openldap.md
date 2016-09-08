---
layout: post
title: redmine 配置 openldap 用户认证
categories: [cm, redmine]
tags: [cm, redmine, ldap, openldap]
---



## 配置方法

管理 》LDAP认证 》 新建认证模式

```
名称：ldap72
主机：192.168.251.72
端口：389
账号：cn=Manager,dc=duzzle,dc=com
密码：home
Base DN：ou=people,dc=duzzle,dc=com
```

```
属性
登录名属性：uid
名字属性：displayName
```

## 使用

创建/编辑用户，认证模式，选择刚刚建立ldap






















