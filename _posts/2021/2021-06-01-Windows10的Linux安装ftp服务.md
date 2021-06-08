---
layout: post
title: Windows10的Linux安装ftp服务
categories: [cm, Windows]
tags: [WSL, Windows-Subsystem-Linux, ftp]
---

* 参考： 
    * [How to quickly set up an FTP server on Ubuntu 18.04](https://www.techrepublic.com/article/how-to-quickly-setup-an-ftp-server-on-ubuntu-18-04/)
    * []()
    * []()
    * []()


## 安装配置 ftp server

~~~
# 安装
sudo apt-get install vsftpd

# 启动
sudo service vsftpd start
sudo service vsftpd status
~~~



## 自动启动 ssh server


`%windir%\System32\bash.exe -c "sudo /etc/init.d/vsftpd start"`
















