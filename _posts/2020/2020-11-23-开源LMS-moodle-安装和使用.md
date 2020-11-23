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
  * []()
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
















































