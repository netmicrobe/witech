---
layout: post
title: centos从源码安装git
categories: [cm, git]
tags: [centos, git]
---

## 源码下载地址

* <https://www.kernel.org/pub/software/scm/git/>

## 安装步骤

1、安装依赖

```
yum -y install curl curl-devel zlib-devel openssl-devel perl cpio expat-devel gettext-devel autoconf
```

2、开始安装

```
svn co https://github.com/git/git
autoconf
./configure
make && make install
```

3、查看版本

```
git --version
git version 1.7.12.GIT
```

## 编译遇到的问题

### Can't locate ExtUtils/MakeMaker.pm

编译 2.9.0 报错

```
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX='/usr/local' INSTALL_BASE='' --localedir='/usr/local/share/locale'
Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 .) at Makefile.PL line 3.
BEGIN failed--compilation aborted at Makefile.PL line 3.
make[1]: *** [perl.mak] Error 2
make: *** [perl/perl.mak] Error 2

```

* 解决方法

安装 perl-ExtUtils-MakeMaker

```
yum install -y perl-ExtUtils-MakeMaker
```

* 参考
  * <http://blog.csdn.net/tspangle/article/details/11798951>



