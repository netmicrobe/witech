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
  * [GitLab Community Edition Official Documents](https://docs.gitlab.com/ce/README.html)
  * [GitLab Community Edition - Workflow](https://docs.gitlab.com/ce/workflow/README.html)

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
# 2017-04 9-1-stable 能用了
# sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b 9-1-stable gitlab


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

## Gitlab 9.1.0

### 修改 unicorn 端口

默认 unicorn 端口是 8080，容易和其他app冲突

* 修改方法

/home/git/gitlab/config/unicorn.rb

```
listen "127.0.0.1:8080", :tcp_nopush => true
改为
listen "127.0.0.1:8888", :tcp_nopush => true
```

## 附录

### LDAP 设置

* 参见： 
  * [GitLab Community Edition Authentication and Authorization LDAP](https://docs.gitlab.com/ce/administration/auth/ldap.html)
  * [How to debug Gitlab LDAP authentication?](https://stackoverflow.com/questions/18984198/how-to-debug-gitlab-ldap-authentication)
  * [Debugging LDAP ](https://about.gitlab.com/handbook/support/workflows/ldap/debugging_ldap.html)
  * [Gitlab-EE-Admin-LDAP ](https://docs.gitlab.com/ee/administration/auth/ldap.html)
  * [Gitlab Active Directory LDAP Authentication](https://raymii.org/s/tutorials/Gitlab_and_Active_Directory_LDAP_Authentication.html)
  * [gitlab&fengoffice的ldap配置](http://www.cnblogs.com/silenceli/p/3459234.html)

1. 在 config/gitlab.yml 中配置 ldap 部分
2. 重启 Gitlab

#### gitlab.yml 中 openldap 配置示例

```yml
  ## LDAP settings
  # You can inspect a sample of the LDAP users with login access by running:
  #   bundle exec rake gitlab:ldap:check RAILS_ENV=production
  ldap:
    enabled: true
    servers:
      ##########################################################################
      #
      # Since GitLab 7.4, LDAP servers get ID's (below the ID is 'main'). GitLab
      # Enterprise Edition now supports connecting to multiple LDAP servers.
      #
      # If you are updating from the old (pre-7.4) syntax, you MUST give your
      # old server the ID 'main'.
      #
      ##########################################################################
      main: # 'main' is the GitLab 'provider ID' of this LDAP server
        ## label
        #
        # A human-friendly name for your LDAP server. It is OK to change the label later,
        # for instance if you find out it is too large to fit on the web page.
        #
        # Example: 'Paris' or 'Acme, Ltd.'
        label: 'LDAP'

        host: 'localhost'
        port: 389
        uid: 'uid'
        #uid: 'sAMAccountName'
        method: 'plain' # "tls" or "ssl" or "plain"
        bind_dn: 'cn=Manager,dc=duzzle,dc=com'
        password: 'your-pass'

        # Set a timeout, in seconds, for LDAP queries. This helps avoid blocking
        # a request if the LDAP server becomes unresponsive.
        # A value of 0 means there is no timeout.
        timeout: 10

        # This setting specifies if LDAP server is Active Directory LDAP server.
        # For non AD servers it skips the AD specific queries.
        # If your LDAP server is not AD, set this to false.
        active_directory: false

        # If allow_username_or_email_login is enabled, GitLab will ignore everything
        # after the first '@' in the LDAP username submitted by the user on login.
        #
        # Example:
        # - the user enters 'jane.doe@example.com' and 'p@ssw0rd' as LDAP credentials;
        # - GitLab queries the LDAP server with 'jane.doe' and 'p@ssw0rd'.
        #
        # If you are using "uid: 'userPrincipalName'" on ActiveDirectory you need to
        # disable this setting, because the userPrincipalName contains an '@'.
        allow_username_or_email_login: false

        # To maintain tight control over the number of active users on your GitLab installation,
        # enable this setting to keep new users blocked until they have been cleared by the admin
        # (default: false).
        block_auto_created_users: false

        # Base where we can search for users
        #
        #   Ex. ou=People,dc=gitlab,dc=example
        #
        base: 'ou=people,dc=your-corp,dc=com'

        # Filter LDAP users
        #
        #   Format: RFC 4515 http://tools.ietf.org/search/rfc4515
        #   Ex. (employeeType=developer)
        #
        #   Note: GitLab does not support omniauth-ldap's custom filter syntax.
        #
        user_filter: 'objectClass=inetOrgPerson'

        # LDAP attributes that GitLab will use to create an account for the LDAP user.
        # The specified attribute can either be the attribute name as a string (e.g. 'mail'),
        # or an array of attribute names to try in order (e.g. ['mail', 'email']).
        # Note that the user's LDAP login will always be the attribute specified as `uid` above.
        attributes:
          # The username will be used in paths for the user's own projects
          # (like `gitlab.example.com/username/project`) and when mentioning
          # them in issues, merge request and comments (like `@username`).
          # If the attribute specified for `username` contains an email address,
          # the GitLab username will be the part of the email address before the '@'.
          username: ['uid', 'userid', 'sAMAccountName']
          email:    ['mail', 'email', 'userPrincipalName']

          # If no full name could be found at the attribute specified for `name`,
          # the full name is determined using the attributes specified for
          # `first_name` and `last_name`.
          name:       'cn'
          first_name: 'givenName'
          last_name:  'sn'

```





### 使用IP作为服务器地址，需要修改host配置

* 修改 nginx 的 server_name 配置为IP值

* 修改 config/gitlab.yml 中 host 为 IP值


### 发送通知的邮箱设置

默认已经安装mail服务器，可以向外发送邮件。

config/gitlab.yml

```
email_from: example@example.com
email_display_name: GitLab
email_reply_to: noreply@example.com
email_subject_suffix: ''
```

用户收到的邮件显示发件人为：Gitlab<example@example.com>


#### 配置外部smtp服务

* gitlab 9.1.0 , 8.x 试过，可用

修改 config/gitlab.yml

``` yml
email_from: your_mail@126.com
email_display_name: your_mail@126.com
email_reply_to: your_mail@126.com
```

拷贝 config/intializers/smtp_settings.rb.sample 为 smtp_settings.rb 后修改

``` ruby
if Rails.env.production?
  Rails.application.config.action_mailer.delivery_method = :smtp

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: "smtp.126.com",
    port: 25,
    user_name: "your_mail@126.com",
    password: "your_mail_password",
    domain: "126.com",
    authentication: :login,
    enable_starttls_auto: true,
    openssl_verify_mode: 'none'
  }
end
```

配置完，root 用户登录 》 右上角 Admin Area 图标 》 Monitoring 》 Health Check
看看有没错误。

### 检查Gitlab状态

```
sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production

sudo -u git -H bundle exec rake gitlab:check RAILS_ENV=production
```

### 使用 ssh 来 clone 代码库的时候，提示输入 git 用户的密码

* 前提
正确配置了 ssh 的公钥， 右上角用户图标 > settings > SSH Keys

* 原因
  * 服务器上sshd没配置好，或者，
  * git 的 HOME 目录或者 .ssh 目录的读写权限没配置好
  ```
  chmod 700 /home/git/.ssh
  chmod 600 /home/git/.ssh/authorized_keys
  chmod go-w /home/git
  ```



### Gitlab Pages 配置

* 参考：
  * [Gitlab Pages Project](https://gitlab.com/gitlab-org/gitlab-pages)
  * <https://docs.gitlab.com/ce/administration/pages/>
  * <https://docs.gitlab.com/ee/user/project/pages/>
  * <https://docs.gitlab.com/ee/administration/pages/>
  * <https://docs.gitlab.com/ee/user/project/pages/index.html>

#### 从源码安装 Gitlab Pages

##### 安装&配置 Go

Go-lang 安装好，$GOPATH 配置好

例如

```
vim /etc/profile.d/custom.sh

# 添加
export PATH=$PATH:/usr/local/go/bin:/opt/go/bin
export GOPATH=/opt/go
```



##### 下载&编译 Gitlab Pages 源码

```
# go get gitlab.com/gitlab-org/gitlab-pages
# cd $GOPATH/src/gitlab.com/gitlab-org/gitlab-pages/

# git checkout tag-your-want
# git describe --tags --abbrev=0
v0.4.2

# git rev-parse --short HEAD
dccd0f2

# go build -o gitlab-pages --ldflags="-X main.VERSION=v0.4.2 -X main.REVISION=dccd0f2"

# 编译完成，试一下
# ./gitlab-pages -version
```



##### 安装 Gitlab Pages

```
cp $GOPATH/src/gitlab.com/gitlab-org/gitlab-pages/ /home/git
chown -R git.git /home/git/gitlab-pages/
```

* 【注】 service gitlab start 启动时，会在 gitlab 的同一目录中找 gitlab-pages
```
/home/git/source/gitlab-ce/lib/support/init.d/gitlab
  Line 46: gitlab_pages_dir=$(cd $app_root/../gitlab-pages 2> /dev/null && pwd)
```


##### 配置 Gitlab Pages 完成， 重启 Gitlab

```
$ service gitlab restart
Shutting down GitLab Unicorn
Shutting down GitLab Sidekiq
Shutting down GitLab Workhorse
Shutting down gitlab-pages
.
GitLab is not running.
Starting GitLab Unicorn
Starting GitLab Sidekiq
Starting GitLab Workhorse
Starting GitLab Pages
.
The GitLab Unicorn web server with pid 6414 is running.
The GitLab Sidekiq job dispatcher with pid 6485 is running.
The GitLab Workhorse with pid 6447 is running.
The GitLab Pages with pid  is running.
GitLab and all its components are up and running.
```

##### TODO... 虽然 Gitlab-pages 启动了，仍然无法访问到

要将  /home/git/gitlab/lib/support/nginx/gitlab-pages 配置到 nginx

用 nginx 反向代理到 gitlab-pages 这个 Go http 服务器。

只是在局域网中使用，没有配置 domain，gitlab-pages 的 domain 逻辑反而成了麻烦，无法访问的项目页面。


#### 使用 nginx 代替 Gitlab-pages

在局域网中应为domain不熟悉，gitlab-pages 没配置起来。

不讲究，就先用nginx代替了。

##### 1） gitlab启动时，不再启动 gitlab-pages

```
# /etc/default/gitlab
gitlab_pages_enabled=false
```

service gitlab start 启动的时候，就不会把 gitlab-pages deamon 运行起来了

##### 2） 配置 nginx

```
## GitLab
##

## Pages serving host
server {
  listen 8091;
  #listen 0.0.0.0:80;
  #listen [::]:80 ipv6only=on;

  ## Replace this with something like pages.gitlab.com
  server_name 192.168.251.72;
  #server_name ~^.*\.YOUR_GITLAB_PAGES\.DOMAIN$;

  ## Individual nginx logs for GitLab pages
  access_log  /var/log/nginx/gitlab_pages_access.log;
  error_log   /var/log/nginx/gitlab_pages_error.log;

  # WI: DO NOT USE gitlab-org/gitlab-pages , no idea about how to config this Go Server
  #location / {
  #  proxy_set_header    Host                $http_host;
  #  proxy_set_header    X-Real-IP           $remote_addr;
  #  proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
  #  proxy_set_header    X-Forwarded-Proto   $scheme;
  #  # The same address as passed to GitLab Pages: `-listen-proxy`
  #  proxy_pass          http://localhost:8090/;
  #}

  location / {
    root /home/git/gitlab/shared/pages;
    index  index.html index.htm;
  }

  # Define custom error pages
  error_page 403 /403.html;
  error_page 404 /404.html;
}
```

##### 3） 配置 gitlab

/home/git/gitlab/config/gitlab.yml

```yml
  ## GitLab Pages
  pages:
    enabled: true
    # The location where pages are stored (default: shared/pages).
    # path: shared/pages

    # The domain under which the pages are served:
    # http://group.example.com/project
    # or project path can be a group page: group.example.com
    host: 192.168.1.101
    port: 8091
    #host: example.com
    #port: 80 # Set to 443 if you serve the pages with HTTPS
    https: false # Set to true if you serve the pages with HTTPS

```

##### 4） 修改 gitlab 代码

* app/models/project.rb
```ruby
  def pages_url
    subdomain, _, url_path = full_path.partition('/')

    # 直接返回nginx上配置的地址，<githost>/<group>/<project>/pages 页面上显示如下地址
    return "#{Gitlab.config.pages.url}/#{subdomain}/#{url_path}/public/"
    
    ...
  end
```


##### 5） 重启 gitlab

```shell
service gitlab restart
```






### Gitlab Runner

* [gitlab-runner project](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner)
* [Install GitLab Runner using the official GitLab repositories](https://docs.gitlab.com/runner/install/linux-repository.html)
* [GitLab Runner](https://docs.gitlab.com/runner/)
* [GitLab Runner Commands](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/commands/README.md)
* <http://blog.csdn.net/lusyoe/article/details/52714121>

要使用 Gitlab-ci ，必须安装 Gitlab Runner




#### 从源码安装 Gitlab-Runner

##### 安装&配置 Go

Go-lang 安装好，$GOPATH 配置好

例如

```
vim /etc/profile.d/custom.sh

# 添加
export PATH=$PATH:/usr/local/go/bin:/opt/go/bin
export GOPATH=/opt/go
```




##### 下载 Gitlab-Runner 源码

```
go get gitlab.com/gitlab-org/gitlab-ci-multi-runner
cd $GOPATH/src/gitlab.com/gitlab-org/gitlab-ci-multi-runner/

# 使用 gitlab-ci 的 9-1-stable 来配合 Gitlab 的 9-1-stable
git checkout 9-1-stable
```



##### 编译&安装 Gitlab-Runner

```
make deps
make install
```

  * 注：make 过程中可能要下载 https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/master/docker/prebuilt-x86_64.tar.xz ，可能要翻墙




##### 前台方式启动 gitlab-runner

```
gitlab-ci-multi-runner run
```





#### Gitlab-Runner 安装为后台 service

参考： <https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/commands/README.md#service-related-commands>

```shell
gitlab-ci-multi-runner install --user=root --working-directory=/home/git
```

效果：
1. 生成 /etc/rc.d/init.d/gitlab-runner ，可以使用 service gitlab-runner start/stop/restart/status
2. 设置为系统启动就运行，可以用  chkconfig --list gitlab-runner  看看
3. 在 Gitlab 网站 运行 pipeline，会在 /home/git/builds 目录中checkout代码并编译，类似 jenkins 的 jobs 目录。


* 【注】： 如果要调整配置，或者 install 错了，可以执行 gitlab-ci-multi-runner uninstall 来删除service





#### 在 Gitlab 中使用 Gitlab-runner shared runner


##### 创建 runner 实例

参照如下例子，配置信息创建后保存在 /etc/gitlab-runner/config.toml 【root 用户 run】 或者， $HOME/.gitlab-runner/config.toml 【非 root 用户 run】

```shell
shell> gitlab-ci-multi-runner register

WARNING: Running in user-mode.
WARNING: The user-mode requires you to manually start builds processing:
WARNING: $ gitlab-runner run
WARNING: Use sudo for system-mode:
WARNING: $ sudo gitlab-runner...

Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
http://192.168.1.101:9088

Please enter the gitlab-ci token for this runner:
6WtTi51kQ1ExP4y-JB80d   # 在 Gitlab admin area > Overview > Runners > Registration token

Please enter the gitlab-ci description for this runner:
[127.0.0.1]: shared-runner

Please enter the gitlab-ci tags for this runner (comma separated):
shared

Whether to run untagged builds [true/false]:
[false]: true

Whether to lock Runner to current project [true/false]:
[false]:
Registering runner... succeeded                     runner=6WtTi51k

Please enter the executor: docker, docker-ssh, shell, ssh, docker+machine, parallels, virtualbox, docker-ssh+machine, kubernetes:
shell

Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

```

* 另外一个例子

```shell
Running in system-mode.

Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/ci):
http://192.168.1.2/ci   // 在这里输入gitlab安装的服务器ip/ci 即可
Please enter the gitlab-ci token for this runner:
eaYyokc57xxZbzAsoshT    // 这里的token可通过Gitlab上的项目Runners选项查看，在下面贴一张截图
Please enter the gitlab-ci description for this runner:
[E5]: spring-demo       // 这里填写一个描述信息，不太重要，看着填吧
Please enter the gitlab-ci tags for this runner (comma separated):
demo                    // 在这里填写tag信息，多个tag可通过逗号,分割。
Registering runner... succeeded                     runner=eaYyokc5
Please enter the executor: docker, docker-ssh, parallels, shell, ssh, virtualbox, docker+machine, docker-ssh+machine:
shell                   // 在这里需要输入runner的执行方式，因为我的Gitlab和runner是安装在同一台服务器上的，直接输入shell
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
// 出现这样信息表示服务端的配置就已经成功结束了，如果需要使用到自动构建，还需要再添加一个配置文件，下面说说这个。
```



##### 启动 runner 服务

```
gitlab-ci-multi-runner run
```



##### 在项目中创建 .gitlab-ci.yml

项目首页 > Project > CI configuration



##### 手动执行 CI

项目首页 > Pipelines



### Ghost User

如果Gitlab 管理员删除掉一个用户，系统会创建一个幽灵用户（Ghost User）（如果之前没有），将所有被删用户的issue都只给Ghost 用户。

该用户很牛，无法登陆，无法被root用户删除。

幽灵用户的自述：

```
This is a "Ghost User", created to hold all issues authored by users that have since been deleted. This user cannot be removed.
```


### 关闭注册

1. 访问 admin/application_settings
2. Sign-up Restrictions > Sign-up Enable 勾掉
3. Save

* **注意** 关闭注册之后， 之前没登录过度ldap用户也是不能登入。



### Gitlab 汉化

参见 [GitLab 中文社区版 ](https://gitlab.com/larryli/gitlab/)




### 关闭用户创建Group的权限

* 参考：
  * <https://docs.gitlab.com/ce/workflow/groups.html#allowing-only-admins-to-create-groups>
  * <https://stackoverflow.com/a/38601118>

Gitlab 默认所有用户都有创建 Group 的权限，关闭方法如下：

修改 gitlab/config/gitlab.yml

```yml
gitlab:
  default_can_create_group: false  # default: true
```

重启之后，再创建新用户，就不再有 CREATE GROUP 的权限了。

<font color="red">但是，之前的老用户仍然有 CREATE GROUP 的权限。</font>

#### 去除现有用户的 CREATE GROUP 的权限

* 参考：
  * <https://stackoverflow.com/a/33278917>

1. Enter the Admin control panel
2. Select 'Users'
3. Select the user(s) in question and click 'Edit'
4. Scroll down to 'Access' and un-tick 'Can Create Group'








