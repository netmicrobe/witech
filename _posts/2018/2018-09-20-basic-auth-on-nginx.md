---
layout: post
title: 在nginx上使用basic authentication
categories: [ cm, nginx ]
tags: [apache2-utils, httpd-tools, htpasswd]
---


---

* 参考： 
  * <https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/>

---




### 创建密码文件 .htpasswd

~~~
htpasswd -c /etc/nginx/.htpasswd guest
New password:
Re-type new password:
Adding password for user guest
~~~

### 添加用户

~~~
htpasswd /etc/nginx/.htpasswd guest-02
~~~


### 在nginx上配置 HTTP Basic Authentication

~~~
location /status {                                       
    auth_basic           “Administrator’s Area”;
    auth_basic_user_file /etc/nginx/.htpasswd; 
}
~~~




























