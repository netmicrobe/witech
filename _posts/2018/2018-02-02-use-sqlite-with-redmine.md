---
layout: post
title: 在 Redmine 上使用 sqlite
categories: [cm, ruby]
tags: [redmine, sqlite, ruby]
---

* 参考：
  * <http://blog.sidmitra.com/test-redmine-with-sqlite3>
  * <http://www.redmine.org/boards/2/topics/2768>


## 安装 sqlite-3

~~~
yum list sqlite
sqlite.i686                                             3.6.20-1.el6_7.2
~~~

* 或者，从源码编译安装

~~~
wget ftp://ftp.42.org/pub/FreeBSD/distfiles/sqlite-3.3.7.tar.gz

cd sqlite-3.3.7
./configure --prefix=/home/redmine/SQLITE
make
make install
~~~

## redmine配置


* database.yml

~~~ yml
production:
  adapter: sqlite3
  database: db/redmine.sqlite3
  encoding: utf8
~~~

## bundle 执行更新

~~~
bundle install --without development test
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake redmine:load_default_data
~~~






