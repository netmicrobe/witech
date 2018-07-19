---
layout: post
title: centos 上安装 redmine 2.4.2
categories: [cm, redmine]
tags: [cm, redmine, centos]
---

## 下载redmine发布版本，解压

extracted from redmine-2.4.2.tar.gz


## 配置数据库

```sql
CREATE DATABASE redmine CHARACTER SET utf8;
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'redmine';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
```


## 配置数据库连接

config/database.yml.example 拷贝成 config/database.yml，修改后者。

这里用的是mysql，所以配置如下：

```
production:
  adapter: mysql2
  database: redmine
  host: localhost
#  port: 3307
  username: redmine
  password: my_password
```

*注意* ：用的是ruby 1.9 ，adapter用的是mysql2 ；如果是ruby 1.8，adapter要用mysql




## 安装下bundler，安装依赖包

先用 gem --version 看看有没有，用rvm装1.9，自带bundler。

~~~
gem install bundler
~~~

安装gem编译可能用到的package

~~~ shell
yum install -y mysql-devel ImageMagick ImageMagick-devel
~~~


只安装production要求的依赖包，具体依赖包信息参见redmine根目录下的Gemfile

~~~
bundle install --without development test
~~~

注意：安装前还是看下Gemfile里边source指向的哪儿，https://rubygems.org，未必能顺利下载，GFW啊，擦！

注意：安装需要比较长时间，下载的东西比较多：rails...   ， 另外还经常出错， 擦！

可以改成ruby-china的源 http://gems.ruby-china.org/

注意：Redmine automatically installs the adapter gems required by your database configuration by reading it from the config/database.yml file ，如果修改了adapter，重新要运行下bundle install


### 出错 -- mysql.h is missing.  please check your installation of mysql and try again.

解决：

```
yum list mysql-devel
yum install mysql-devel.x86_64
```

安装devel包后，继续执行bundle install

bundle install --without development test
...
Installing mysql2 0.3.18


### 出错 -- checking for Magick-config... no   安装rmagick出错

* 现象

```
Gem::Ext::BuildError: ERROR: Failed to build gem native extension
...
checking for Magick-config... no
...
Check the mkmf.log file for more
...
Results logged to /usr/local/rvm/gems/ruby-1.9.3-p551/extensions/x86_64-linux/1.9.1/rmagick-2.14.0/gem_make.out
```

* 解决

```
yum list ImageMagick ImageMagick-devel
yum install ImageMagick.x86_64 ImageMagick-devel.x86_64
```

安装devel包后，继续执行bundle install

```
bundle install --without development test
...
Installing rmagick 2.14.0
```


## 更新 Session 加密随机数

    with Redmine 2.x:

bundle exec rake generate_secret_token



## Database schema objects creation

RAILS_ENV=production bundle exec rake db:migrate

### 导入基础数据

RAILS_ENV=production bundle exec rake redmine:load_default_data



## 文件访问权限控制

创建redmine用户

useradd -s /sbin/nologin -c "redmine service user" redmine

The user account running the application must have write permission on the following subdirectories:

* files (storage of attachments)
* log (application log file production.log)
* tmp and tmp/pdf (create these ones if not present, used to generate PDF documents among other things)
* public/plugin_assets (assets of plugins)

E.g., assuming you run the application with a redmine user account:

```
mkdir -p tmp tmp/pdf public/plugin_assets
sudo chown -R redmine:redmine files log tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets
```


## 测试redmine是否安装成功

test in Redmine 2.x:

bundle exec ruby script/rails server webrick -e production

 访问 http://localhost:3000/
 
Use default administrator account to log in:

    login: admin
    password: admin




