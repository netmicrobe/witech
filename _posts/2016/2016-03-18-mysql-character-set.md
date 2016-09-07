---
layout: post
title: Mysql 字符集（Charset）
categories: [cm, mysql]
tags: [cm, mysql]
---



参考：<http://dev.mysql.com/doc/refman/5.7/en/charset-database.html>


### 创建和修改的语法

```
CREATE DATABASE db_name
    [[DEFAULT] CHARACTER SET charset_name]
    [[DEFAULT] COLLATE collation_name]

ALTER DATABASE db_name
    [[DEFAULT] CHARACTER SET charset_name]
    [[DEFAULT] COLLATE collation_name]
```

### 查看当前 DB 使用的字符集和排序规则

```
USE db_name;
SELECT @@character_set_database, @@collation_database;
```

或者使用，

```
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'db_name';
```

### 查看当前DB、Table、Colume的字符集


For Schemas:

```
SELECT default_character_set_name FROM information_schema.SCHEMATA 
WHERE schema_name = "schemaname";
```

For Tables:

```
SELECT CCSA.character_set_name, CCSA.collation_name FROM information_schema.`TABLES` T,
       information_schema.`COLLATION_CHARACTER_SET_APPLICABILITY` CCSA
WHERE CCSA.collation_name = T.table_collation
  AND T.table_schema = "schemaname"
  AND T.table_name = "tablename";
```
  
For Columns:

```
SELECT character_set_name FROM information_schema.`COLUMNS` 
WHERE table_schema = "schemaname"
  AND table_name = "tablename"
  AND column_name = "columnname";
```




