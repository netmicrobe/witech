---
layout: post
title: ubuntu、debian 开启ssh服务，关联 service, systemctl
categories: [cm, linux]
tags: [ubuntu, openssh, ufw]
---

* 参考： 
    * [How to Enable SSH on Ubuntu 18.04](https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/)
    * []()
    * []()

## Ubuntu

### Ubuntu 18

~~~
sudo apt install openssh-server
sudo systemctl status ssh
sudo systemctl enable ssh
sudo ufw allow ssh
~~~

## Debian

* 参考： 
    * [Ubuntu中利用 sysv-rc-conf 设置开机自启动](https://blog.csdn.net/u013554213/article/details/86584705#:~:text=sysv-rc-conf%20%E5%91%BD%E4%BB%A4%E6%98%AF%E5%8F%AF%E4%BB%A5%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%20%E4%B8%AD%E5%BC%80%E6%9C%BA%E8%87%AA%E5%90%AF%E5%8A%A8%20%E7%9A%84%E5%90%8E%E5%8F%B0%E6%9C%8D%E5%8A%A1%E5%99%A8%E3%80%82.%20sysv-rc-conf%20-%20Run-level%20configuration,%E8%BF%90%E8%A1%8C%EF%BC%8C%E4%BC%9A%E5%87%BA%E7%8E%B0%E4%B8%80%E4%B8%AA%E7%AE%80%E6%98%93%E7%95%8C%E9%9D%A2%E7%9A%84%EF%BC%8C%E7%84%B6%E5%90%8E%E9%80%89%E6%8B%A9%E9%9C%80%E8%A6%81%E5%BC%80%E5%90%AF%E6%88%96%E7%A6%81%E7%94%A8%E7%9A%84%20%E5%AF%B9%E5%BA%94%E7%9A%84%E8%BF%90%E8%A1%8C%E7%BA%A7%E5%88%AB...%20Ubuntu%2020%20%E4%B8%8B%E5%AE%89%E8%A3%85%20sysv-rc-conf%20%E6%8A%A5%E9%94%99%EF%BC%9A.%20ForestCat%E7%9A%84%E4%B8%93%E6%A0%8F.)
    * []()

### Debian Linux 9/10/11

~~~sh
apt-get update
apt-get install openssh-server

# 看看有没启动
netstat -tulpn | grep :22
service ssh status

# 起停操作
service ssh stop
service ssh start
service ssh restart
service ssh status
# OR
/etc/init.d/ssh stop
/etc/init.d/ssh start
/etc/init.d/ssh restart
/etc/init.d/ssh status
~~~

~~~sh
# 防火墙
/sbin/iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables-save > /path/to/your.firewall.conf

# OR
sudo ufw allow ssh
~~~

* 配置文件

~~~sh
vi /etc/ssh/sshd_config
~~~

* 开机自启动

~~~sh
# 查看开机启动设置
sysv-rc-conf --list ssh

# 开启自启动
sysv-rc-conf ssh on

# 关闭自启动
sysv-rc-conf ssh off
~~~






