---
layout: post
title: CentOS 上编译 ruby
categories: [cm, linux]
tags: [centos, ruby, source, build]
---


## 编译 ruby


* [下载Ruby](https://www.ruby-lang.org/en/downloads/)
* [building-from-source - ruby-lang](https://www.ruby-lang.org/en/documentation/installation/#building-from-source)

~~~ shell
yum install openssl openssl-devel readline-devel gdbm-devel mysql-devel ImageMagick-devel sqlite-devel
./configure --prefix=/opt/ruby/ruby-2.3.4
make
make install
~~~


## 编译 apache passenger

<https://www.phusionpassenger.com/library/install/apache/install/oss/rubygems_norvm/>


