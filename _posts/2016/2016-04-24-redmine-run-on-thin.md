---
layout: post
title: 在thin上运行redmine
categories: [cm, redmine]
tags: [cm, redmine, thin]
---

参考：

* <http://www.cnblogs.com/feichan/archive/2012/04/12/2443580.html>
* <http://rabelapp.com/t/140>

## 安装thin

gem install thin



## 安装thin到系统自启动

```
$ thin install
    Installing thin service at /etc/rc.d/thin ...
    mkdir -p /etc/rc.d
    writing /etc/rc.d/thin
    chmod +x /etc/rc.d/thin
    mkdir -p /etc/thin

    To configure thin to start at system boot:
    on RedHat like systems:
      sudo /sbin/chkconfig --level 345 thin on
    on Debian-like systems (Ubuntu):
      sudo /usr/sbin/update-rc.d -f thin defaults
    on Gentoo:
      sudo rc-update add thin default

    Then put your config files in /etc/thin
```

### 设置 thin 随系统启动

$ chkconfig --list thin

可能会提醒找不到文件，将启动脚本拷贝到init.d下面

$ mv /etc/rc.d/thin /etc/rc.d/init.d/thin

再设置下启动的run-level

```
$ chkconfig --level 345 thin on
$ chkconfig --list thin
```


## 配置thin，运行redmine

```
$ thin config -C /etc/thin/redmine-2.4.2.yml -c /opt/server/redmine-2.4.2 --servers 2 --port 3000 -e production --log log/thin.log
```

该命令按要求生成 redmine-2.4.2.yml 配置文件，内容如下：

{% highlight yml %}
chdir: /opt/server/redmine-2.4.2
environment: production
address: 0.0.0.0
port: 3000
timeout: 30
log: /opt/server/redmine-2.4.2/log/thin.log
pid: tmp/pids/thin.pid
max_conns: 1024
max_persistent_conns: 100
require: []
wait: 30
threadpool_size: 20
servers: 2
daemonize: true
{% endhighlight %}


## 在redmine项目中引用thin

修改 /opt/server/redmine-2.4.2/Gemfile

添加： gem "thin"

TODO：不知道问什么要加，否则启动就报错：

```
    Thin web server (v1.6.3 codename Protein Powder)
    Maximum connections set to 1024
    Listening on 0.0.0.0:3000, CTRL+C to stop
    Exiting!
    /usr/local/rvm/gems/ruby-1.9.3-p551/gems/thin-1.6.3/lib/thin/backends/tcp_server.rb:16:in `connect': cannot load such file -- thin/connection (LoadError)
```



## 启动thin

```
$ /etc/init.d/thin start
$ ps -ef | grep thin
```

如果没启动，到redmine-home/log/ 下面查下日志

按照之前配置，thin将启动2个实例，分别在端口 3000， 3001。下面用apache或者nigix做个负载均衡就好。




## 设置相对路径

修改 redmine-home/config/environment.rb

添加：

```
    # Add by wi
    # set relative path for redmine
    #
    # --prefix /redmine  shall adds to startup arguments
    # e.g.
    # thin config -C /etc/thin/redmine-2.4.2.yml -c /opt/server/redmine-2.4.2 --servers 2 --port 3000 -e production --log log/thin.log --prefix /redmine
Redmine::Utils::relative_url_root = "/redmine"
```

更新配置文件后重启

```
thin config -C /etc/thin/redmine-2.4.2.yml -c /opt/server/redmine-2.4.2 --servers 2 --port 3000 -e production --log log/thin.log --prefix /redmine
```



## Apache的负载均衡配置


查看下apache的module目录，负载均衡的module是否安装，一般都装了。

```
$ ls /usr/lib64/httpd/modules/*proxy*
```

添加如下设置到httpd.conf

```
# Add by wi : Redmine balancer
<IfModule proxy_balancer_module>
    <Proxy balancer://redminecluster>
        BalancerMember http://127.0.0.1:3000/redmine
        BalancerMember http://127.0.0.1:3001/redmine
    </Proxy>
    ProxyPass /redmine balancer://redminecluster
</IfModule>
```


## 配置邮件

### 在服务器上配置

cp config/configuration.yml.example configuration.yml

在 <redmine-home>/config/configuration.yml 中修改成如下设置（以126邮箱为例）：

```
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: smtp.126.com
      port: 25
      enable_starttls_auto: true
      domain: 126.com
      authentication: :login
      user_name: 'your-mail@126.com'
      password: 'your-mail-password'
```

### 在redmine网页上配置

Administration > Settings > Email Notifications

"Emission email address": your-mail@126.com






