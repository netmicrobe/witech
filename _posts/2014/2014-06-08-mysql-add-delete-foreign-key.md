---
layout: post
title: mysql 添加外键、删除外键
categories: [cm, mysql]
tags: [cm, mysql]
---

## 添加外键

```sql
ALTER TABLE tbl_name
    ADD [CONSTRAINT [symbol]] FOREIGN KEY
    [index_name] (index_col_name, ...)
    REFERENCES tbl_name (index_col_name,...)
    [ON DELETE reference_option]
    [ON UPDATE reference_option]

reference_option:
    RESTRICT | CASCADE | SET NULL | NO ACTION
RESTRICT    严格按照外键约束，必须先删除/更新子表记录，才能修改主表记录。
CASCADE     主表有变动，Mysql自动调整子表。
SET NULL    主表有变动，Mysql自动将子表对应值置为NULL，注意：那一列要允许设置为NULL
NO ACTION   主表有变动，啥都不做！

ALTER TABLE Orders
    ADD CONSTRAINT fk_PerOrders
    FOREIGN KEY (Id_P)
    REFERENCES Persons(Id_P)
```

## 删除外键

```sql
ALTER TABLE Orders DROP FOREIGN KEY fk_PerOrders
```



参考：<http://www.w3school.com.cn/sql/sql_foreignkey.asp>

