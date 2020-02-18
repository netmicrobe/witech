---
layout: post
title: centos7上使用vsftpd
categories: [cm, ftp]
tags: [vsftpd, centos]
---

* 参考： 
  * [简书 - lancely - CentOS 7 安装 FTP 服务](https://www.jianshu.com/p/05dc6455b513)
  * [ftp vsftpd 530 login incorrect 解决办法汇总](https://blog.csdn.net/wlchn/article/details/50855447)
  * []()
  * []()
  * []()
  * []()
  * []()



## 安装配置

### 安装 vsftpd

~~~
yum -y install vsftpd
vsftpd -v
~~~

### 创建用户

~~~
# 添加用户 vsftp 
# -d：指定用户主目录 
# -s：指定用户所用的shell，此处为/sbin/nologin，表示不登录
shell> useradd vsftp -d /home/vsftp -s /sbin/nologin
shell> passwd vsftp
~~~

### 修改配置

`vim /etc/vsftpd/vsftpd.conf`

~~~
anonymous_enable=NO    # 是否允许匿名访问
local_enable=YES      # 是否允许使用本地帐户进行 FTP 用户登录验证
write_enable=YES
local_umask=022      # 设置本地用户默认文件掩码022
dirmessage_enable=YES
xferlog_enable=YES     # 启用上传和下载的日志功能，默认开启。
connect_from_port_20=YES
xferlog_std_format=YES
data_connection_timeout=12000
ftpd_banner=Welcome to my FTP service.
chroot_local_user=YES   # 是否限定用户在其主目录下（NO 表示允许切换到上级目录）
listen=NO
listen_ipv6=YES
pam_service_name=vsftpd
userlist_enable=NO
tcp_wrappers=YES
allow_writeable_chroot=YES  # 如果启用了限定用户在其主目录下需要添加这个配置，解决报错 500 OOPS: vsftpd: refusing to run with writable root inside chroot()
~~~



### 启动

~~~
systemctl start vsftpd.service
~~~


### ftp vsftpd 530 login incorrect 解决

检查 `/etc/pam.d/vsftpd`

`vim /etc/pam.d/vsftpd`

注释掉  `#auth    required pam_shells.so`



### 补充：安全设置

#### SELinux

~~~
# 查看当前配置
shell> getsebool -a |grep ftp
# 设置 ftp 可以访问 home 目录
shell> setsebool -P ftp_home_dir=1
# 设置 ftp 用户可以有所有权限
shell> setsebool -P allow_ftpd_full_access=1
~~~

或者关闭 SELinux

~~~
shell> setenforce 0  
~~~



#### 设置防火墙

~~~
# 允许 ftp 服务
shell> firewall-cmd --permanent --zone=public --add-service=ftp
# 重新载入配置
shell> firewall-cmd --reload
~~~




## 访问FTP

### 包含用户名密码的URL格式

~~~
ftp://user_name:password@hostname/file_path
~~~

