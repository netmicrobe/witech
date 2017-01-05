---
layout: post
title: Gitlab 8 在 CentOS 安装
categories: [cm, git, gitlab]
tags: [cm, git, gitlab]
---


* 参考
  * [centos 6.5安装GitLab全过程和问题记录](http://www.open-open.com/lib/view/open1399684894447.html)
  * gitlab recipes - install
    * [gitlab-recipes install on centos](https://gitlab.com/gitlab-org/gitlab-recipes/tree/master/install/centos)
    * [gitlab-recipes install on centos - github](https://github.com/gitlabhq/gitlab-recipes/tree/master/install/centos)
    * [Installation from source](https://docs.gitlab.com/ce/install/installation.html)

* 注意
  * 无特别说明，文档中的命令都以 root 执行



## 安装 Gitlab



### 操作系统 CentOS 6.8

```
root@localhost: ~ # rpm --query centos-release
centos-release-6-8.el6.centos.12.3.i686
```



#### 配置第三方 yum 库

##### Add EPEL repository

* Download the GPG key
  
  ```
  wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6 https://getfedora.org/static/0608B895.txt
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
  ```

* 检查是否配置成功：
  
  ```
  rpm -qa gpg*
  gpg-pubkey-0608b895-4bd22942
  ```

* 安装 epel-release-6-8.noarch package, which will enable EPEL repository on your system:
  
  ```
  rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  ```



##### Add Remi's RPM repository

* Download the GPG key
  
  ```
  wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-remi http://rpms.famillecollet.com/RPM-GPG-KEY-remi
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
  ```

* 检查是否配置成功：
  
  ```
  rpm -qa gpg*
  gpg-pubkey-00f97f56-467e318a
  ```

* 安装 remi-release-6 package, which will enable remi-safe repository on your system:
  
  ```
  rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
  ```


##### 检查 yum库是否配置成功

```
yum repolist

repo id        repo name                                                       status
base           CentOS-6 - Base                                                  6696
epel           Extra Packages for Enterprise Linux 6 - x86_64                  12125
extras         CentOS-6 - Extras                                                  61
remi-safe      Safe Remi's RPM repository for Enterprise Linux 6 - x86_64        827
updates        CentOS-6 - Updates                                                137
repolist: 19846
```


没成功，手动enable

```shell
yum install yum-utils
yum-config-manager --enable epel --enable remi-safe
```


#### 安装 yum 软件包

```shell
yum -y update
yum -y groupinstall 'Development Tools'
yum -y install readline readline-devel ncurses-devel gdbm-devel glibc-devel tcl-devel openssl-devel curl-devel expat-devel db4-devel byacc sqlite-devel libyaml libyaml-devel libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel libicu libicu-devel system-config-firewall-tui redis sudo wget crontabs logwatch logrotate perl-Time-HiRes git cmake libcom_err-devel.i686 libcom_err-devel.x86_64 nodejs

# For reStructuredText markup language support, install required package:
yum -y install python-docutils
```

* 注意
  如果有些包（eg. gdbm-devel, libffi-devel and libicu-devel）安装不了，尝试执行： 
  
  ```
  yum-config-manager --enable rhel-6-server-optional-rpms
  ```


#### 安装 mail 服务器

推荐 postfix

```
yum -y install postfix
```


#### 配置缺省的 Editor

```shell
# Install vim and set as default editor
yum -y install vim-enhanced
ln -s /usr/bin/vim /usr/bin/editor
```

取消链接

rm -i /usr/bin/editor


### 从 源码 安装 Git(2.7.4 or higher)

```shell
yum install zlib-devel perl-CPAN gettext curl-devel expat-devel gettext-devel openssl-devel
mkdir /tmp/git && cd /tmp/git
curl --progress https://www.kernel.org/pub/software/scm/git/git-2.9.0.tar.gz | tar xz
cd git-2.9.0
./configure
make
make prefix=/usr/local install
```

将 Git 的执行目录 加入到 $PATH

修改 config/gitlab.yml ，将 git bin_path 改为 /usr/local/bin/git.



### 安装 Ruby(2.1)

```shell
mkdir /tmp/ruby && cd /tmp/ruby
curl --progress ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.10.tar.gz | tar xz
cd ruby-2.1.9
./configure --disable-install-rdoc
make
make prefix=/usr/local install
```

#### Install the Bundler Gem

```
gem install bundler --no-doc
```


### 安装 Go

从 GitLab 8.0 开始， http请求是由 gitlab 的 workhorse 处理的，workhorse 是一个 Go 程序。

```
yum install golang golang-bin golang-src
```


### 配置 GitLab 的系统用户

```
adduser --system --shell /bin/bash --comment 'GitLab' --create-home --home-dir /home/git/ git
```

* In order to include /usr/local/bin to git user's PATH, one way is to edit the sudoers file. 
  As root run: `visudo`
  
  将 
  
  ```
  Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin
  ```
  
  改为
  
  ```
  Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
  ```
  
### 安装数据库

#### PostgreSQL(9.3)

* 安装
  
  ```shell
  yum remove postgresql
  rpm -Uvh http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-2.noarch.rpm
  yum install postgresql93-server postgresql93-devel postgresql93-contrib
  mv /etc/init.d/{postgresql-9.3,postgresql}
  service postgresql initdb
  ```

* 启动
  
  ```
  service postgresql start
  ```

* 配置自启动
  
  ```
  chkconfig postgresql on
  ```

* 配置用户名&密码
  
  ```shell
  su - postgres
  psql -d template1

  psql (9.4.3)
  Type "help" for help.
  template1=# CREATE USER git CREATEDB;
  CREATE ROLE
  template1=# CREATE DATABASE gitlabhq_production OWNER git;
  CREATE DATABASE
  template1=# CREATE EXTENSION IF NOT EXISTS pg_trgm;
  template1=# \q
  exit # exit uid=postgres, return to root
  ```

  配置完成后，尝试用git用户登录
  
  ```
  sudo -u git psql -d gitlabhq_production
  ```
  
  检查 pg_trgm extension 是否安装
  
  ```
  SELECT true AS enabled
  FROM pg_available_extensions
  WHERE name = 'pg_trgm'
  AND installed_version IS NOT NULL;
  ```

* 配置权限
  /var/lib/pgsql/9.3/data/pg_hba.conf
  修改 ident 为 trust
  
  ```
  host    all             all             127.0.0.1/32            trust
  ```
  

#### MySQL(5.5.14 or later)

* 安装 MySQL ，并设置自启动
  
  ```
  yum install -y mysql-server mysql-devel
  chkconfig mysqld on
  service mysqld start
  ```
  
* 版本最低 5.5.14
  
  ```
  mysql --version
  ```

* Secure your installation
  
  ```
  mysql_secure_installation
  ```
  
* Create a user for GitLab
  
  ```
  CREATE USER 'git'@'localhost' IDENTIFIED BY '$password';
  ```
  
* 设置 使用 INNODB 引擎
  
  ```
  SET storage_engine=INNODB;
  ```
  
  如果设置失败，检查下 MySQL config files (e.g. /etc/mysql/*.cnf, /etc/mysql/conf.d/*) ，是否"innodb = off".
  
* Create the GitLab production database
  
  ```
  CREATE DATABASE IF NOT EXISTS `gitlabhq_production` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;
  ```
  
* Grant the GitLab user necessary permissions on the table
  
  ```
  GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, CREATE TEMPORARY TABLES, DROP, INDEX, ALTER, LOCK TABLES, REFERENCES ON `gitlabhq_production`.* TO 'git'@'localhost';
  ```
  
* 检查下新用户、新数据库
  
  ```
  sudo -u git -H mysql -u git -p -D gitlabhq_production
  ```





### 安装Redis( at least Redis 2.8 )

```
yum remove redis
yum --enablerepo=remi,remi-test install redis
chkconfig redis on
```

* 配置 redis

  ```
  cp /etc/redis.conf /etc/redis.conf.orig
  ```

  * 禁止通过tcp访问redis，将  port 设置为 0 即可。
  
    ```shell
    sed 's/^port .*/port 0/' /etc/redis.conf.orig | sudo tee /etc/redis.conf
    ```
    
  * Enable Redis socket for default CentOS path:
    
    ```shell
    echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis.conf
    echo -e 'unixsocketperm 0770' | sudo tee -a /etc/redis.conf
    ```
    
  * Create the directory which contains the socket
    
    ```shell
    mkdir /var/run/redis
    chown redis:redis /var/run/redis
    chmod 755 /var/run/redis
    ```
    
  * Persist the directory which contains the socket, if applicable
    
    ```shell
    if [ -d /etc/tmpfiles.d ]; then
        echo 'd  /var/run/redis  0755  redis  redis  10d  -' | sudo tee -a /etc/tmpfiles.d/redis.conf
    fi
    ```
    
  * 重启 Redis ，使设置生效
    
    ```shell
    service redis restart
    ```
    
  * 将 git 用户加入 redis group
    
    ```shell
    usermod -aG redis git
    ```
    
### 安装 Gitlab

安装到 git 用户的home目录

```shell
# We'll install GitLab into home directory of the user "git"
cd /home/git

# Clone GitLab repository
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b 8-9-stable gitlab

# Go to GitLab installation folder
cd /home/git/gitlab

# Copy the example GitLab config
sudo -u git -H cp config/gitlab.yml.example config/gitlab.yml

# Update GitLab config file, follow the directions at top of file
sudo -u git -H editor config/gitlab.yml

# Copy the example secrets file
sudo -u git -H cp config/secrets.yml.example config/secrets.yml
sudo -u git -H chmod 0600 config/secrets.yml

# Make sure GitLab can write to the log/ and tmp/ directories
sudo chown -R git log/
sudo chown -R git tmp/
sudo chmod -R u+rwX,go-w log/
sudo chmod -R u+rwX tmp/

# Make sure GitLab can write to the tmp/pids/ and tmp/sockets/ directories
sudo chmod -R u+rwX tmp/pids/
sudo chmod -R u+rwX tmp/sockets/

# Create the public/uploads/ directory
sudo -u git -H mkdir public/uploads/

# Make sure only the GitLab user has access to the public/uploads/ directory
# now that files in public/uploads are served by gitlab-workhorse
sudo chmod 0700 public/uploads

sudo chmod ug+rwX,o-rwx /home/git/repositories/

# Change the permissions of the directory where CI build traces are stored
sudo chmod -R u+rwX builds/

# Change the permissions of the directory where CI artifacts are stored
sudo chmod -R u+rwX shared/artifacts/

# Copy the example Unicorn config
sudo -u git -H cp config/unicorn.rb.example config/unicorn.rb

# Find number of cores
nproc

# Enable cluster mode if you expect to have a high load instance
# Ex. change amount of workers to 3 for 2GB RAM server
# Set the number of workers to at least the number of cores
sudo -u git -H editor config/unicorn.rb

# Copy the example Rack attack config
sudo -u git -H cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb

# Configure Git global settings for git user
# 'autocrlf' is needed for the web editor
sudo -u git -H git config --global core.autocrlf input

# Disable 'git gc --auto' because GitLab already runs 'git gc' when needed
sudo -u git -H git config --global gc.auto 0

# Configure Redis connection settings
sudo -u git -H cp config/resque.yml.example config/resque.yml

# Change the Redis socket path if you are not using the default CentOS configuration
sudo -u git -H editor config/resque.yml
```

#### 配置数据库连接

```shell
# PostgreSQL only:
sudo -u git cp config/database.yml.postgresql config/database.yml

# MySQL only:
sudo -u git cp config/database.yml.mysql config/database.yml

# MySQL and remote PostgreSQL only:
# Update username/password in config/database.yml.
# You only need to adapt the production settings (first part).
# If you followed the database guide then please do as follows:
# Change 'secure password' with the value you have given to $password
# You can keep the double quotes around the password
sudo -u git -H editor config/database.yml

# PostgreSQL and MySQL:
# Make config/database.yml readable to git only
sudo -u git -H chmod o-rwx config/database.yml
```

#### Install Gems

国内记得改一下 ruby-china 的源，不然很慢

```shell
cd /home/git/gitlab

# For PostgreSQL (note, the option says "without ... mysql")
sudo -u git -H bundle config build.pg --with-pg-config=/usr/pgsql-9.3/bin/pg_config
sudo -u git -H bundle install --deployment --without development test mysql aws kerberos

# Or for MySQL (note, the option says "without ... postgres")
sudo -u git -H bundle install --deployment --without development test postgres aws kerberos
```


#### Install GitLab shell

GitLab Shell is an SSH access and repository management software developed specially for GitLab.

```shell
# Run the installation task for gitlab-shell (replace `REDIS_URL` if needed):
sudo -u git -H bundle exec rake gitlab:shell:install[v3.0.0] REDIS_URL=unix:/var/run/redis/redis.sock RAILS_ENV=production

# By default, the gitlab-shell config is generated from your main GitLab config.
# You can review (and modify) the gitlab-shell config as follows:
sudo -u git -H editor /home/git/gitlab-shell/config.yml

# Ensure the correct SELinux contexts are set
# Read http://wiki.centos.org/HowTos/Network/SecuringSSH
restorecon -Rv /home/git/.ssh
```


#### Install gitlab-workhorse

```shell
cd /home/git
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-workhorse.git
cd gitlab-workhorse
sudo -u git -H git checkout v0.7.5
sudo -u git -H make
```


#### 初始化数据库

```shell
# Go to GitLab installation folder

cd /home/git/gitlab

sudo -u git -H bundle exec rake gitlab:setup RAILS_ENV=production

# Type 'yes' to create the database tables.

# When done you see 'Administrator account created:'
```


#### 备份 secrets.yml

The secrets.yml file stores encryption keys for sessions and secure variables. Backup secrets.yml someplace safe.



#### 配置 GitLab 自启动

```shell
cp lib/support/init.d/gitlab /etc/init.d/gitlab
cp lib/support/init.d/gitlab.default.example /etc/default/gitlab
chkconfig gitlab on
service gitlab start
```


#### 设置日志备份

```shell
cp lib/support/logrotate/gitlab /etc/logrotate.d/gitlab
```


#### 检查 GitLab 的环境配置

```shell
sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production
```

#### Compile assets

```shell
sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production
```

#### 启动 GitLab

```shell
service gitlab start
```




### 配置 Web 服务器


#### Nginx( 1.10.2-1.el6 )

* 安装 Nginx

  ```
  yum update
  yum -y install nginx
  chkconfig nginx on
  ```
  
* Site Configuration
  
  ```shell
  cp lib/support/nginx/gitlab /etc/nginx/conf.d/gitlab.conf
  ```
  
* Add nginx user to git group
  
  ```shell
  usermod -a -G git nginx
  chmod g+rx /home/git/
  ```
  
* 检查 nginx 配置文件
  
  ```shell
  nginx -t
  ```
  
* 重启 Nginx
  
  ```shell
  service nginx restart
  ```
  




#### Apache

* GitLab-Workhorse

  配合 apache ， workhorse 要做相应修改。Change gitlab_workhorse_options in /etc/default/gitlab to the following:

  ```
  gitlab_workhorse_options="-listenUmask 0 -listenNetwork tcp -listenAddr 127.0.0.1:8181 -authBackend http://127.0.0.1:8080"
  ```

  然后重启GitLab

  ```
  service gitlab restart
  ```

* HTTP 配置

  ```shell
  yum -y install httpd
  chkconfig httpd on
  wget -O /etc/httpd/conf.d/gitlab.conf https://gitlab.com/gitlab-org/gitlab-recipes/raw/master/web-server/apache/gitlab-apache22.conf
  sed -i 's/logs\///g' /etc/httpd/conf.d/gitlab.conf
  ```

* HTTPS 配置

  ```
  yum -y install httpd mod_ssl
  chkconfig httpd on
  wget -O /etc/httpd/conf.d/gitlab.conf https://gitlab.com/gitlab-org/gitlab-recipes/raw/master/web-server/apache/gitlab-ssl-apache22.conf
  mv /etc/httpd/conf.d/ssl.conf{,.bak}
  sed -i 's/logs\///g' /etc/httpd/conf.d/gitlab.conf
  ```

  * make sure the path to your certificates is valid.
  * Add LoadModule ssl_module /etc/httpd/modules/mod_ssl.so in /etc/httpd/conf/httpd.conf.

* SELinux 配置

  ```
  setsebool -P httpd_can_network_connect on
  setsebool -P httpd_can_network_relay on
  setsebool -P httpd_read_user_content on
  semanage -i - <<EOF
  fcontext -a -t user_home_dir_t '/home/git(/.*)?'
  fcontext -a -t ssh_home_t '/home/git/.ssh(/.*)?'
  fcontext -a -t httpd_sys_content_t '/home/git/gitlab/public(/.*)?'
  fcontext -a -t httpd_sys_content_t '/home/git/repositories(/.*)?'
  EOF
  restorecon -R /home/git
  ```

  * Note: semanage is part of the policycoreutils-python package.

* Other httpd security considerations

  * In /etc/httpd/conf/httpd.conf

    ```
    ServerTokens Prod
    ServerSignature Off
    TraceEnable Off
    ```

  * mod_ssl 在压缩时候有漏洞

    Apache httpd 2.2.15 (official release), mod_ssl enables compression over SSL by default. 所以要关闭

    ```
    # add the following line to /etc/sysconfig/httpd.
    export OPENSSL_NO_DEFAULT_ZLIB=1
    ```

    httpd 2.2.24 and greater 版本在 httpd.conf 可以设置 

    ```
    SSLCompression Off
    ```

  * 某些apache mode 要禁用

    ```
    #LoadModule deflate_module modules/mod_deflate.so
    #LoadModule suexec_module modules/mod_suexec.so

    ```

  * 重启 apache
    
    ```
    service httpd start
    ```


### 配置防火墙

```
lokkit -s http -s https -s ssh
service iptables restart
```


### 最后检查安装结果

```
cd /home/git/gitlab
sudo -u git -H bundle exec rake gitlab:check RAILS_ENV=production
```



### 首次登陆

默认管理员是 root 用户， 首次登陆设置密码。

root 用户登录 》 右上角 Admin Area 图标 》 Overview

例如，本次安装完成后，Overview 页面显示组件情况：

```
GitLab       8.9.11
GitLab Shell 3.0.0
GitLab API v3
Git          2.9.0
Ruby         2.1.10p492
Rails        4.2.7.1
PostgreSQL   9.3.15
```


#### Health Check

root 用户登录 》 右上角 Admin Area 图标 》 Monitoring 》 Health Check

















## 重启 Gitlab

* Nginx + PostgreSQL 组合

  ```
  service redis start
  service postgresql start
  service gitlab start
  service nginx start
  ```



## 问题 Trouble Shooting

* 参考
  <http://blog.csdn.net/johnnycode/article/details/41947581>
  <http://axilleas.me/en/blog/2013/selinux-policy-for-nginx-and-gitlab-unix-socket-in-fedora-19/>

### 都装好了，nginx 不能访问 gitlab-workhorse，permission denied

访问 Gitlab，提示 403 Forbidden............

* 查看日志

```
/var/log/nginx/gitlab_error.log

2016/11/21 09:59:26 [crit] 611#0: *13 connect() to unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket failed (13: Permission denied) while connecting to upstream, client: 127.0.0.1, server: your_server_fqdn, request: "GET / HTTP/1.1", upstream: "http://unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket:/", host: "127.0.0.1"
2016/11/21 09:59:26 [error] 611#0: *13 open() "/home/git/gitlab/public/502.html" failed (13: Permission denied), client: 127.0.0.1, server: your_server_fqdn, request: "GET / HTTP/1.1", upstream: "http://unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket/", host: "127.0.0.1"
2016/11/21 10:01:05 [crit] 611#0: *15 connect() to unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket failed (13: Permission denied) while connecting to upstream, client: 127.0.0.1, server: your_server_fqdn, request: "GET / HTTP/1.1", upstream: "http://unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket:/", host: "127.0.0.1"
2016/11/21 10:01:05 [error] 611#0: *15 open() "/home/git/gitlab/public/502.html" failed (13: Permission denied), client: 127.0.0.1, server: your_server_fqdn, request: "GET / HTTP/1.1", upstream: "http://unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket/", host: "127.0.0.1"
2016/11/21 10:01:11 [crit] 611#0: *17 connect() to unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket failed (13: Permission denied) while connecting to upstream, client: 127.0.0.1, server: your_server_fqdn, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket:/favicon.ico", host: "127.0.0.1"
2016/11/21 10:01:11 [error] 611#0: *17 open() "/home/git/gitlab/public/502.html" failed (13: Permission denied), client: 127.0.0.1, server: your_server_fqdn, request: "GET /favicon.ico HTTP/1.1", upstream: "http://unix:/home/git/gitlab/tmp/sockets/gitlab-workhorse.socket/favicon.ico", host: "127.0.0.1"
```

```
/home/git/gitlab/log/production.log

Cleaning old build artifacts
Started GET "/" for 127.0.0.1 at 2016-11-21 10:11:21 +0800
Processing by RootController#index as */*
Completed 401 Unauthorized in 4ms (ActiveRecord: 0.0ms)
```

* 分析
  这是由于Selinux权限控制导致的，发现 socket 文件不能方法，查看socket文件权限描述后面有个点，如下：
  
  ```
  root@localhost: /home/git/gitlab # ll tmp/sockets
  total 0
  srwxrwxrwx. 1 git git 0 Nov 21 10:42 gitlab.socket
  srwxrwxrwx. 1 git git 0 Nov 21 10:42 gitlab-workhorse.socket
  ```
  
  解决办法是，关闭selinux，或者配置安全策略
  
#### 可选方法，关闭Selinux

* 临时关闭

  ```
  # setenforce 0 #关闭 Selinux  
  ```

* 永久关闭
  修改 /etc/selinux/config 文件，修改 SELINUX=disabled，重启后查看：
  
  ```
  getenforce   
  Disabled  
  ```

#### 可选方法，添加 security module

```
yum install -y policycoreutils-{python,devel}
grep nginx /var/log/audit/audit.log | audit2allow -M nginx
semodule -i nginx.pp
usermod -a -G git nginx
chmod g+rx /home/git/
```















