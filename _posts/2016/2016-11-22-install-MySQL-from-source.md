---
layout: post
title: 从源码安装MySQL
categories: [cm, mysql]
tags: [cm, mysql]
---

* 参考
  * [Running Multiple MySQL Instances on One Machine](http://dev.mysql.com/doc/refman/5.7/en/multiple-servers.html)
  * [A Quick Guide to Using the MySQL Yum Repository](http://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/)
  * [Installing MySQL from Source](https://dev.mysql.com/doc/refman/5.5/en/source-installation.html)
  * [Installing MySQL from Source](http://dev.mysql.com/doc/refman/5.7/en/problems-with-mysql-sock.html)
  * [with-plugins 编译参数说明](https://dev.mysql.com/doc/internals/en/storage-engine-options.html)
  * [Running Multiple MySQL Instances on CentOS 6 / RHEL 6](https://nacko.net/running-multiple-mysql-instances-on-centos-6-rhel-6/)


## 从源代码安装
  
### 官方文档的安装过程


```shell
# Preconfiguration setup
shell> groupadd mysql
shell> useradd -g mysql mysql

# Beginning of source-build specific instructions
shell> tar zxvf mysql-VERSION.tar.gz
shell> cd mysql-VERSION
shell> ./configure --prefix=/usr/local/mysql
shell> make
shell> make install

# End of source-build specific instructions
# Postinstallation setup
shell> cd /usr/local/mysql
shell> chown -R mysql .
shell> chgrp -R mysql .
shell> bin/mysql_install_db --user=mysql
shell> chown -R root .
shell> chown -R mysql var

# Next command is optional
shell> cp support-files/my-medium.cnf /etc/my.cnf
shell> bin/mysqld_safe --user=mysql &

# Next command is optional
shell> cp support-files/mysql.server /etc/init.d/mysql.server
```

### 在 CentOS 6.8 上编辑的实际配置

#### ./configure 在 centos 6.8 上执行的例子

```shell
CFLAGS="-O3" CXX=gcc CXXFLAGS="-O3 -felide-constructors \
       -fno-exceptions -fno-rtti" ./configure \
       --prefix=/usr/local/mysql-5.1.72 --localstatedir=/var/lib/mysql-5.1.72 --enable-assembler \
       --with-mysqld-ldflags=-all-static \
       --without-man --without-docs --without-debug \
       --with-mysqld-user=mysql \
       --with-charset=utf8 --with-collation=utf8_general_ci \
       --with-extra-charsets=binary,ascii,latin1,latin2,latin5,latin7,gb2312,gbk,big5 \
       --with-plugins=csv,myisam,myisammrg,heap,innobase,archive,blackhole \
       --enable-local-infile --with-low-memory --without-geometry
```

#### 安装后，无法启动

* 没有初始化数据文件夹，会报错：

  ```shell
  [ root@127: /usr/local/mysql-5.1.72 ] $ ./bin/mysqld_safe --defaults-file=/etc/my-5.1.72.cnf 
  161123 16:47:01 mysqld_safe Logging to '/var/log/mysqld-5.1.72.log'.
  161123 16:47:01 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql-5.1.72
  161123 16:47:02 mysqld_safe mysqld from pid file /var/run/mysqld-5.1.72/mysqld.pid ended
  ```

* 初始化数据文件夹

  ```
  mkdir /var/run/mysqld-5.1.72
  chown --reference /var/run/mysqld /var/run/mysqld-5.1.72
  chmod --reference /var/run/mysqld /var/run/mysqld-5.1.72
  mysql_install_db --datadir=/var/lib/mysql-5.1.72 --defaults-file=/etc/my-5.1.72.cnf --user=mysql
  ```


#### 安装后，配置 my.cnf

```
$ cat /etc/my-5.1.72.cnf 

[mysqld]
datadir=/var/lib/mysql-5.1.72
socket=/var/lib/mysql-5.1.72/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
port=3336

[mysqld_safe]
log-error=/var/log/mysqld-5.1.72.log
pid-file=/var/run/mysqld-5.1.72/mysqld.pid


lower_case_table_names=0
```

#### 启动

```
[ root@127: ] $ /usr/local/mysql-5.1.72/bin/mysqld_safe --defaults-file=/etc/my-5.1.72.cnf 
```

#### 连接数据库

```
mysql -u root --port=3336 -p --socket=/var/lib/mysql-5.1.72/mysql.sock
```


#### 修改密码

如果access denied ，无法登陆，尝试修改下密码

```
/usr/local/mysql-5.1.72/bin/mysqladmin --defaults-file=/etc/my-5.1.72.cnf --socket=/var/lib/mysql-5.1.72/mysql.sock -u root password 'your-pass'
```


#### 关闭服务器、查看服务器状态


```
/usr/local/mysql-5.1.72/bin/mysqladmin --defaults-file=/etc/my-5.1.72.cnf --socket=/var/lib/mysql-5.1.72/mysql.sock -u root -p status
/usr/local/mysql-5.1.72/bin/mysqladmin --defaults-file=/etc/my-5.1.72.cnf --socket=/var/lib/mysql-5.1.72/mysql.sock -u root -p shutdown
```








## 附录


### 使用 yum 安装的mysql文件分布 

```
[ root@127: /usr/local ] $ rpm -ql mysql.x86_64
/usr/bin/msql2mysql
/usr/bin/my_print_defaults
/usr/bin/mysql
/usr/bin/mysql_config
/usr/bin/mysql_find_rows
/usr/bin/mysql_waitpid
/usr/bin/mysqlaccess
/usr/bin/mysqladmin
/usr/bin/mysqlbinlog
/usr/bin/mysqlcheck
/usr/bin/mysqldump
/usr/bin/mysqlimport
/usr/bin/mysqlshow
/usr/bin/mysqlslap
/usr/lib64/mysql/mysql_config
/usr/lib64/mysql/mysqlbug
/usr/share/doc/mysql-5.1.73
/usr/share/doc/mysql-5.1.73/COPYING
/usr/share/doc/mysql-5.1.73/README
/usr/share/doc/mysql-5.1.73/README.mysql-docs
/usr/share/doc/mysql-5.1.73/README.mysql-license
/usr/share/man/man1/my_print_defaults.1.gz
/usr/share/man/man1/mysql.1.gz
/usr/share/man/man1/mysql_config.1.gz
/usr/share/man/man1/mysql_find_rows.1.gz
/usr/share/man/man1/mysql_waitpid.1.gz
/usr/share/man/man1/mysqlaccess.1.gz
/usr/share/man/man1/mysqladmin.1.gz
/usr/share/man/man1/mysqldump.1.gz
/usr/share/man/man1/mysqlshow.1.gz
/usr/share/man/man1/mysqlslap.1.gz
```










## Trouble Shooting

### 运行 configure 时，报错 cannot remove 'libtoolT': No such file or directory error

* 参考
  <http://oldhammade.net/blog/2013/04/30/mysql-the-libtoolt-error-on-x86-64.html>

```
[mysql-x.x.x]# libtoolize --force
Using `AC_PROG_RANLIB' is rendered obsolete by `AC_PROG_LIBTOOL'
You should update your `aclocal.m4' by running aclocal.
[mysql-x.x.x]# aclocal
[mysql-x.x.x]# cp BUILD/compile-pentium64 ./compile
[mysql-x.x.x]# autoreconf
```


### redmine 报错

* 错误日志

  ```
  Started GET "/redmine/issues/4492" for 127.0.0.1 at 2016-11-24 19:27:56 +0800

  Mysql2::Error (Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)):
    mysql2 (0.3.18) lib/mysql2/client.rb:70:in `connect'
    mysql2 (0.3.18) lib/mysql2/client.rb:70:in `initialize'
    activerecord (3.2.16) lib/active_record/connection_adapters/mysql2_adapter.rb:16:in `new'
    activerecord (3.2.16) lib/active_record/connection_adapters/mysql2_adapter.rb:16:in `mysql2_connection'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:315:in `new_connection'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:325:in `checkout_new_connection'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:247:in `block (2 levels) in checkout'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:242:in `loop'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:242:in `block in checkout'
    /usr/local/rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/monitor.rb:211:in `mon_synchronize'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:239:in `checkout'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:102:in `block in connection'
    /usr/local/rvm/rubies/ruby-1.9.3-p551/lib/ruby/1.9.1/monitor.rb:211:in `mon_synchronize'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:101:in `connection'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_pool.rb:410:in `retrieve_connection'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_specification.rb:171:in `retrieve_connection'
    activerecord (3.2.16) lib/active_record/connection_adapters/abstract/connection_specification.rb:145:in `connection'
  ```

* 解决方法

  * 参考：<http://stackoverflow.com/a/6412218

  修改 redmine-home/config/database.yml ，添加 socket 配置。

  ```
  production:
    adapter: mysql2
    database: redmine
    host: localhost
    username: redmine
    password: "your-pass"
    encoding: utf8
    socket: /var/lib/mysql-5.1.72/mysql.sock
  ```>


### php 报错 ，Error Message: 2002 - Can't connect to local MySQL server through socket

* 报错

  ```
  Connect to database testlink on Host localhost fails 
  DBMS Error Message: 2002 - Can't connect to local MySQL server through socket '/var/lib/mysql-5.1.72/mysql.sock' (13)
  ```

  ```
  ﻿Connect Error(2002) Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)
  ```

  ```
  yii framework 报错

  CDbConnection failed to open the DB connection: SQLSTATE[HY000] [2002] Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)
  ```

* 解决方法

  将连接配置中 host 由 localhost 该为 127.0.0.1 可解决。

  但是如何让php-mysql的模块，不使用默认 socket '/var/lib/mysql/mysql.sock' 没找到啊～～

  配置了 php.ini 中 mysql.default_socket=/where/socket/file，没用！！


### php 报错，在 mysql 5.7

```
Thu Nov 24 21:05:49 2016] [notice] Apache/2.2.15 (Unix) DAV/2 PHP/5.3.3 mod_ssl/2.2.15 OpenSSL/1.0.1e-fips SVN/1.8.13 configured -- resuming normal operations
[Thu Nov 24 21:05:57 2016] [error] [client 192.168.247.231] PHP Fatal error:  Call to undefined function mysql_connect() in /opt/server/testlink/testlink.1.9.5/testlink
/testlink-1.9.5/third_party/adodb/drivers/adodb-mysql.inc.php on line 364
[Thu Nov 24 21:06:03 2016] [error] [client 192.168.247.231] PHP Fatal error:  Call to undefined function mysql_connect() in /opt/server/testlink/testlink.1.9.5/testlink
/testlink-1.9.5/third_party/adodb/drivers/adodb-mysql.inc.php on line 364, referer: http://192.168.251.72/testlink/
[Thu Nov 24 21:06:09 2016] [error] [client 192.168.247.231] PHP Fatal error:  Call to undefined function mysql_connect() in /opt/server/testlink/testlink.1.9.5/testlink
/testlink-1.9.5/third_party/adodb/drivers/adodb-mysql.inc.php on line 364, referer: http://192.168.251.72/testlink/
[Thu Nov 24 21:07:00 2016] [error] [client 192.168.247.231] PHP Fatal error:  Call to undefined function mysql_connect() in /opt/server/testlink/testlink.1.9.5/testlink
/testlink-1.9.5/third_party/adodb/drivers/adodb-mysql.inc.php on line 364
[Thu Nov 24 21:07:02 2016] [error] [client 192.168.247.231] PHP Fatal error:  Call to undefined function mysql_connect() in /opt/server/testlink/testlink.1.9.5/testlink
/testlink-1.9.5/third_party/adodb/drivers/adodb-mysql.inc.php on line 364
[Thu Nov 24 21:09:32 2016] [error] [client 192.168.247.231] Directory index forbidden by Options directive: /opt/server/wiphone/wiphone/php_source/
[Thu Nov 24 21:09:37 2016] [error] [client 192.168.247.231] Directory index forbidden by Options directive: /opt/server/wiphone/wiphone/php_source/
```