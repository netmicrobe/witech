---
layout: post
title: 在 linux 上编写 ruby 脚本/命令行程序
categories: [dev, ruby]
tags: [ruby, shell, linux]
---


## 如何设置 shell shebang 在 RVM 的环境下

* 问题描述
rvm 的 ruby 不在常见的 bin 目录下，例如，典型的路径：/usr/local/rvm/rubies/ruby-2.3.3/bin/ruby

* 解决方法

设置 evn 变量 ruby，编辑 /etc/profile ，添加

```shell
export ruby=`which ruby`
```

shebang 写成

~~~shell
#!/bin/env ruby
~~~


