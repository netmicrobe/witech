---
layout: post
title: 查看DNS域名对应的IP，清除DNS缓存
categories: [cm, network, dns]
tags: [nslookup, windows, network]
---

## Windows7

### 命令行检查dns解析信息

```
C:\Users\ethan>nslookup open.play.cn
服务器:  a.center-dns.jsinfo.net
Address:  218.2.135.1


非权威应答:
名称:    open.play.cn
Addresses:  180.96.49.16
          180.96.49.15
          202.102.39.23
```

### 清除DNS缓存

~~~
ipconfig /flushdns
~~~




## CentOS

安装 `bind-utils` 后可以使用 `nslookup` 命令。

~~~
yum install bind-utils
~~~

you can search for what package provides a command using the yum provides command:

~~~
sudo yum provides '*bin/nslookup'
~~~















