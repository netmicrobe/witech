---
layout: post
title: mysql 用户权限管理，Grant
categories: [cm, mysql]
tags: [cm, mysql, security, admin]
---

mysql.db 表记录了对数据库的权限

所有权限

GRANT ALL ON app_channel.* TO 'app_channel'@'localhost' IDENTIFIED BY '111';

查询权限

GRANT SELECT ON ...

锁表权限

GRANT LOCK TABLES ON ...


