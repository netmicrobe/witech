---
layout: post
title: 升级 MySQL 5.1 到 5.7
categories: [cm, mysql]
tags: [cm, mysql]
---

## 升级步骤

1. 备份现有 MySQL 5.1 
    
    备份现有 MySQL 5.1 的数据库文件夹。使用 mysqldump 备份 MySQL 5.1 的业务数据、用户&权限（在mysql 和 information_schema 数据库中）。
    
    ``` shell
    mysqldump --opt -u root -pYOUR-PASS your-db-name > your-db-name.sql
    ```
    
2. 卸载 MySQL 5.1 ， 安装 5.7
    
    安装方法参见 MySQL 官网 <http://dev.mysql.com/doc/refman/5.7/en/installing.html>

3. 检查安装结果
    
    ``` shell
    mysql --version
    ```
    
4. 设置 root 密码
    
    ``` shell
    mysqladmin -u root password 'your-pass'
    ```
    
    如果设置失败，尝试：[重置root密码的方法](#reset-root-password)
    
5. 登录导入数据库
    先创建数据库，恢复之前用户&权限
    
    ``` shell
    mysql -u root -pYOUR-PASS your-db-name < your-db-name.sql
    ```
    
    如果是在 windows 上导入失败，可能是编码的问题，尝试：
    
    ``` shell
    mysql -u root -pYOUR-PASS --default-character-set=utf8 your-db-name < your-db-name.sql
    ```

## Trouble Shooting

### sql执行失败，SQL Error (3005)

* 现象

``` sql
SELECT  DISTINCT `members`.id FROM `members` 
  LEFT OUTER JOIN `projects` ON `projects`.`id` = `members`.`project_id` 
  LEFT OUTER JOIN `member_roles` ON `member_roles`.`member_id` = `members`.`id` 
  LEFT OUTER JOIN `roles` ON `roles`.`id` = `member_roles`.`role_id` 
 WHERE `members`.`user_id` = 28 
    AND `members`.`project_id` = 32 
    AND (projects.status<>9) 
    ORDER BY projects.name LIMIT 1
```

上述 SQL 执行报错：

```
SQL Error (3005): Expression #1 of ORDER BY clause is not in SELECT list, references column 'redmine.projects.name' which is not in SELECT list; this is incompatible with DISTINCT
```

* 分析

  从 5.5 陆续对 sql 有严格的要求哦，老的web app有可能sql不满足规范。

  ``` sql
  mysql> SELECT @@GLOBAL.sql_mode;
  +------------------------------------------------------------------------------+
  | @@GLOBAL.sql_mode                                                            |
  +------------------------------------------------------------------------------+
  | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
  +------------------------------------------------------------------------------+
  ```

  上述 SELECT 问题，是违反 ONLY_FULL_GROUP_BY 规则。

  可以临时设置服务器，来验证下：

  ``` sql
  SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
  ```

* 解决
  
  设置 /etc/my.cnf ，取消所有mode
  
  ```
  sql-mode=""
  ```
  
  重启mysql



* 参考
  * <http://dev.mysql.com/doc/refman/5.7/en/sql-mode.html>
  * [ [MySQL 5.7] ORDER BY clause is not in SELECT list #376 rp1428 commented on 1 Dec 2015 ](https://github.com/Piwigo/Piwigo/issues/376)






<a name="reset-root-password"></a>

### 重置root密码

* 参考
  * <http://dev.mysql.com/doc/refman/5.7/en/resetting-permissions.html>

1. 登录&停止运行中的mysql，ps -ef \| grep mysql , kill it 或者
    
    ``` shell
    kill `cat /mysql-data-directory/host_name.pid`
    ```
    
2. 创建一个文本文件，例如，mysql-init
        
    ``` sql
    MySQL 5.7.6 and later:
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';
    
    MySQL 5.7.5 and earlier:
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MyNewPass');
    ```
        
3. 启动 mysql 传入初始化文件
    
    ``` shell
    shell> mysqld_safe --init-file=/home/me/mysql-init &
    ```
    
4. 重置完成


### 不能执行 LOAD DATA INFILE

* 报错信息
    The MySQL server is running with the \--secure-file-priv option so it cannot execute this statment

* 分析
    * 参考
        * <https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_secure_file_priv>
        
  如果 secure-file-priv 选项设置了，只有指定目录中的文件能够导入。
  如下方法查看目录位置：
      
  ``` sql
  mysql> SHOW VARIABLES LIKE "secure_file_priv";
  +------------------+-----------------------+
  | Variable_name    | Value                 |
  +------------------+-----------------------+
  | secure_file_priv | /var/lib/mysql-files/ |
  +------------------+-----------------------+
  ```
      
  或者
  
  ``` sql
  mysql> SELECT @@global.secure_file_priv;
  +---------------------------+
  | @@global.secure_file_priv |
  +---------------------------+
  | /var/lib/mysql-files/     |
  +---------------------------+
  ```


* 解决
  在指定目录放置文件后，再 LOAD DATA INFILE ; 或者 直接关闭服务器的 secure-file-priv 检查。
  
  * 如何关闭 secure-file-priv 检查
      在 my.cnf 中设置
        
  ```
  [mysqld]
  secure-file-priv = ""
  ```
    

