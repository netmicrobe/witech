---
layout: post
title: CentOS上安装ImageMagick
categories: [cm, linux]
tags: [image-magick, centos]
---

* 参考： 
  * [csdn.net/gaofuqi - centos安装ImageMagick](https://blog.csdn.net/gaofuqi/article/details/26698547)
  * [How to Install ImageMagick on CentOS & RHEL](https://tecadmin.net/install-imagemagick-on-centos-rhel/)
  * [Imagemagick 源码下载地址](http://www.imagemagick.org/download/)



## 从源码安装 ImageMagick-6

~~~
wget http://www.imagemagick.org/download/ImageMagick-6.9.10-86.tar.gz
tar xvf ImageMagick-6.9.10-86.tar.gz

cd ImageMagick-6.9.10-86
yum install libjpeg* libpng* freetype* gd*
./configure
make
make install

# 检查安装情况
convert -version
~~~

输入 `convert -resize 100x100 src.jpg des.jpg`  执行成功，表明安装成功。


### 配置pkg-config

pkg-config是一个在源代码编译时查询已安装的库的使用接口的计算机工具软件。

`pkg-config --list-all | grep ImageMagick` 找不到的话，编译其他依赖Imagemagic的源码（例如，ruby 的 rmagick）的时候，会报错：`Can't find ImageMagick with pkg-config`

配置方法：

在 `.bashrc` 文件中配置 pkg-config 的查找路径 `PKG_CONFIG_PATH`

~~~
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PAK_CONFIG_PATH
~~~

### ldconfig 配置 ，解决报错：requiring "RMagick" is deprecated

* 问题
  执行rake报错：[DEPRECATION] requiring "RMagick" is deprecated. Use "rmagick" instead

* 解决
  `ldconfig /usr/local/lib`

* 说明
   `ldconfig`命令的用途主要是在默认搜寻目录/lib和/usr/lib以及动态库配置文件/etc/ld.so.conf内所列的目录下，
   搜索出可共享的动态链接库（格式如lib*.so*）,进而创建出动态装入程序(ld.so)所需的连接和缓存文件。
   
   缓存文件默认为`/etc/ld.so.cache`，此文件保存已排好序的动态链接库名字列表，
   为了让动态链接库为系统所共享，需运行动态链接库的管理命令ldconfig，此执行程序存放在/sbin目录下。

  ldconfig通常在系统启动时运行，而当用户安装了一个新的动态链接库时，**就需要手工运行这个命令**。








