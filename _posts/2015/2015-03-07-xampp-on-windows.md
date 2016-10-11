---
layout: post
title: Windows上使用XAMPP
description: 
categories: [cm, xampp]
tags: [cm, xampp, windows, apache, msyql]
---

## 安装
 
 
安装php运行环境（Windows）
在Windows2003上执行php.exe需要“Microsoft C++ 2008 runtime package”。
Microsoft Visual C++ 2008 Redistributable Package (x64)
<http://www.microsoft.com/en-us/download/details.aspx?id=5582>
 
解压xampp面安装包，执行setup_xampp.bat




## 作为Service运行

Windows Server 2003上，如果rdp的session注销，启动的apache、mysql等服务器就会随之关闭。


### Apache在Windows后台执行
 
将httpd作为一个Service来执行。
使用xampp/apache/apache_installservice.bat 来安装服务。
使用xampp/apache/apache_uninstallservice.bat 来安装服务。
或者，执行命令，
安装Service：
    xampp\apache\bin\httpd -k install -n “XAMPP-Apache2.4”
卸载Service
    xampp\apache\bin\httpd -k uninstall -n “XAMPP-Apache2.4”
启动Service：
       net start “XAMPP-Apache2.4”
停止Service：
    net stop “XAMPP-Apache2.4”

### Mysql在Windows后台执行

安装Service：（xampp-mysql为自己设定的service name）

```
bin\mysqld --install "xampp-mysql" --defaults-file="C:\server\xampp-win32-1.8.1-VC9\xampp\mysql\bin\my.ini"
```

卸载Service
```
    bin\mysqld.exe --remove xampp-mysql
```


### Filezilla在Windows后台执行

安装Service

```
FileZillaFTP\FileZillaServer.exe /servicename xampp-filezilla
FileZillaFTP\FileZillaServer.exe /servicedisplayname xampp-filezilla
FileZillaFTP\FileZillaServer.exe install
```

或者

```
insert/update the following lines into FileZilla Server.xml and then run with /install:
        <Item name="Service name" type="string">newname</Item>
        <Item name="Service display name" type="string">newdisplayname</Item>
```

* 参考：
  * <https://wiki.filezilla-project.org/Command-line_arguments_%28Server%29>
  * <https://forum.filezilla-project.org/viewtopic.php?f=6&t=16015>


### Tomcat在Windows后台执行

安装Service可以利用 tomcat\tomcat_service_install.bat 脚本。
卸载Service 的脚本在相同目录下也能找到tomcat_service_uninstall.bat。
 
但是，发现这2个bat依赖注册表中的jdk安装信息。我在Windows 2003上安装JDK1.6-i586的版本后，注册表（KeyName=HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit）没有数据，囧！！
 
看了下脚本，采用手动设置环境变量，并调用bin\service.bat的方式。

方法如下：

设置环境变量

```
set JAVA_HOME=C:\server\Java\jdk1.6.0_30
set JRE_HOME=%JAVA_HOME%
set CATALINA_HOME=C:\server\xampp-win32-1.8.1-VC9\xampp\tomcat
```

安装Service
.\bin\service.bat install Tomcat7

卸载Service
.\bin\service.bat uninstall Tomcat7

 
#### 如何修改安装Service的名称
 
修改 bin\service.bat 中的PR_DISPLAYNAME和PR_DESCRIPTION，这两个才是在Windows“服务”列表中看到的显示。

 
 
 
## 安全设置
 
* 参考：
  * tutorial on xampp site
    * <http://www.apachefriends.org/en/xampp-windows.html#1221>
  * Securing MySQL: step-by-step
    * <http://www.symantec.com/connect/articles/securing-mysql-step-step>
 
 
如何确认没有安全问题：
http://localhost/security/



## Apache Http Server

### 修改http端口（80）

设置步骤
1. 修改apache/conf/httpd.conf，并保存。
  找到Listen 80
  修改为Listen \<new-port\>
2. 重启httpd
 
* 注意：
  XAMPP 1.7.4 and XAMPP 1.7.7 启动apache的时候，在control pane里边显示有误，不管端口改成什么，都显示：
  Apache started [Port 80]

### 修改SSL端口（443）

修改apache/conf/extra/httpd-ssl.conf并保存。
找到 Listen 443
修改为Listen \<new-port\>
 
 
## MySQL

### 删除所有无关的数据库用户

查看所有用户
SELECT Host, User, Password FROM mysql.user;

删除所有记录，除了root@localhost
DELETE FROM mysql.user WHERE NOT (Host = 'localhost' AND User = 'root');
 
### 设置root密码

```
mysql> UPDATE user SET Password = PASSWORD('newpass') WHERE user = 'root';
mysql> FLUSH PRIVILEGES;
```

### 修改mysqld的端口

在mysql/bin/my.ini中设置mysql的端口
找到服务器的配置区域 [mysqld]
将默认值“port=3306”改成需要的端口，重启mysqld即可。
 
之后客户端登录就要指定服务器端口：

```
mysql -u root --port=7306 -p
```

## xampp集成的管理工具（xampp|security|licenses|phpmyadmin|webalizer|server-status|server-info）
 
可以通过 localhost/xampp 、localhost/security 等地址访问，在httpd设置目录映射。

### 限制只能在localhost访问

在conf/extra/httpd-xampp.conf中配置。

xampp1.8.1开始httpd-xampp.conf文件末尾已经有访问控制的设置，基本可用，不放心的话设置成，只容许localhost即可：
Allow from ::1 127.0.0.1
 
默认的设置代码如下：

```
#
# New XAMPP security concept
#
<LocationMatch "^/(?i:(?:xampp|security|licenses|phpmyadmin|webalizer|server-status|server-info))">
    Order deny,allow
    Deny from all
    Allow from ::1 127.0.0.0/8 \
        fc00::/7 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 \
        fe80::/10 169.254.0.0/16
 
    ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var
</LocationMatch>
```
 
### 限制用户名和密码访问

进入http://localhost/security/xamppsecurity.php
在“XAMPP DIRECTORY PROTECTION (.htaccess)” 区域填写用户名和密码，点击“Make safe the XAMPP directory”
 
生成的密码文件将被保存在：
\xampp\security\xampp.users
 
同时会在xampp对应的几个目录下面的.htaccess中加入相关配置，类似：

```
AuthName "xampp user"
AuthType Basic
AuthUserFile "C:\server\xampp-win32-1.8.1-VC9\xampp\security\xampp.users"
require valid-user
```

### 关闭phpMyAdmin

在httpd.conf中删除对应的配置项，类似：

```
Alias /phpmyadmin "C:/server/xampp-win32-1.8.1-VC9/xampp/phpMyAdmin/"
<Directory "C:/server/xampp-win32-1.8.1-VC9/xampp/phpMyAdmin">
       AllowOverride AuthConfig
       Require all granted
</Directory>
```

删除xampp/phpMyAdmin目录。


## FileZilla FTP Server
 
保证不存在匿名用户。


## Mercury
 
保证不存在匿名用户。
 
 
 
 
 
## 技巧

### 如何查看apache启动失败的详细信息

直接使用命令行启动apache
 
### VMWare 8  的Shared功能与SSL端口冲突

VMWare8的Shared VM功能用到SSL的443端口，和apache冲突。
关闭Shared VM功能解决此问题：
Preference  >>  Shared VMs  >>  Disable Sharing
 
 
### xampp 1.7.7在windows7下无法启动Service

权限问题，直接运行xampp-control-panel 2.5无法注册Service成功。
使用“xampp-control-3-beta.exe”来启动FTP吧！

