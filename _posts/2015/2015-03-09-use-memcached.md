---
layout: post
title: 部署memcached
description: 
categories: [cm, memcached]
tags: [cm, memcached]
---

1.分别把memcached和libevent下载回来，放到 /tmp 目录下：

{%  highlight shell %}
# cd /tmp
# wget http://www.danga.com/memcached/dist/memcached-1.2.0.tar.gz
# wget http://www.monkey.org/~provos/libevent-1.2.tar.gz
{% endhighlight %}

2.先安装libevent：

{%  highlight shell %}
# tar zxvf libevent-1.2.tar.gz
# cd libevent-1.2
# ./configure --prefix=/usr
# make
# make install
{% endhighlight %}

3.测试libevent是否安装成功：

{%  highlight shell %}
# ls -al /usr/lib | grep libevent
lrwxrwxrwx   1 root root       21 Mar  9 17:03 libevent-1.3.so.1 -> libevent-1.3.so.1.0.3
-rwxr-xr-x   1 root root   338172 Mar  9 17:03 libevent-1.3.so.1.0.3
-rw-r--r--   1 root root   533772 Mar  9 17:03 libevent.a
-rwxr-xr-x   1 root root      805 Mar  9 17:03 libevent.la
lrwxrwxrwx   1 root root       21 Mar  9 17:03 libevent.so -> libevent-1.3.so.1.0.3
{% endhighlight %}

4.安装memcached，同时需要安装中指定libevent的安装位置：

{%  highlight shell %}
# cd /tmp
# tar zxvf memcached-1.2.0.tar.gz
# cd memcached-1.2.0
# ./configure --with-libevent=/usr
# make
# make install
{% endhighlight %}

安装完成后会把memcached放到 /usr/local/bin/memcached ，

5.测试是否成功安装memcached：

{%  highlight shell %}
# ls -al /usr/local/bin/mem*
-rwxr-xr-x 1 root root 142722 Mar  9 17:04 /usr/local/bin/memcached
-rwxr-xr-x 1 root root 152276 Mar  9 17:04 /usr/local/bin/memcached-debug
{% endhighlight %}

memcached的基本设置：
1.启动Memcache的服务器端：


{%  highlight shell %}
# /usr/local/bin/memcached -d -m 10 -u root -l 192.168.251.88 -p 12000 -c 256 -P /tmp/memcached.pid
-d选项是启动一个守护进程，
-m是分配给Memcache使用的内存数量，单位是MB，我这里是10MB，
-u是运行Memcache的用户，我这里是root，
-l是监听的服务器IP地址，如果有多个地址的话，我这里指定了服务器的IP地址192.168.0.200，
-p是设置Memcache监听的端口，我这里设置了12000，最好是1024以上的端口，
-c选项是最大运行的并发连接数，默认是1024，我这里设置了256，按照你服务器的负载量来设定，
-P是设置保存Memcache的pid文件，我这里是保存在 /tmp/memcached.pid，
{% endhighlight %}

2.如果要结束Memcache进程，执行：

{%  highlight shell %}
# kill `cat /tmp/memcached.pid`
{% endhighlight %}

ps：
    启动memcache时会报错，提示“/usr/local/bin/memcached: error while loading shared libraries: libevent-1.3.so.1: cannot open shared object file: No such file or directory”
    
解决办法：

{%  highlight shell %}
# whereis libevent
# ln -s /usr/lib/libevent-1.3.so.1 /usr/lib64/libevent-1.3.so.1
# 再次启动就ok了。
{% endhighlight %}