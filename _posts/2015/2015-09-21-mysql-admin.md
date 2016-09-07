---
layout: post
title: Mysql 数据库配置管理
categories: [cm, mysql]
tags: [cm, mysql]
---

## MySQL服务器

### 启动/关闭 mysql server
 
mysqld --console

启动，console参数表现需要将log显示到console中。
 
mysqladmin -u root shutdown

关闭服务器。

Linux包管理安装后，有service管理，启动管理可以通过service：

service mysqld start/stop/restart/status

也可以加入系统自启动：chkconfig mysqld on
 
### 端口设置

mysql默认端口号3306
 
在mysql/bin/my.ini中设置mysql的端口

找到服务器的配置区域 [mysqld]

将默认值“port=3306”改成需要的端口，重启mysqld即可。
 
 
## MySQL客户端


### mysql命令行工具

mysql --user=root mysql

以root账户登录服务器，将mysql数据库设置成当前数据库。



## 安全设置
 
### 修改ROOT密码


#### 用SET PASSWORD命令

mysql -u root

mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');
 
#### 使用mysqladmin

mysqladmin -u root password "newpass"

如果root已经设置过密码，采用如下方法

mysqladmin -u root password oldpass "newpass"
 
#### 用UPDATE直接编辑user表

```shell
mysql -u root
mysql> use mysql;
mysql> UPDATE user SET Password = PASSWORD('newpass') WHERE user = 'root';
mysql> FLUSH PRIVILEGES;
```
 
### 重置root密码

```shell
mysqld_safe --skip-grant-tables&
mysql -u root mysql
mysql> UPDATE user SET password=PASSWORD("new password") WHERE user='root';
mysql> FLUSH PRIVILEGES;
```
 
 
## 批量数据操作

 
### 使用LOAD DATA导入

默认的LOAD DATA 导入格式是\t分列、\n分行的文件。

例如：

```sql
-- ------------------------------------------
-- 导入行政区数据
-- ------------------------------------------
DELETE FROM silent_city;
LOAD DATA INFILE 'sw_init/data_province_city.csv' 
    INTO TABLE silent_city
    CHARACTER SET utf8
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"' 
    ESCAPED BY '"'
    LINES TERMINATED BY '\r\n' 
    IGNORE 1 LINES 
    (id, pid, name);
```
    
## 备份和恢复
 
示例：

```shell
backup
mysqldump -u root --opt  bugs | gzip > bugs.sql.gz
 
restore
gunzip < bugs.sql.gz | mysql -u root bugs
```

