---
layout: post
title: 使用systemd / systemctl 管理后台服务，关联 runlevel, service, daemon, init.d
categories: [ cm, linux ]
tags: []
---


* 参考： <https://dynacont.net/documentation/linux/Useful_SystemD_commands/>



## List all running services

~~~ shell
# 列出所有service类型的unit
systemctl list-units --type=service --all
~~~

其他查看命令如下：

~~~ shell
systemctl # 列出所有的系统服务
systemctl list-units # 列出所有启动unit
systemctl list-unit-files # 列出所有启动文件
systemctl list-units –type=service –all # 列出所有service类型的unit
systemctl list-units –type=service –all grep cpu # 列出 cpu电源管理机制的服务
systemctl list-units –type=target –all # 列出所有target
systemctl list-dependencies # 查看当前运行级别target(mult-user)启动了哪些服务
~~~



## Start/stop or enable/disable services

~~~ shell
# Start/stop a service immediately:
systemctl start foo.service
systemctl stop foo.service
systemctl restart foo.service
systemctl status foo.service

# service 自启动
systemctl enable foo.service
systemctl disable foo.service

# 0 indicates that it is enabled. 1 indicates that it is disabled
systemctl is-enabled foo.service; echo $?

~~~




## runlevel 设置

### How do I change the default runlevel?

~~~ shell
rm /etc/systemd/system/default.target

# Switch to runlevel 3 by default
ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target

# Switch to runlevel 5 by default
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
~~~

Ubuntu 20.04 上没找到文件 `/etc/systemd/system/default.target`

~~~sh
# 查看默认启动target
root# systemctl get-default
graphical.target

# 查看默认启动target
root# systemctl set-default multi-user.target
~~~


### 切换当前运行的runlevel

~~~ shell
# You can switch to ‘runlevel 3′ by running
systemctl isolate multi-user.target (or) systemctl isolate runlevel3.target

# You can switch to ‘runlevel 5′ by running
systemctl isolate graphical.target (or) systemctl isolate runlevel5.target
~~~



## SystemD cheatsheet

service foobar start  | systemctl start foobar.service  | Used to start a service (not reboot persistent)
service foobar stop  | systemctl stop foobar.service  | Used to stop a service (not reboot persistent)
service foobar restart  | systemctl restart foobar.service  | Used to stop and then start a service
service foobar reload  | systemctl reload foobar.service  | When supported, reloads the config file without interrupting pending operations.
service foobar condrestart  | systemctl condrestart foobar.service  | Restarts if the service is already running.
service foobar status  | systemctl status foobar.service  | Tells whether a service is currently running.
ls /etc/rc.d/init.d/  | ls /lib/systemd/system/*.service /etc/systemd/system/*.service  | Used to list the services that can be started or stopped
chkconfig foobar on  | systemctl enable foobar.service  | Turn the service on, for start at next boot, or other trigger.
chkconfig foobar off  | systemctl disable foobar.service  | Turn the service off for the next reboot, or any other trigger.
chkconfig foobar  | systemctl is-enabled foobar.service  | Used to check whether a service is configured to start or not in the current environment.
chkconfig foobar –list  | ls /etc/systemd/system/*.wants/foobar.service  | Used to list what levels this service is configured on or off
chkconfig foobar –add  |    | Not needed, no equivalent.



## List the current run level

~~~
# systemctl list-units --type=target
~~~






