---
layout: post
title: 重置 mysql 的 root 密码
categories: [cm, mysql]
tags: [centos, mysql, password]
---

* [How to Reset the Root Password](https://dev.mysql.com/doc/refman/5.5/en/resetting-permissions.html)


### CentOS 上 reset mysql 5.5 的 root 密码


1.  关闭正在运行的 mysql

    ~~~
    shell> kill `cat /mysql-data-directory/host_name.pid`
    ~~~

2.  创建 reset 脚本

    * /home/me/mysql-init

    ~~~
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MyNewPass');
    ~~~

3.  启动 mysql

    ~~~
    shell> mysqld --init-file=/home/me/mysql-init &
    ~~~

4.  删除 reset 脚本

    ~~~
    rm -f /home/me/mysql-init
    ~~~



