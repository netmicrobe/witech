---
layout: post
title: RubyGems 使用
categories: [dev, ruby]
tags: 
  - ruby
  - gems
---


* 官网： https://docs.rubygems.org/
* 指南：http://guides.rubygems.org/

>RubyGems 是 Ruby 的包管理系统。从 1.9 开始，Ruby 发布包就包含了 RubyGems。
>The software package is called a “gem” and contains a package Ruby application or library.

### 查看本机的RubyGem环境：

~~~
# gem environment
~~~

### 查看某个gem的安装位置：

~~~
gem path rails
=> /home/cbliard/.rvm/gems/ruby-2.1.5/gems/rails-4.0.13
gem path rails '< 4'
=> /home/cbliard/.rvm/gems/ruby-2.1.5/gems/rails-3.2.21
~~~

在 windows 的 1.8.29 不支持 path 命令，转而使用 gem which <gem-name>

### 配置 Gems 的下载源

~~~
查看目前的下载源： # gem sources
添加下载源： # gem sources --add https://ruby.taobao.org
~~~

### 查询

query 命令支持正则表达式

查询本地gems： gem query -l

查询远程gems： gem query -r


Search available gems, e.g.:

gem search STRING --remote



### 安装

~~~
gem install mygem
gem install mygem -v 1.1.0
~~~

### 卸载

~~~
gem uninstall mygem
~~~

### Create RDoc documentation for all gems

~~~
gem rdoc --all
~~~

### Download but do not install a gem:

~~~
gem fetch mygem
~~~


### 打包gem

~~~
gem build mygem.gemspec
~~~