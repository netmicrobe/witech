---
layout: post
title: git config 设置 proxy 代理
categories: [ cm, git ]
tags: [ proxy ]
---

### 设置 http.proxy

~~~
git config --global http.proxy http://10.10.10.10:8080
~~~

如果需要用户名密码的话，则设置：

~~~
git config –global http.proxy http://user:password@http://10.10.10.10:8080 
~~~

### 查看 http.proxy 设置

~~~
git config –get –global http.proxy
~~~

### 取消 http.proxy 设置

~~~
git config --globa --unset http.proxy
~~~











