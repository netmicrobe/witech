---
layout: post
title: mysql 命令行 导入数据
categories: [cm, mysql]
tags: [cm, mysql]
---

mysql -u root -p database-name < sql-file.sql

或者，在sql文件当前目录，进入mysql客户端的shell

```
mysql > use database-name;
mysql > source sql-file.sql
```