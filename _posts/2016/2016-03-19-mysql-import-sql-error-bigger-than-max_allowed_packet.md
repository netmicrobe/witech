---
layout: post
title: Mysql 导入sql出错 bigger than 'max_allowed_packet'
categories: [cm, mysql]
tags: [cm, mysql]
---

## 现象

```
ERROR:
Unknown command '\''
...
...
ERROR 1153 (08S01): Got a packet bigger than 'max_allowed_packet' bytes


ERROR:
Unknown command '\''.
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that
corresponds to your MySQL server version for the right syntax to use near '75998
','yangjun','2015-10-13 19:00:58','CP宸ュ崟','2015-10-13',NULL,172),(216299' at
line 1

ERROR:
Unknown command '\n'.
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that
corresponds to your MySQL server version for the right syntax to use near '\n
         }','2014-08-14',NULL,131),(141254,63,'40988','zhangqq','2014-08-14' at
line 1
```

```
mysql> SHOW VARIABLES LIKE 'max_allowed_packet';
+--------------------+---------+
| Variable_name      | Value   |
+--------------------+---------+
| max_allowed_packet | 1048576 |
+--------------------+---------+

mysql> SHOW VARIABLES LIKE 'max%';     
+----------------------------+----------------------+
| Variable_name              | Value                |
+----------------------------+----------------------+
| max_allowed_packet         | 16777216             |
```

## 解决方法：

在 my.ini 中设置 *max_allowed_packet=16M*

## 补充：

我是在从linux上导出sql，到windows上导入

不断的报，Error: Unknown Command '\'' 或者 Error: Unknown Command '\n'.

所以 dump 的使用加了 --hex-blob 参数：

```
mysqldump --opt -u root --password=your-pass --hexblob --ignore-table=bitnami_redmine.changes bitnami_redmine > redmine_ignore_changes.sql
```

到windows上导入：

```
mysql -u root -p --port=3306 --default-character-set=utf8 bitnami_redmine < redmine_ignore_changes.sql
```











