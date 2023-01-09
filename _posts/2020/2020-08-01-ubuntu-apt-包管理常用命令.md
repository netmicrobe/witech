---
layout: post
title: ubuntu-apt-包管理常用命令，关联 mint, debian, ubuntu, apt, dpkg-query, dpkg-deb, apt-file
categories: [cm, linux]
tags: []
---

* 参考： 
  * []()
  * []()
  * []()



### 升级特定软件

~~~
# How to upgrade a single package using apt-get?
sudo apt-get --only-upgrade install nginx
~~~

### 已安装的package有哪些文件

~~~
# To see all the files the package installed onto your system
dpkg-query -L <package_name>
~~~

使用 `apt-file`

~~~
sudo apt-get install apt-file
sudo apt-file update

apt-file list <package_name>
~~~

### deb 包文件操作

~~~sh
# To see the files a .deb file will install
dpkg-deb -c <package_name.deb>

# 查看deb包信息
dpkg-deb -I some.deb
# or
dpkg-deb --info some.deb
~~~








































