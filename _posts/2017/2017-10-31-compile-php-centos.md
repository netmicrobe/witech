---
layout: post
title: centos 上编译 php 5.6
categories: [cm, php]
tags: [php, compile, centos]
---

* refer to
  * <http://php.net/manual/en/install.unix.apache2.php>

### 前提

#### 安装 mysql

#### 安装 apache2

#### 安装 zlib 
~~~
yum install -y zlib zlib-devel
~~~

### 编译 php

~~~ shell
cd ../php-NN
./configure --with-apxs2=/usr/local/apache2/bin/apxs --with-mysql
  或者 ./configure --prefix=/opt/php-5.6.32 --with-apxs2=/usr/sbin/apxs --with-zlib --with-mysql=/opt/mysql-5.5.55 --with-pdo-mysql=/opt/mysql-5.5.55 --with-mysql-sock=/var/lib/mysql/mysql.sock
make
make install
~~~

### 配置 php

~~~ shell
vim /etc/httpd/conf/httpd.conf

# 添加
LoadModule php5_module modules/libphp5.so
AddType application/x-httpd-php .php
~~~

