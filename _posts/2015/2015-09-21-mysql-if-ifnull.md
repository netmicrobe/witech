---
layout: post
title: Mysql 条件函数 If Ifnull
categories: [cm, mysql]
tags: [cm, mysql]
---

## IF

IF(condition,true-value,false-value)

## IFNULL

IFNULL(cloumn-name, true-value)

## 与NULL比较

IS NULL    IS NOT NUL    <=>

```sql
SELECT name, IF(id IS NULL, ‘Unknown’,id) as ‘id’ FROM taxpayer;
```
