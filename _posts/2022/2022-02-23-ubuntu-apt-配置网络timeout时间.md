---
layout: post
title: apt-配置网络timeout时间
categories: [cm, linux]
tags: [mint, debian, ubuntu, apt]
---

* 参考： 
  * <https://askubuntu.com/a/141523>
  * [通信速度が原因で「apt-get」が失敗する事がある](https://yamap55-hatenablog-com.translate.goog/entry/2020/02/27/212922?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=op,sc)
  * <https://askubuntu.com/questions/141513/how-to-lower-wait-time-for-repository-updates>
  * []()


### 方法1

命令行参数直接指定： `apt-get -o Acquire::http::Timeout="300" update`

### 方法2

`vi /etc/apt/apt.conf.d/99timeout`

将如下内容拷贝进去，单位是秒

~~~
Acquire::http::Timeout "300";
Acquire::ftp::Timeout "300";
~~~


## Dock

Dockfile

~~~
FROM ubuntu:18.04

RUN /bin/echo -e "Acquire::http::Timeout \"300\";\n\
Acquire::ftp::Timeout \"300\";" >> /etc/apt/apt.conf.d/99timeout

RUN rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && apt-get -y install wget
~~~


































