---
layout: post
title: 在RedHat企业版中使用yum
categories: [cm, linux]
tags: [linux, yum, RHEL, Redhat]
---


由于 redhat的yum在线更新是收费的，如果没有注册的话不能使用，如果要使用，需将redhat的yum卸载后，重启安装，再配置其他源.


## 一、删除redhat原有的yum

```
rpm -aq | grep yum | xargs rpm -e --nodeps

rm -rf /var/cache/yum/*

```

## 二、下载yum所需的所有rpm包

```
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/yum-3.2.22-40.el5.centos.noarch.rpm
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/yum-metadata-parser-1.1.2-4.el5.x86_64.rpm
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/yum-fastestmirror-1.1.16-21.el5.centos.noarch.rpm
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/python-iniparse-0.2.3-6.el5.noarch.rpm
```

或者

```
wget http://mirrors.aliyun.com/centos/5/os/x86_64/CentOS/yum-3.2.22-40.el5.centos.noarch.rpm
wget http://mirrors.aliyun.com/centos/5/os/x86_64/CentOS/yum-metadata-parser-1.1.2-4.el5.x86_64.rpm
wget http://mirrors.aliyun.com/centos/5/os/x86_64/CentOS/yum-fastestmirror-1.1.16-21.el5.centos.noarch.rpm
wget http://mirrors.aliyun.com/centos/5/os/x86_64/CentOS/python-iniparse-0.2.3-6.el5.noarch.rpm
```

## 三、先安装python环境：

```
rpm -ivh python-iniparse-0.2.3-6.el5.noarch.rpm
```

## 四、安装所有的yum包：

```
rpm -ivh yum-3.2.22-40.el5.centos.noarch.rpm yum-metadata-parser-1.1.2-4.el5.x86_64.rpm yum-fastestmirror-1.1.16-21.el5.centos.noarch.rpm
yum clean all
```

## 五、下载配置文件

* 下载地址
  * http://mirrors.163.com/.help/CentOS-Base-163.repo
    gpgkey=file:///etc/pki/rpm-gpg
    替换为：
    gpgkey=http://mirrors.163.com/centos
  * http://mirrors.aliyun.com/repo/Centos-5.repo
    * 参考： http://www.cnblogs.com/whc321/p/5552176.html

对于RHEL 5.8 x86_64，将163 repo中的“$basearch”替换为"x86_64"，将“$releasever”替换为"5"，要全文替换。

处理完成后，文件拷贝成 /etc/yum.repos.d/CentOS-Base.repo

## 六、执行 yum update



## 参考：

* <http://www.linuxidc.com/Linux/2010-12/30554.htm>
* <http://blog.sina.com.cn/s/blog_66fd56ee010113lp.html>
* <http://www.linuxidc.com/Linux/2010-11/29650.htm>
* <http://blog.itpub.net/25313300/viewspace-708509>

## 附件

[CentOS-Base-163.repo](/wifiles/RHEL/CentOS-5-use-yum/CentOS-Base-163.repo)
[CentOS-5-Base-163.repo](/wifiles/RHEL/CentOS-5-use-yum/CentOS-5-Base-163.repo)
[Centos-5.repo - 阿里云](/wifiles/RHEL/CentOS-5-use-yum/Centos-5.repo)








