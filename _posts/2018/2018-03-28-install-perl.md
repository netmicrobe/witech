---
layout: post
title: CentOS 安装 perl
categories: [ cm, perl ]
tags: [ centos ]
---


* 参考
  * <http://www.aodba.com/how-to-install-perl-5-16-on-centos-6-from-source/>
  * <https://stackoverflow.com/a/20515635>



## 从源码安装

~~~
yum groupinstall "Development Tools"

wget http://www.cpan.org/src/5.0/perl-5.26.1.tar.gz
tar -xzf perl-5.26.1.tar.gz
cd perl-5.26.1

./Configure -des -Dprefix=/opt/perl5/perls/perl5.26
make
make install
~~~

* 清除旧版本perl

~~~
rm /usr/bin/perl
ln -s /opt/perl5/perls/perl5.26/bin/perl /usr/bin/perl
~~~


## 使用 pelrbrew 安装

~~~
wget -O - http://install.perlbrew.pl | bash
source ~/perl5/perlbrew/etc/bashrc
perlbrew install perl-5.18.1
perlbrew switch perl-5.18.1
~~~

* Install cpanm tool

  ~~~
  perlbrew install-cpanm
  ~~~

* Install perl modules

  ~~~
  perldoc time::piece
  perlbrew install-cpanm
  cpanm -v DBI
  cpanm -v DBD::ODBC
  cpanm -v YAML
  cpanm -v Time::Piece
  cpanm -v Crypt::TripleDES
  ~~~



















