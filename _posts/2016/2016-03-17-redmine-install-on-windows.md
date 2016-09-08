---
layout: post
title: 在windows上安装redmine
categories: [cm, redmine]
tags: [cm, redmine]
---

参考
* redmine官网的安装步骤
  * <http://www.redmine.org/projects/redmine/wiki/RedmineInstall>

## 以 Redmine 2.2.1 安装为例，基于 Ruby 1.9.3 ， Rails 3.2.11

## 环境准备：

### 下载

* ruby：ruby-1.9.3-p448-i386-mingw32.7z
* Devkit：DevKit-tdm-32-4.5.2-20111229-1559-sfx
* ruby 和 Devkit 下载地址： http://rubyinstaller.org/downloads/

* redmine：redmine-2.2.1
  * redmine 下载地址： http://www.redmine.org/projects/redmine/wiki/Download

将三个包解压

### 设置path

将可执行文件所在目录，设置到系统PATH变量中.

包含：

* <ruby-home>\bin
* <Devkit-home>\bin
* <Devkit-home>\mingw\bin

### 设置下redmine的Gemfile

可以改成淘宝的源 https://ruby.taobao.org   ，方便快速下载




## 安装Redmine：

### 创建数据库和数据库用户，以 Mysql 为例：

```sql
CREATEDATABASE redmine CHARACTER SET utf8;
GRANTALL PRIVILEGES ON redmine.* TO'redmine'@'localhost' IDENTIFIED BY'my_password';
```

### 在 Redmine app 中配置数据库连接

从配置模板 config/database.yml.example 复制出  config/database.yml 

编辑 "production" environment 部分的配置.

Example for a MySQL database using ruby 1.9 (adapter must be set to mysql2):

```
production:
adapter: mysql2
database: redmine
host: localhost
username: redmine
password: my_password
```

### 安装依赖

Redmine 使用 Bundler 管理依赖。

先安装 Bundler  : gem install bundler

安装依赖： bundle install --without development test rmagick

rmagick 是用来生成图片的组件，要先安装 ImageMagick，参见： <http://www.redmine.org/projects/redmine/wiki/HowTo_install_rmagick_gem_on_Windows>

注意：bundle install 会保存本次的设置到  .bundle/config 文件中，如果之后又想安装 development group 中提到的 gems，调整下设置  bundle config --local without test:rmagick 后，再执行 bundle install

### 生成 cookie session 密钥

bundle exec rake generate_secret_token

执行过后，会生成 config/initializers/secret_token.rb ，其包含密钥

### 初始化数据库

自动生成表结构

```
set RAILS_ENV=production
bundle exec rake db:migrate
```

导入初始 数据

```
set RAILS_ENV=production
set REDMINE_LANG=en
bundle exec rake redmine:load_default_data
```

### 都装完了，就启动吧

bundle exec ruby script/rails server webrick -e production

从 http://localhost:3000/ 访问看看，应该看到Redmine 的主页了。

默认管理员账号：

* login: admin
* password: admin













