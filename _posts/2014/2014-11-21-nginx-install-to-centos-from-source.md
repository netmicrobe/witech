---
layout: post
title: 在centOS从源码安装nginx
description: 
categories: [cm, nginx]
tags: [cm, nginx]
---

在centOS从源码安装nginx

```
yum -y install gcc automake autoconf libtool make
yum install gcc gcc-c++
yum install pcre-devel zlib-devel openssl-devel

./configure --prefix=/opt/nginx-1.7.7
make
make install
```

启动：

/opt/nginx-1.7.7/sbin/nginx -c /opt/nginx-1.7.7/conf/nginx.conf