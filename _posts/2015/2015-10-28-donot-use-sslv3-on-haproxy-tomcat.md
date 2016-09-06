---
layout: post
title: 配置 haproxy 和 tomcat 不使用 sslv3 协议，修补 SSL TLS 受诫礼(BAR-MITZVAH)攻击漏洞(CVE-2015-2808)
description: 
categories: [cm, security]
tags: [cm, ssl, security]
---




## HAPROXY

修改haproxy1.5配置文件

```
vi /opt/srv/haproxy/haproxy_web_ssl.cfg

frontend http-in
bind *:443 ssl crt /opt/srv/haproxy/play.cn.pem no-sslv3 #不使用sslv3协议。
```
 
frontend http-in 字段下，增加no-sslv3 解决SSL 3.0 POODLE攻击信息泄露漏洞(CVE-2014-3566)攻击漏洞

ciphers HIGH:MEDIUM:!aNULL:!MD5:!RC4 强制不使用RC4加密算法，解决SSL/TLS 受诫礼(BAR-MITZVAH)攻击漏洞(CVE-2015-2808)。

配置文件修改完整字段为：

bind *:443 ssl crt /opt/srv/haproxy/play.cn.pem no-sslv3 ciphers HIGH:MEDIUM:!aNULL:!MD5:!RC4

已映射192.168.206.103至公网地址202.102.39.20：443，安全扫描漏洞已处理（见附件扫描结果）。请测试组协助验证业务功能。


## TOMCAT

对tomcat进行配置修改 

修改conf文件夹下 server.xml的内容 

修改如下: 

{% highlight xml %}
<Connector 
port="8443" 
protocol="HTTP/1.1" 
SSLEnabled="true" 
maxThreads="150" 
scheme="https" 
secure="true" 
clientAuth="false" 
sslEnabledProtocols="TLSv1,TLSv1.1,TLSv1.2" ciphers="TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA"/>
{% endhighlight %}

重启后验证漏洞是否修复以及浏览器的兼容性
