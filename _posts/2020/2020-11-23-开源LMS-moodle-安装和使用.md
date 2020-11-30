---
layout: post
title: 开源LMS-moodle-安装和使用
categories: [learning]
tags: []
---

* 参考： 
  * <http://www.moodle.com/>
  * <https://moodle.org>
  * <https://github.com/moodle/moodle>
  * [Git for Administrators](https://docs.moodle.org/310/en/Git_for_Administrators)
    里面写了怎么安装模块的第三方git库
  * [How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04)
  * []()



Moodle 基于 LAMP （Apache, PostgreSQL/MySQL/MariaDB and PHP） 开发。



## Moodle 下载

* 从 <http://moodle.org/downloads> 下载
* 从 git 下载
  `git clone -b MOODLE_{{Version3}}_STABLE git://git.moodle.org/moodle.git`
  moodle.org 速度有点慢，可以从github
  `git clone -b MOODLE_{{Version3}}_STABLE https://github.com/moodle/moodle.git`



## 安全设置

~~~
chown -R root /path/to/moodle
chmod -R 0755 /path/to/moodle
~~~


## 在Ubuntu 18.04 上 安装 Moodle


### 初始化数据库

#### 使用Mysql数据库

* refer: <https://docs.moodle.org/310/en/MySQL>

~~~
sudo apt-get install mysql-server

# 检查安装是否成功
mysql --version
systemctl status mysql.service
# root 密码默认为空，但是只有root用户能进
sudo mysql

# 安全提升：the removal of test users, test databases and permission for remote login by a root user.
# sudo mysql_secure_installation

# 修改 mysql root 密码
# mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
# mysql> FLUSH PRIVILEGES;
~~~

~~~
# 创建数据库 moodle
mysql> CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 添加 app 的数据库用户
mysql> CREATE USER moodleuser@'192.168.%.%' IDENTIFIED BY 'moodle';
mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO moodleuser@'192.168.%.%';
mysql> FLUSH PRIVILEGES;
~~~

### 安装 Apache2

~~~
sudo apt install apache2
sudo ufw app list
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
~~~

访问 `http://your_server_ip` 测试是否安装成功。

`systemctl status apache2`

默认 webroot 的位置：/var/www/html


### 安装 PHP

~~~
sudo apt install php libapache2-mod-php php-mysql php-curl php-zip php-xml php-mbstring php-gd php-intl
sudo systemctl restart apache2
~~~




### 创建数据文件夹

数据文件夹:
* 不要和web文件夹放在一起，不能被通过web浏览器访问到。
* 不要放在 root 目录
* 不要放在 moodle 程序目录。

~~~
mkdir /path/to/moodledata
chmod 0777 /path/to/moodledata
~~~

### 为 moodle 创建apache virtual host

假设moodle 放在： `/opt/moodle/moodle-310/`

`sudo vim /etc/apache2/sites-available/moodle.conf`

~~~
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName your_domain
    ServerAlias www.your_domain
    DocumentRoot /opt/moodle/moodle-310
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
~~~

~~~
sudo a2ensite moodle.conf
# disable default conf
sudo a2dissite 000-default.conf

# test config syntax
sudo apache2ctl configtest

# 重启apache2
sudo systemctl restart apache2
~~~

#### 或者，使用子目录

All aliases in Apache 2.4 have to be configured in the /etc/apache2/mods-enabled/alias.conf file.

* Apache >= 2.4

~~~
# moodle
Alias /moodle/ "/opt/moodle/moodle-310/"

<Directory "/opt/moodle/moodle-310">
	Options FollowSymlinks
	AllowOverride None
	Require all granted
</Directory>
~~~

* Apache 2.2

~~~
Alias /moodle "/opt/server/moodle/moodle-310"
<Directory "/opt/server/moodle/moodle-310">
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
~~~




### 执行 moodle install

~~~
chown www-data /path/to/moodle
cd /path/to/moodle/admin/cli
sudo -u www-data /usr/bin/php install.php
chown -R root /path/to/moodle
~~~









## moodle 作为试题库使用

首页，有题库，单个course也有题库，2库试题不通用。可以通过导入和导出来交换试题数据。

* 首页的题库位置： 
  * 站点首页 》设置 菜单 》更多。。。》首页设置 》题库
  * Site Home \> Setting icon \> More... > Question Bank \> Questions

* 首页中创建quiz
  * 站点首页 》设置 菜单 》更多。。。》首页设置 》打开编辑功能 》添加一个活动或资源 》测验


* 某个course的题库位置：
  * 某课程主页 》设置 菜单 》更多。。。》课程管理 》题库
  * some course main page \> Setting icon \> More... > Question Bank \> Questions

* 某个course中创建quiz
  * 某课程主页 》打开编辑功能 》添加一个活动或资源 》测验
  * some course main page \> Turn editing on \> Add an activity or resource \> Quiz






















