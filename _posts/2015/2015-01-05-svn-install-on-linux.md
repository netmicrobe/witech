---
layout: post
title: SVN 在linux上的安装 
categories: [cm, subversion]
tags: [cm, subversion, linux]
---


### 获取到svn的1.8.11版本

```
# wget http://mirrors.hust.edu.cn/apache/subversion/subversion-1.8.11.tar.bz2
```

### 解压

```
# tar -jxvf subversion-1.8.11.tar.bz2

```

### 进入解压后的文件夹
# cd subversion-1.8.11

### 下载所需依赖包

```
# ./get-deps.sh

```

### 安装依赖的apr

```
# wget http://archive.apache.org/dist/apr/apr-1.4.8.tar.gz
# tar -zxvf apr-1.4.8.tar.gz
# cd apr-1.4.8
# ./configure --prefix=/usr/local/apache
# make && make install

```

### 安装依赖的apr-util

```
# wget http://archive.apache.org/dist/apr/apr-util-1.5.2.tar.gz
#  tar -zxvf apr-util-1.5.2.tar.gz
# cd apr-util-1.5.2
# ./configure --prefix=/usr/local/apache --with-apr=/usr/local/apache/bin/apr-1-config
# make && make install

```

### 安装serf

```
# tar -jxvf serf-1.2.1.tar.bz2
# cd serf-1.2.1
# ./configure --prefix=/usr/local/serf --with-apr=/usr/local/apache --with-apr-util=/usr/local/apache
# make && make install

```

### 安装svn

```
# ./configure --prefix=/usr/local/subversion --with-apr=/usr/local/apache --with-apr-util=/usr/local/apache  --with-serf=/usr/local/serf
# make && make install

```

### 添加svn相关命令到环境变量中

```
# vi /etc/profile
# export PATH=/usr/local/subversion/bin:$PATH  //加上这句话
# source /etc/profile //使环境变量生效

```

### 添加自定义系统命令

```
# vi ~/.bashrc 
# alias svnmucc='/usr/local/subversion/bin/svnmucc'  //加上这句话
# source ~/.bashrc //生效

```


