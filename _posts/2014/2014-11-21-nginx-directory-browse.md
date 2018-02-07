---
layout: post
title: nginx 设置目录文件浏览  directory autoindex
description: 
categories: [cm, nginx]
tags: [cm, nginx]
---

* 参考： 
  * <http://www.swiftyper.com/2016/12/08/nginx-autoindex-configuration/>

### 使用 Nginx 自带的 ngx_http_autoindex_module 模块，添加 `autoindex on;`即可。

~~~
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
~~~

### 除了 autoindex 外，该模块还有两个可用的字段：


~~~ conf
autoindex_exact_size on;
# 默认为 on，以 bytes 为单位显示文件大小；
# 切换为 off 后，以可读的方式显示文件大小，单位为 KB、MB 或者 GB。

autoindex_localtime on;
# 默认为 off，以 GMT 时间作为显示的文件时间；
# 切换为 on 后，以服务器的文件时间作为显示的文件时间。
~~~


### 中文乱码问题

~~~ conf
location /download {
    # ... 其它同上
    charset utf-8,gbk; # 两个字符集间不要加空格
}
~~~








