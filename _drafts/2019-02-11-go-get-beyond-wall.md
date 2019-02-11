---
layout: post
title: go get 设置
categories: [dev, go]
tags: [go, go-lang]
---

* 参考： 
  * <http://www.cnblogs.com/simplelovecs/p/5312097.html>
  * <https://blog.yuantops.com/tech/emacs-config-go-dev-environ/>



一般 go get 命令会自动帮我们下载源码、编译、安装命令，如果托管源码的网站被block了(如gopkg.in)，整个过程就会卡住，卡到人抓狂。


### 设置代理

临时设置Windows下代理：

~~~
set http_proxy=http://127.0.0.1:8088/
set https_proxy=https://127.0.0.1:8088/
~~~

临时设置Linux下代理：

~~~
http_proxy=http://127.0.0.1:8088/
https_proxy=https://127.0.0.1:8088/
~~~




