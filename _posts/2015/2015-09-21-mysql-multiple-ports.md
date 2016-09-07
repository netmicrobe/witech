---
layout: post
title: 一台MySQL服务器启动多个端口
categories: [cm, mysql]
tags: [cm, mysql]
---

### 复制多个my.cnf，如下：

```shell
cp /etc/my.cnf my3306.cnf
cp /etc/my.cnf my3310.cnf
```

### 修改配置文件中的相关数据：port，socket，pid，errorlog

```
[client]
#password       = your_password
port            = 3310
socket          = /var/lib/mysql/mysql3310.sock
# Here follows entries for some specific programs
# The MySQL server
[mysqld]
lower_case_table_names=1
port            = 3310
socket          = /var/lib/mysql/mysql3310.sock
log-error = /var/lib/mysql/mysql3310_error.log
pid-file = /var/lib/mysql/3310.pid
```

### 创建数据库存放的目录

```
mkdir -m 755 /var/lib/mysql3310
```

### 初始化数据库

```
/usr/bin/mysql_install_db --datadir=/var/lib/mysql3310/ --user=mysql --basedir=/usr/
```

### 启动mysql该端口

```
/usr/bin/mysqld_safe --defaults-extra-file=/etc/my3310.cnf --datadir=/var/lib/mysql3310/ --user=mysql &
```

### 本机登录mysql该端口

```
mysql -S /var/lib/mysql/3310.pid -P 3310 -u root -p
```

### 登录后，执行如下命令，添加远程登录mysql的权限

```
grant all privileges on *.* to root@"%" identified by "test11" with grant option;
flush privileges;
```


