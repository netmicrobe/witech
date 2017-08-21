---
layout: post
title: mysql dump 备份
categories: [cm, mysql]
tags: [cm, mysql]
---

mysqldump -h <host> -u <username>-p <schema> --no-data > db-structure.sql

mysqldump -h <host> -u <username>-p <schema> --ignore-table=schema.table1 --ignore-table=schema.table2 > db-data.sql

dump 单张表

mysqldump -u -p mydatabase table1 > table1.sql