---
layout: post
title: composer执行报错，无法连接服务器。configuration does not allow connections。 设置包下载服务器。
categories: [ cm, php ]
tags: [composer]
---

* 参考
  * [composer创建新项目报错](http://www.cnblogs.com/toxufe/p/5888604.html)


### 报错

~~~
Your configuration does not allow connections to http://packagist.org/packages.json. See https://getcomposer.org/do
c/06-config.md#secure-http for details.
~~~

### 修复方法：换http源，更改配置不要使用https加密连接

~~~
$ composer config -g repo.packagist composer http://packagist.phpcomposer.com
$ composer config -g secure-http false
~~~












