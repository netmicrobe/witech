---
layout: post
title: 在 nginx + passenger + sqlite3 上使用 redmine
categories: [ cm, ruby ]
tags: [ ruby, rails, nginx, passenger, redmine ]
---

## rvm

~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | sudo bash -s stable
usermod -a -G rvm root
mkdir -p /root/.rvm/user/
echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db
source /etc/profile.d/rvm.sh
~~~

## 重启shell

## 利用 rvm 安装 ruby

~~~
rvm --version
rvm list known
rvm install 2.3
ruby --version
rvm use 2.3 --default
ruby --version
~~~


## redmine config

config/database.yml

~~~
production:
  adapter: sqlite3
  database: db/redmine.sqlite3
  encoding: utf8
~~~

【适用国内】gem sources -r https://rubygems.org/ -a http://gems.ruby-china.org/

~~~
gem install bundler
yum install -y mysql-devel
yum install -y ImageMagick ImageMagick-devel
bundle install --without development test
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake redmine:load_default_data
~~~

【测试】
~~~
bundle exec rails server webrick -e production -b 192.168.1.101
~~~


## Nginx + Passenger

~~~
gem install passenger --no-rdoc --no-ri
yum install -y libcurl-devel
passenger-install-nginx-module --prefix=/opt/nginx
~~~

### 【nginx 配置】 nginx.conf

~~~ conf
user  root;
pid        logs/nginx.pid;
...

http {
    passenger_user_switching off;
    passenger_default_user root;
    passenger_root /usr/local/rvm/gems/ruby-2.3.4/gems/passenger-5.2.0;
    passenger_ruby /usr/local/rvm/gems/ruby-2.3.4/wrappers/ruby;
    passenger_app_env development;  # 以 development 配置启动 rails
    
    # 默认为on，如果是在 virtualbox 上，改为 off，
    # 否则文件在文件系统中被覆盖，nginx还是读出原来的文件内容
    # 参考：https://stackoverflow.com/a/13116771
    # 参考：https://forums.virtualbox.org/viewtopic.php?f=3&t=33201
    # 参考：https://www.cnblogs.com/zqifa/p/nginx-8.html
    sendfile        off;

    server {
      listen 2280;
      server_name localhost;
      passenger_enabled on;
      client_max_body_size 50M; # some upload files may be large
      location / {
        root   /opt/redmine342/public;
        index  index.html index.htm;
      }
      ...
    }
...
}
~~~


#### passenger_app_env development; 设置运行环境为development

* 参考： <https://stackoverflow.com/a/20845689/3316529>

~~~ conf
http {
  passenger_root /home/user/.rvm/gems/ruby-2.1.0@app/gems/passenger-4.0.29;
  passenger_ruby /home/user/.rvm/wrappers/ruby-2.1.0@app/ruby;
  passenger_app_env development;
}
~~~






### nginx service 

1. 创建 /etc/init.d/nginx ，内容如下一小节
2. `rm -f /opt/nginx/logs/nginx.pid`
2. `service nginx start`

#### /etc/init.d/nginx

~~~
#!/bin/sh
#
# nginx        Startup script for nginx
#
# chkconfig: - 85 15
# processname: nginx
# config: /etc/nginx/nginx.conf
# config: /etc/sysconfig/nginx
# pidfile: /var/run/nginx.pid
# description: nginx is an HTTP and reverse proxy server
#
### BEGIN INIT INFO
# Provides: nginx
# Required-Start: $local_fs $remote_fs $network
# Required-Stop: $local_fs $remote_fs $network
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start and stop nginx
### END INIT INFO

# Source function library.
. /etc/rc.d/init.d/functions

if [ -L $0 ]; then
    initscript=`/bin/readlink -f $0`
else
    initscript=$0
fi

sysconfig=`/bin/basename $initscript`

if [ -f /etc/sysconfig/$sysconfig ]; then
    . /etc/sysconfig/$sysconfig
fi

nginx=${NGINX:-/opt/nginx/sbin/nginx}
prog=`/bin/basename $nginx`
conffile=${CONFFILE:-/opt/nginx/conf/nginx.conf}
lockfile=${LOCKFILE:-/var/lock/subsys/nginx}
pidfile=${PIDFILE:-/opt/nginx/logs/nginx.pid}
SLEEPSEC=${SLEEPSEC:-1}
UPGRADEWAITLOOPS=${UPGRADEWAITLOOPS:-5}
CHECKSLEEP=${CHECKSLEEP:-3}
RETVAL=0

start() {
    echo -n $"Starting $prog: "

    daemon --pidfile=${pidfile} ${nginx} -c ${conffile}
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch ${lockfile}
    return $RETVAL
}

stop() {
    echo -n $"Stopping $prog: "
    killproc -p ${pidfile} ${prog}
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfile} ${pidfile}
}

reload() {
    echo -n $"Reloading $prog: "
    killproc -p ${pidfile} ${prog} -HUP
    RETVAL=$?
    echo
}

upgrade() {
    oldbinpidfile=${pidfile}.oldbin

    configtest -q || return
    echo -n $"Starting new master $prog: "
    killproc -p ${pidfile} ${prog} -USR2
    echo

    for i in `/usr/bin/seq $UPGRADEWAITLOOPS`; do
        /bin/sleep $SLEEPSEC
        if [ -f ${oldbinpidfile} -a -f ${pidfile} ]; then
            echo -n $"Graceful shutdown of old $prog: "
            killproc -p ${oldbinpidfile} ${prog} -QUIT
            RETVAL=$?
            echo
            return
        fi
    done

    echo $"Upgrade failed!"
    RETVAL=1
}

configtest() {
    if [ "$#" -ne 0 ] ; then
        case "$1" in
            -q)
                FLAG=$1
                ;;
            *)
                ;;
        esac
        shift
    fi
    ${nginx} -t -c ${conffile} $FLAG
    RETVAL=$?
    return $RETVAL
}

rh_status() {
    status -p ${pidfile} -b ${nginx} ${nginx}
}

check_reload() {
    templog=`/bin/mktemp --tmpdir nginx-check-reload-XXXXXX.log`
    trap '/bin/rm -f $templog' 0
    /usr/bin/tail --pid=$$ -n 0 --follow=name /var/log/nginx/error.log > $templog &
    /bin/sleep 1
    /bin/echo -n $"Sending reload signal to $prog: "
    killproc -p ${pidfile} ${prog} -HUP
    /bin/echo
    /bin/sleep $CHECKSLEEP
    /bin/grep -E "\[emerg\]|\[alert\]" $templog
}

# See how we were called.
case "$1" in
    start)
        rh_status >/dev/null 2>&1 && exit 0
        start
        ;;
    stop)
        stop
        ;;
    status)
        rh_status
        RETVAL=$?
        ;;
    restart)
        configtest -q || exit $RETVAL
        stop
        start
        ;;
    upgrade)
        rh_status >/dev/null 2>&1 || exit 0
        upgrade
        ;;
    condrestart|try-restart)
        if rh_status >/dev/null 2>&1; then
            stop
            start
        fi
        ;;
    force-reload|reload)
        reload
        ;;
    configtest)
        configtest
        ;;
    check-reload)
        check_reload
        RETVAL=0
        ;;
    *)
        echo $"Usage: $prog {start|stop|restart|condrestart|try-restart|force-reload|upgrade|reload|status|help|configtest|check-reload}"
        RETVAL=2
esac

exit $RETVAL
~~~





### iptables

~~~
iptables -L --line-numbers -n
# reject all rule 的序号，例如，5，accept rule 要插入在它之前。
iptables -I INPUT 5 -p tcp --dport 2280 -j ACCEPT
service iptables save
service iptables restart
~~~


### nginx 自启动

~~~
chkconfig --add nginx
chkconfig --list nginx
~~~



















