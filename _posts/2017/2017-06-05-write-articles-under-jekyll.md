---
layout: post
title: 使用 Jekyll 编写文章
categories: [cm, git, gitlab]
tags: [git, gitlab, pages, jekyll, jekyll-themes]
---

## Windows 上安装 jekyll 环境



### 下载 Ruby 2.1.7 并解压

* 32位Windows： <http://192.168.251.72/ftpwww/devel/rails/windows/ruby-2.1.7/ruby-2.1.7-i386-mingw32.7z>
* 64位Windows： <http://192.168.251.72/ftpwww/devel/rails/windows/ruby-2.1.7/ruby-2.1.7-x64-mingw32.7z>



### 下载 Devkit 并解压

* 32位Windows： <http://192.168.251.72/ftpwww/devel/rails/windows/Devkit_for_Ruby2.0/Devkit_for_Ruby2.0_and_above_32bits/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe>
* 64位Windows： <http://192.168.251.72/ftpwww/devel/rails/windows/Devkit_for_Ruby2.0/Devkit_for_Ruby2.0_and_above_64bits/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe>




### 设置 PATH 环境变量

RUBY_HOME=D:\where-you-unzip-ruby\ruby-2.1.7-x64-mingw32

DEVKIT_HOME=D:\where-you-unzip-devkit\Devkit_for_Ruby2.0_and_above_64bits

MINGW_HOME=D:\where-you-unzip-devkit\Devkit_for_Ruby2.0_and_above_64bits\mingw

PATH=原来的PATH设置;%RUBY_HOME%\bin;%DEVKIT_HOME%\bin;%MINGW_HOME%\bin;


* **注意** 安装了cygwin的时候，不要选择将cygwin的bin目录加入Windows的Path，否则会造成混乱，在command中用的linux 命令也不知道是什么版本啦！！！





## 在 Gitlab 上已有的文档项目上编写文档


### 下载文档项目到本地

```
$ git clone http://someone@gitlab.com/newbies/pages-how-to.git
```




### 在 _posts 文件夹下编写文档

例如：

1） 创建文件，2017-06-05-write-articles-under-jekyll.md

* 说明：
* 文件名不能包含中文，单词之间用横杠"-"分隔，格式：<日期>-<englisth-description>.md
* md 表示 markdown 语法的文档


2） 编写内容

<pre class="highlight">
---
layout: post
title: 使用 Jekyll 编写文章
categories: [cm, git, gitlab]
tags: [git, gitlab, pages, jekyll, jekyll-themes]
---

## Windows 上安装 jekyll 环境

... ...

## 在 Gitlab 上已有的文档项目上编写文档

### 下载文档项目到本地

```
$ git clone http://wangyi@192.168.251.72:8099/newbies/pages-how-to.git
```

### 在 _posts 文件夹下编写文档

...
</pre>



### 本地调试


```shell
项目根目录> bundle install  # 只需要执行一次，后面就不要了
项目根目录> bundle exec jekyll serve --port=6666 --watch # watch 参数表示只要文档有更新，自动编译
```

打开浏览器，访问 http://localhost:6666 就行拉


### 发布

```shell
git push origin master
```

打开浏览器，访问 pages 网站地址就好拉





