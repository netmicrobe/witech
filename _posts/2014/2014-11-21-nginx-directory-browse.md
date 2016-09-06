---
layout: post
title: nginx 设置目录文件浏览  directory autoindex
description: 
categories: [cm, nginx]
tags: [cm, nginx]
---

```
server {
        listen   80;
        server_name  domain.com www.domain.com;
        access_log  /var/...........................;
        root   /path/to/root;
        location / {
                index  index.php index.html index.htm;
        }
        location /somedir {
               autoindex on;
        }
}
```