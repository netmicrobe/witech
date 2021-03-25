---
layout: post
title: 在 CentOS 上使用 openssh
categories: [cm, linux, centos]
tags: [cm, linux, centos, openssh, systemctl, chkconfig]
---

* 参考
    * [How To Install / Enable OpenSSH On CentOS 7](https://phoenixnap.com/kb/how-to-enable-ssh-centos-7)
    * [CentOS SSH Installation And Configuration](https://www.cyberciti.biz/faq/centos-ssh/?__cf_chl_jschl_tk__=3c059b085365ef59dff95ecf98dac5f606e373ff-1616642376-0-AZB582Du5w_YXUwwe5Qthumr_F694pIeKv5lZ_q5_kyR4DgjxKyRd-uSiAMVUOG1Rgqu5jPCD56sO34eOiVRr57oCtBHeNXmyJtCIpqrT5ciR2UTNWYl2WyxzPetOPgtLjGrYAPb77jlD6dKXD8270u34YI31TQbm7JqxZVwslZI7E1C_W4pBeFHAI2xZEWCGp4vp_cvAg06joiLpljDgj2eq_6NwQV_MqRpeBcS0aflbrgcXjsDGTV7Qbq9MY2kxCSjtRMjg3gB7WH5C3uSSh43nGInXJy_t6_UpXZDUZF-EnYJD_b2ByQlSp8D9TE_-cPOu2d-U5UC39CMOgxZAvJlDaJnPLbvgOT_FPJw4Z1Ogh8gt-wNKy2rdDp5HEP59mhNzMxq_gRR26KQ7nHuZe4)
    * []()
    * []()

## 安装

### 查看是否安装

~~~
yum list \*openssh\*
~~~


### CentOS 7 启动和配置

* 安装

~~~
sudo yum –y install openssh-server openssh-clients
~~~

* 启动、关闭、状态查询

~~~
sudo systemctl start sshd
sudo systemctl status sshd
systemctl stop sshd
~~~

* 自启动

~~~
# 自启动
sudo systemctl enable sshd
# 关闭自启动
sudo systemctl disable sshd
~~~



### CentOS 6 启动和配置

#### 启动、关闭、状态查询

* 状态：service sshd status
* 启动：service sshd start
* 关闭：service sshd stop


#### 开机自启动

* 查看状态：chkconfig --list sshd
* 设置： chkconfig --level 2345 sshd on




## 配置

~~~
sudo vim /etc/ssh/sshd_config
~~~

To disable root login: `PermitRootLogin no`

Change the SSH port to run on a non-standard port. For example: `Port 2002`

~~~
service sshd restart
~~~



### 防火墙配置


To restrict IP access, edit the iptables file by typing:

`sudo vim /etc/sysconfig/iptables`

To allow access using the port defined in the sshd config file, add the following line to the iptables file:

~~~
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 2002 -j ACCEPT
~~~

To restrict access to a specific IP, for example 133.123.40.166, edit the line as follows:

~~~
-A RH-Firewall-1-INPUT -s 133.123.40.166 -m state --state NEW -p tcp --dport 2002 -j ACCEPT
~~~

If your site uses IPv6, and you are editing ip6tables, use the line:

~~~
-A RH-Firewall-1-INPUT -m tcp -p tcp --dport 2002 -j ACCEPT
~~~

Restart iptables to apply the changes: `sudo systemctl restart iptables`












