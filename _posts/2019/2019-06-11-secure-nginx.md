---
layout: post
title: nginx 安全防护
categories: [ cm, nginx ]
tags: [security, secure]
---


---

* 参考： 
  * [The Ultimate Guide to Secure, Harden and Improve Performance of Nginx Web Server](https://www.tecmint.com/nginx-web-server-security-hardening-and-performance-tips/)

---



### 添加 basic authentication




### 隐藏版本号

* [How to Hide Nginx Server Version in Linux](https://www.tecmint.com/hide-nginx-server-version-in-linux/)

how hide Nginx server version on error pages and in the “Server HTTP” response header field in Linux. 


修改 /etc/nginx/nginx.conf 添加 `server_tokens off;`

~~~
http {
    ...
    server_tokens off;
    ...
}
~~~

然后重启nginx。

这个方法只能隐藏“版本号”， “nginx” 的字样还是继续显示的。要修改这个服务器标识，必须重新编译nginx，添加 `--build=name` 来设置你需要的名字。





















