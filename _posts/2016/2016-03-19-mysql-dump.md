---
layout: post
title: mysql dump 备份
categories: [cm, mysql]
tags: [cm, mysql, mysqldump, ignore-table]
---

## mysqldump --ignore-table 备份数据库时，忽略某些表

~~~shell
mysqldump -h <host> -u <username> -p <schema> --ignore-table=schema.table1 --ignore-table=schema.table2 > db-data.sql
~~~

### dump之前最好看下库里面有没有很大容量的表

* [lukcyjane - 查看mysql库大小，表大小，索引大小](https://www.cnblogs.com/lukcyjane/p/3849354.html)

* **查看一个库中的情况**
~~~
SELECT CONCAT(table_schema,'.',table_name) AS 'Table Name', CONCAT(ROUND(table_rows/1000000,4),'M') AS 'Number of Rows', CONCAT(ROUND(data_length/(1024*1024*1024),4),'G') AS 'Data Size', CONCAT(ROUND(index_length/(1024*1024*1024),4),'G') AS 'Index Size', CONCAT(ROUND((data_length+index_length)/(1024*1024*1024),4),'G') AS'Total'FROM information_schema.TABLES WHERE table_schema LIKE 'test';
~~~



* 查看所有库的大小
  ~~~
  mysql> use information_schema;
  Database changed
  mysql> select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data  from TABLES;
  ~~~

* 查看指定库的大小

  ~~~
  select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data  from TABLES where table_schema='jishi';
  ~~~

* 查看指定库的指定表的大小
  ~~~
  select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data  from TABLES where table_schema='jishi' and table_name='a_ya';
  ~~~


* 查看指定库的索引大小

~~~
SELECT CONCAT(ROUND(SUM(index_length)/(1024*1024), 2), ' MB') AS 'Total Index Size' FROM TABLES  WHERE table_schema = 'jishi'; 
~~~

* 查看指定库的指定表的索引大小

~~~
SELECT CONCAT(ROUND(SUM(index_length)/(1024*1024), 2), ' MB') AS 'Total Index Size' FROM TABLES  WHERE table_schema = 'test' and table_name='a_yuser'; 
~~~






### 备份Redmine数据库的例子

~~~shell
mysqldump -u root -p --ignore-table=bitnami_redmine.changes --ignore-table=bitnami_redmine.changesets bitnami_redmine > redmine-without-chagnes-$(date "+%Y-%m-%d_%H%M%S").sql
~~~



## dump 时候不用输入密码

* [mysqldump: Using a password on the command line interface can be insecure.问题的解决](https://blog.csdn.net/shenxiaomo1688/article/details/90757281)
* []()
* []()

1. 在mysql client的配置文件 `/etc/my.conf` 写密码
    ~~~
    [client]
    port = 3306
    socket = /tmp/mysql.sock
    default-character-set = utf8mb4
    host = localhost
    host=localhost
    user=数据库用户
    password='数据库密码'
    ~~~

2. 使用 `mysqldump` 时添加参数 `--defaults-extra-file=/etc/my.cnf`


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














