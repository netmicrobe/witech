---
layout: post
title: 从 ssh 通过 hostname 在局域网中访问服务器
categories: [cm, linux]
tags: [linux, hostname, ssh]
---

## 查看 hostname

```
cat /proc/sys/kernel/hostname
```

或者

```
cat /etc/sysconfig/network
```

或者

```
hostname
```

## 利用 hostname 从 ssh 登录

hostname 后面加 “.local” 即可

```
ssh username@hostname.local
```


## 修改hostname

* 参考： <http://blog.csdn.net/liangziyisheng/article/details/8194196>

### CentOS

```
vi /etc/sysconfig/network
修改HOSTNAME=YOUR-NEW-HOST-NAME

hostname YOUR-NEW-HOST-NAME
hostname

vi /etc/hosts
更新成新的hostname
```

#### CentOS 7

* 参考
  * <https://www.cyberciti.biz/faq/rhel-redhat-centos-7-change-hostname-command/>
  * <https://www.tecmint.com/set-change-hostname-in-centos-7/>

~~~ shell
hostnamectl status

hostnamectl set-hostname your-host-name
# 或者手动修改 /etc/hostname
~~~


