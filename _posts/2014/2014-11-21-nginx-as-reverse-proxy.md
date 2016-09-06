---
layout: post
title: nginx , 设置反向代理
description: 
categories: [cm, nginx]
tags: [cm, nginx]
---


## 安装nginx

参考：http://nginx.org/en/linux_packages.html

在 /etc/apt/source.list 添加source 可下载最新的nginx包：

```
deb http://nginx.org/packages/ubuntu/ codename nginx
deb-src http://nginx.org/packages/ubuntu/ codename nginx
```

配置完成，执行：

```
apt-get update
apt-get install nginx
```

## 配置nginx

在 /etc/nginx/conf.d 中添加文件 apache.conf

```
server {
    listen       8089;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;

    location / {
        proxy_pass http://localhost;
    }

}
```

【注】 /etc/nginx/nginx.conf 是nginx的主配置，其中写明 conf.d 目录下的所有 *.conf 都有效。


## 启动nginx或者reload设置

启动： sudo /etc/init.d/nginx start

或者，reload设置： nginx -s reload

