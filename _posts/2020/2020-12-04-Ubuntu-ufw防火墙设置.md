---
layout: post
title: 2020-12-04-Ubuntu-ufw防火墙设置.md
categories: [cm, linux, ubuntu, ufw]
tags: [firewall]
---

* 参考： 
  * [ubuntu ufw 配置](https://blog.csdn.net/fox_wayen/article/details/90646533)
  * []()
  * []()


~~~
sudo apt-get install ufw       #安装
~~~

~~~
sudo ufw enable       #开启防火墙
sudo ufw disable      #关闭防火墙
sudo ufw reset        #重置防火墙
~~~

~~~
sudo ufw status
sudo ufw status numbered  # 按编号显示
~~~

~~~
sudo ufw default deny incoming
sudo ufw default allow outgoing
# 转换日志状态
sudo ufw logging on|off
# 设置默认策略
sudo ufw default allow|deny
~~~

### 允许SSH连接

~~~
sudo ufw allow ssh
# 或
sudo ufw allow 22
~~~


### 允许特定单个端口连接

~~~
sudo ufw allow 80
# 或
sudo ufw allow http
~~~

指定网络接口：
    假如你的 eth0 为公网地址，你同事需要向外开放 80 端口，你可以如下操作：
        `sudo ufw allow in on eth0 to any port 80`
    另外，假如你想你的 MySQL 服务器（监听 3306）只接受通过内网网卡 eth1 的请求，你可以这样：
        `sudo ufw allow in on eth1 to any port 3306`


### 允许特定端口范围连接

~~~
sudo ufw allow 1000:2000/tcp
sudo ufw allow 2001:3000/udp
~~~


### 允许特定IP地址链接

~~~
# 允许特定IP所有端口的连接
sudo ufw allow from 111.111.111.111
 
# 允许特定IP特定端口的连接
sudo ufw allow from 111.111.111.111 to any port 22
 
#允许某个网段的主机访问
sudo ufw allow from 192.168.1.1/24 to any port 11211
 
sudo ufw allow proto udp 192.168.0.1 port 53 to 192.168.0.2 port 53
 
# 打开来自192.168.0.1的tcp请求的22端口：
$sudo ufw allow proto tcp from 192.168.0.1 to any port 22
~~~


### 拒绝特定连接

~~~

# 拒绝http连接
sudo ufw deny http
 
#执行禁止IP命令
sudo ufw deny/allow from 192.168.31.1  （即：禁止/允许192.168.31.1这个IP访问所有的本机端口）
 
# UFW同时支持出入口过滤。用户可以使用in或out来指定向内还是向外。如果未指定，默认是in 
sudo ufw allow in http # 许可访问本机http端口
 
sudo ufw reject out smtp        # 禁止访问外部smtp端口，不告知“被防火墙阻止”
 
sudo ufw deny out to 192.168.1.1   # 禁止本机对192.168.1.1对外访问，告知“被防火墙阻止”
 
sudo ufw delete deny 80/tcp       # 要删除规则，只要在命令中加入delete就行了
~~~




### 删除规则

~~~
# 按规则编号防火墙规则
sudo ufw status numbered

# 按规则编号删除防火墙规则
sudo ufw delete 1

# 更改文件来配置防火墙
/etc/ufw/user.rules
~~~



### 使用IPv6



`sudo vi /etc/default/ufw`

然后，确认 IPv6 是否设置成 yes，如果没有则设置为 yes，大致如下：
 
~~~
IPV6=yes
~~~













