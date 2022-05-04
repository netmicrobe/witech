---
layout: post
title: debian 11 / bullseye 使用
categories: [cm, linux]
tags: []
---

* 参考： 
    * [Debian官网](https://www.debian.org/)
    * [server-world.info - Debian11 配置参考](https://www.server-world.info/en/note?os=Debian_11&p=download)
    * []()
    * []()
    * []()
    * []()


## Debian 11 下载

* [Debian CDs/DVDs archive](https://cdimage.debian.org/cdimage/archive/)
* [debian-11.3.0-amd64-netinst.iso](https://laotzu.ftp.acc.umu.se/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso)
* [debian-11.3.0 bt 下载](https://cdimage.debian.org/debian-cd/current-live/amd64/bt-hybrid/)
* [debian-live-11.2.0-amd64-xfce.iso](https://gemmei.ftp.acc.umu.se/cdimage/archive/11.2.0-live/amd64/iso-hybrid/debian-live-11.2.0-amd64-xfce.iso)
* []()


## 常用设置

### 使用国内源


* 参考： 
    * []()
    * []()
    * []()
    * []()

~~~sh
sed -i "s@http://\(deb\|security\).debian.org@https://mirrors.xxx.com@g" /etc/apt/sources.list
~~~

#### 国内常见镜像站点

阿里云镜像站 

~~~sh
deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
~~~


腾讯云镜像站

~~~sh
deb https://mirrors.tencent.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.tencent.com/debian/ bullseye main non-free contrib
deb https://mirrors.tencent.com/debian-security/ bullseye-security main
deb-src https://mirrors.tencent.com/debian-security/ bullseye-security main
deb https://mirrors.tencent.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.tencent.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.tencent.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.tencent.com/debian/ bullseye-backports main non-free contrib
~~~
 

网易镜像站 

~~~sh
deb https://mirrors.163.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.163.com/debian/ bullseye main non-free contrib
deb https://mirrors.163.com/debian-security/ bullseye-security main
deb-src https://mirrors.163.com/debian-security/ bullseye-security main
deb https://mirrors.163.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.163.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.163.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.163.com/debian/ bullseye-backports main non-free contrib
~~~
 

华为镜像站

~~~sh
deb https://mirrors.huaweicloud.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.huaweicloud.com/debian/ bullseye main non-free contrib
deb https://mirrors.huaweicloud.com/debian-security/ bullseye-security main
deb-src https://mirrors.huaweicloud.com/debian-security/ bullseye-security main
deb https://mirrors.huaweicloud.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.huaweicloud.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.huaweicloud.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.huaweicloud.com/debian/ bullseye-backports main non-free contrib
~~~
 

清华大学镜像站

~~~sh
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
~~~
 

中科大镜像站

~~~sh
deb https://mirrors.ustc.edu.cn/debian/ bullseye main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian/ bullseye main contrib non-free

deb https://mirrors.ustc.edu.cn/debian/ bullseye-updates main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian/ bullseye-updates main contrib non-free

deb https://mirrors.ustc.edu.cn/debian/ bullseye-backports main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian/ bullseye-backports main contrib non-free

deb https://mirrors.ustc.edu.cn/debian-security/ bullseye-security main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian-security/ bullseye-security main contrib non-free
~~~


## 技巧

### Fix “Username is not in the sudoers file. This incident will be reported”

* 参考
    * [Username is not in the sudoers file. This incident will be reported](https://unix.stackexchange.com/questions/179954/username-is-not-in-the-sudoers-file-this-incident-will-be-reported)
    * [Fix `Username Is Not In The Sudoers File. This Incident Will Be Reported` On Debian](https://www.linuxuprising.com/2019/09/fix-username-is-not-in-sudoers-file.html)
    * []()

* 问题

    Debian 安装完成之后，执行sudo报错，`Username is not in the sudoers file. This incident will be reported`

* 解决

    ~~~sh
    su -
    usermod -aG sudo your-account-name
    ~~~

    重启下就好了




## As a Server

### 安装 openssh

~~~sh
sudo apt install openssh-server

sudo systemctl start ssh
sudo systemctl enable ssh
~~~

### 安装 Oracle mysql

去 Oracle 网站下载，下载要登录帐号， <https://dev.mysql.com/downloads/repo/apt/>

~~~sh
wget https://dev.mysql.com/get/mysql-apt-config_0.8.18-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.18-1_all.deb

# 出现图形界面后，选择 Server，不要选择 cluster

# 安装
sudo apt update
sudo apt install mysql-common mysql-server
~~~

### 安装 rvm

~~~sh
sudo apt install gnupg gnupg2
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

\curl -sSL https://get.rvm.io | bash -s stable
~~~

* debian 11 无法 安装 2.3

    ~~~
    rvm install 2.3
    ...
    E: Package 'libssl1.0-dev' has no installation candidate
    ~~~

* 安装 2.4

~~~sh
rvm install 2.4
rvm use 2.4 --default
~~~

















