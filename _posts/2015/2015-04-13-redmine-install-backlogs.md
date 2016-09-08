---
layout: post
title: Redmine.Backlogs 插件安装
categories: [cm, redmine]
tags: [cm, redmine]
---

## 安装

### 检查Redmine配置

Just re-run the bundler call you executed during redmine install

bundle install --without development test rmagick
 
### 安装holidays gem 1.0.4

holidays 1.0.4直接安装有bug，首先安装1.0.3再升级可以解决该问题。

```
gem install holidays --version 1.0.3
gem install holidays
```
 
### 下载Backlogs

在 redmine-dir/plugins 下面checkout backlogs：

git clone git://github.com/backlogs/redmine_backlogs.git
 
查看最新的可用tag：
git tag
 
在git tag列出列表中找到最新的，并checkout：
git checkout vX.Y.Z
 

### 安装Backlogs

 
#### 安装依赖包

```
bundle install
bundle update
```

* 注：不update一下老是报错：nokogiri 版本太低。

#### 配置数据库：

```
RAILS_ENV=production bundle exec rake db:migrate
```

如果上述db:migrate有问题，执行：

```
cd path/to/redmine
RAILS_ENV=production rake redmine:plugins:migrate
```

可能还需要运行：

```
bundle exec rake tmp:cache:clear
bundle exec rake tmp:sessions:clear
```


 
#### 安装

在Redmine中创建2个Tracker：Story, Task

```
cd path/to/redmine
RAILS_ENV=production bundle exec rake redmine:backlogs:install
```

* 注：安装过程中会提示进行一些配置，例如，指定那些trakcer可以作为story，那个可以作为task。
 
 
#### 配置


Backlogs安装完成后可在redmine中进行配置。
 
##### Backlogs全局配置的地方：

Administrator > Plugins
 
##### 权限设置：

dministration > Roles and permissions > Permissions report

![](/images/cm/redmine/redmine_permission_settings_for_backlog.png)

 
##### 对Project开启Backlogs

 
Administrator > Project > some-project-details page > Modules > Check Backlogs

![](/images/cm/redmine/enable_backlogs_for_project_on_redmine.png)
 





## Redmine：在CentOS上，安装backlogs

### 安装backlogs

参考：<http://www.redminebacklogs.net/en/installation.html>

由于是恢复，数据库直接导入的，没有执行db:migrate 

```
RAILS_ENV=production
export RAILS_ENV

vim plugins/redmine_backlogs/Gemfile
    source 改为  'https://ruby.taobao.org'
    注释掉，thin, database_cleaner 的gem

cd redmine-home
bundle install --without development test
或者
bundle update
```


#### 问题 - The bundle currently has nokogiri locked at 1.6.6.2.

解决：

Try running `bundle update nokogiri`


#### 问题 - libxml2 is missing

解决：

```
yum list libxml2-devel
yum install libxml2-devel.x86_64
```

#### 问题 - libxslt is missing

解决：

```
yum list libxslt-devel
yum install libxslt-devel.x86_64
```

#### 问题 - Gem::InstallError: prawn requires Ruby version >= 2.0.0.

解决：

修改 plugins/redmine_backlogs/Gemfile

    gem "prawn" 改为 gem "prawn", "~>1.3.0"
    
    prawn最新版本已到2.x，需要ruby是2.0.0以上。

#### 安装

$ bundle exec rake redmine:backlogs:install

2.4.2.stable. You are running backlogs v1.0.6, latest version is 1.0.6

```
=====================================================
             Redmine Backlogs Installer
=====================================================
Installing to the production environment.
Fetching card labels from http://git.gnome.org...done!
Story and task trackers are now set.
Migrating the database...** Invoke redmine:plugins:migrate (first_time)
** Invoke environment (first_time)
** Execute environment
** Execute redmine:plugins:migrate
** Invoke db:schema:dump (first_time)
** Invoke environment
** Invoke db:load_config (first_time)
** Execute db:load_config
** Execute db:schema:dump
** Invoke redmine:backlogs:fix_positions (first_time)
** Invoke environment (first_time)
** Execute environment
** Execute redmine:backlogs:fix_positions
done!
Installation complete. Please restart Redmine.
Thank you for trying out Redmine Backlogs!
```


