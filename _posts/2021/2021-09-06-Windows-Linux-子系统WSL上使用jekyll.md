---
layout: post
title: 2021-09-03-Windows-Linux-子系统WSL上使用jekyll.md
categories: [ cm, windows ]
tags: [wsl]
---

* 参考
  * [Jekyll Setup on WSL Running Ubuntu](https://www.vgemba.net/blog/Setup-Jekyll-WSL/)
  * [Fadeer的日志 - Windows WSL 下配置 jekyll 运行环境](https://fadeer.github.io/%E5%B7%A5%E4%BD%9C/2020/05/02/wsl-jekyll.html)
  * [Use Jekyll on Windows via the Subsystem for Linux (WSL)](https://sebastian.teumert.net/blog/use-jekyll-on-windows-via-the-subsystem-for-linux-wsl-2020)




1. 安装ruby、编译工具等
    ~~~
    sudo apt-get install -y ruby-full build-essential zlib1g-dev
    ~~~

1. 以下建议 `sudo -i` 成 root 用户安装，我也不知道为啥正常用户下无法`bundle exec jekyll serve`，老报 Permission Denied， windows的文件权限很迷。

1. 配置 gems 源到国内
    ~~~
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
    ~~~


1. 在 `.bashrc`  配置 gems 路径
    ~~~
    echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
    echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    ~~~

1. 安装bundler
    ~~~
    gem install bundler -v 1.17.3
    ~~~

1. 到jekyll的blog 的根目录下安装gems
    ~~~
    bundle install
    ~~~

## 排忧解难

### 执行 `bundle exec jekyll serve` 报错 `windows wsl Error:  Permission denied @ rb_sysopen`

`jekyll 3.3.1 | Error:  Permission denied @ apply2files`

没找到什么好的，解决版本，我 `sudo -i` 到root，重装了bundle和其他gems，在root下执行 jekyll serve 就好了。






