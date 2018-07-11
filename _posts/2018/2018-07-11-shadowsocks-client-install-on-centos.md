---
layout: post
title: CentOS上安装 Shadowsocks
categories: [ cm, network ]
tags: [ Shadowsocks, cnetos ]
---

---

* 参考: 
  * <http://shadowsocks.org/en/download/clients.html>
  * [CentOS 7 安装使用Shadowsocks客户端](https://blog.csdn.net/wh211212/article/details/79165415)
  * <http://blog.csdn.net/u012375924/article/details/78706910>
  * <https://www.zybuluo.com/ncepuwanghui/note/954160>
  * [CentOS 7 安装 shadowsocks 客户端](https://brickyang.github.io/2017/01/14/CentOS-7-%E5%AE%89%E8%A3%85-Shadowsocks-%E5%AE%A2%E6%88%B7%E7%AB%AF/)

---



### 安装epel源

~~~ shell
yum -y install epel-release
~~~


### 安装Shadowsocks客户端

~~~ shell
pip install shadowsocks
~~~

~~~ shell
[ root@ctos74x64: ~ ] # pip2.7 install shadowsocks
Collecting shadowsocks
  Downloading https://files.pythonhosted.org/packages/02/1e/e3a5135255d06813aca6631da31768d44f63692480af3a1621818008eb4a/shadowsocks-2.8.2.tar.gz
Building wheels for collected packages: shadowsocks
  Running setup.py bdist_wheel for shadowsocks ... done
  Stored in directory: /root/.cache/pip/wheels/5e/8d/b6/3e2243a7e116984b2c3597c122c29abcfeac77daa260079e88
Successfully built shadowsocks
Installing collected packages: shadowsocks
Successfully installed shadowsocks-2.8.2
~~~


### 配置Shadowsocks连接

#### 新建配置文件、默认不存在

~~~ shell
mkdir /etc/shadowsocks
vi /etc/shadowsocks/shadowsocks.json
~~~

#### 添加配置信息：前提是需要有ss服务器的地址、端口等信息

~~~ json
{
    "server":"x.x.x.x",  # Shadowsocks服务器地址
    "server_port":1035,  # Shadowsocks服务器端口
    "local_address": "127.0.0.1", # 本地IP
    "local_port":1080,  # 本地端口
    "password":"password", # Shadowsocks连接密码
    "timeout":300,  # 等待超时时间
    "method":"aes-256-cfb",  # 加密方式
    "fast_open": false,  # true或false。开启fast_open以降低延迟，但要求Linux内核在3.7+
    "workers": 1  #工作线程数 
}
~~~


#### 配置自启动

新建启动脚本文件 `/etc/systemd/system/shadowsocks.service`，内容如下：

~~~
[Unit]
Description=Shadowsocks
[Service]
TimeoutStartSec=0
ExecStart=/usr/local/bin/sslocal -c /etc/shadowsocks/shadowsocks.json
[Install]
WantedBy=multi-user.target
~~~


#### 启动Shadowsocks服务

~~~ shell
systemctl enable shadowsocks.service
systemctl start shadowsocks.service
systemctl status shadowsocks.service
~~~

#### 验证Shadowsocks客户端服务是否正常运行

~~~
curl --socks5 127.0.0.1:1080 http://httpbin.org/ip
~~~

* Shadowsock客户端服务已正常运行，则结果如下：
  ~~~
  {
    "origin": "x.x.x.x"       #你的Shadowsock服务器IP
  }
  ~~~


### 安装配置privoxy


#### 安装privoxy

~~~ shell
yum install privoxy -y
systemctl enable privoxy
systemctl start privoxy
systemctl status privoxy
~~~


#### 配置privoxy

修改配置文件 /etc/privoxy/config

~~~
listen-address 127.0.0.1:8118 # 8118 是默认端口，不用改
forward-socks5t / 127.0.0.1:1080 . #转发到本地端口，注意最后有个点
~~~

#### 设置http、https代理

~~~
# vi /etc/profile 在最后添加如下信息
PROXY_HOST=127.0.0.1
export all_proxy=http://$PROXY_HOST:8118
export ftp_proxy=http://$PROXY_HOST:8118
export http_proxy=http://$PROXY_HOST:8118
export https_proxy=http://$PROXY_HOST:8118
export no_proxy=localhost,172.16.0.0/16,192.168.0.0/16.,127.0.0.1,10.10.0.0/16

# 重载环境变量
source /etc/profile
~~~




#### 测试代理

~~~ shell
[root@aniu-k8s ~]# curl -I www.google.com 
HTTP/1.1 200 OK
Date: Fri, 26 Jan 2018 05:32:37 GMT
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=ISO-8859-1
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Server: gws
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
Set-Cookie: 1P_JAR=2018-01-26-05; expires=Sun, 25-Feb-2018 05:32:37 GMT; path=/; domain=.google.com
Set-Cookie: NID=122=PIiGck3gwvrrJSaiwkSKJ5UrfO4WtAO80T4yipOx4R4O0zcgOEdvsKRePWN1DFM66g8PPF4aouhY4JIs7tENdRm7H9hkq5xm4y1yNJ-sZzwVJCLY_OK37sfI5LnSBtb7; expires=Sat, 28-Jul-2018 05:32:37 GMT; path=/; domain=.google.com; HttpOnly
Transfer-Encoding: chunked
Accept-Ranges: none
Vary: Accept-Encoding
Proxy-Connection: keep-alive
~~~


#### 取消使用代理

~~~
while read var; do unset $var; done < <(env | grep -i proxy | awk -F= '{print $1}')
~~~



### 配置浏览器

#### Firefox 配置

1. Preference - Advanced - Network - Connection - Settings
2. Manual proxy configuration:
    * Http Proxy : 127.0.0.1
    * Port: 8118

























