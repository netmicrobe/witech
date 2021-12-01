---
layout: post
title: jekyll在manjaro升级后报错
categories: [ study ]
tags: [jekyll, rvm, ruby, arch-linux, libffi]
---

* 参考：
  * []()
  * []()


## 问题：提示找不到 libffi.so.7

执行 `bundle exec jekyll serve --incremental` 报错

~~~
/home/jack/.rvm/gems/ruby-2.4.10/gems/ffi-1.13.1/lib/ffi.rb:6:in `require': libffi.so.7: cannot open shared object file: No such file or directory - /home/jack/.rvm/gems/ruby-2.4.10/gems/ffi-1.13.1/lib/ffi_c.so (LoadError)
~~~

### 原因

Manjaro 滚动升级，`libffi 3.4.2-4`的版本提供的是 `/usr/lib/libffi.so.8`，原来低版本的 `libffi.so.7` 找不到文件了。

### 解决办法：使用rvm重新编译安装 ruby

~~~bash
# 找到当前使用的ruby
rvm list

=* ruby-2.4.10 [ x86_64 ]


# 使用rvm重新编译安装
rvm reinstall --disable-binary 2.4.10
~~~

### 参考

<https://askubuntu.com/a/1319486>







## 问题：图片路由错误，不显示

执行`bundle exec jekyll serve --incremental`正常，图片不显示，报错：

~~~
    Server address: http://127.0.0.1:5555/
  Server running... press ctrl-c to stop.
[2021-12-01 11:02:12] ERROR Errno::ECONNRESET: Connection reset by peer @ io_fillbuf - fd:17 
        /home/wi/.rvm/rubies/ruby-2.4.10/lib/ruby/2.4.0/webrick/httpserver.rb:82:in `eof?'
        /home/wi/.rvm/rubies/ruby-2.4.10/lib/ruby/2.4.0/webrick/httpserver.rb:82:in `run'
        /home/wi/.rvm/rubies/ruby-2.4.10/lib/ruby/2.4.0/webrick/server.rb:308:in `block in start_thread'
~~~


### 解决方法

删除 `.jekyll-cache` 和  `_site` 文件夹后，重新在执行jekyll


### 参考

<https://stackoverflow.com/a/68626699>






















