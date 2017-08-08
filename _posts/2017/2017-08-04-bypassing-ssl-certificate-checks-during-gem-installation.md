---
layout: post
title: 执行 gem install 时，忽略 SSL 证书检查
categories: [dev, ruby]
tags: [ruby, gems, https, ssl]
---

* 参考： http://dharampal.in/2012/06/28/bypassing-ssl-certificate-checks-during-gem-installation/

## 现象

按照 gem 包有时候，会报错： ssl certificate error

## 解决

修改 .gemrc

添加

~~~
:ssl_verify_mode: 0
~~~

* windows 上 .gemrc 存放在： c:\users\your-acount 下面

