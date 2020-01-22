---
layout: post
title: mysql dump 备份
categories: [cm, mysql]
tags: [cm, mysql, mysqldump]
---

## mysqldump --ignore-table 备份数据库时，忽略某些表

~~~shell
mysqldump -h <host> -u <username> -p <schema> --ignore-table=schema.table1 --ignore-table=schema.table2 > db-data.sql
~~~

### 备份Redmine数据库的例子

~~~shell
mysqldump -u root -p --ignore-table=bitnami_redmine.changes --ignore-table=bitnami_redmine.changesets bitnami_redmine > redmine-without-chagnes.sql
~~~



## mysqldump --no-data 只备份表结构


~~~shell
mysqldump -h <host> -u <username> -p <schema> --no-data > db-structure.sql
~~~


## dump 单张表

~~~shell
mysqldump -u root -p mydatabase table1 > table1.sql
~~~


## dump 后兼容sqlite3导入

* refer
  * [mysql2sqlite - github](https://github.com/dumblob/mysql2sqlite)


~~~shell
mysqldump --skip-extended-insert -u root -p --ignore-table=bitnami_redmine.changes --ignore-table=bitnami_redmine.changesets bitnami_redmine > redmine-without-chagnes.sql

# 使用 mysql2sqlite 脚本生产sqlite3数据库
./mysql2sqlite redmine-without-chagnes.sql | sqlite3 redmine.sqlite3
~~~














