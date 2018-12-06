---
layout: post
title: 使用web email client Rainloop
categories: [ cm, email ]
tags: [php]
---

* 参考
  * <http://www.rainloop.net/>
  * <https://www.dreamprc.com/2014/04/rainloop%e4%bd%bf%e7%94%a8%e5%bf%83%e5%be%97/>
  * <https://www.ithink.one/it/19-php-webmail-rainloop.html>
  * <>


## 安装 Rainloop

1. 使用xampp，启动apache、mysql
2. 配置httpd.conf后，重启apache
    ~~~
    alias /rainloop "D:/your-unzip-rainloop/rainloop-community-latest"
    <Directory "D:/your-unzip-rainloop/rainloop-community-latest">
        Options FollowSymlinks
        # Limit: Allow use of the directives controlling host access (Allow, Deny and Order).
        AllowOverride Limit
        Require all granted
    </Directory>
    ~~~
3. 访问 http://localhost/rainloop/?admin 进行配置
4. 配置域名（添加域名，例如 163.com）
5. 访问 http://localhost/rainloop ，使用邮箱帐号密码登录
    * 126.com 直接密码登录
    * 163.com 密码输入“邮箱授权码”，而不是实际密码，163麻烦些

## Rainloop的一般配置


### Admin - 联系人 - 存储(PDO)

存储类型为 mysql 时，要手动创建下数据库

~~~ sql
CREATE DATABASE rainloop DEFAULT COLLATE='utf8mb4_general_ci';
~~~



## Rainloop 邮箱配置

### 126.com

* IMAP
  imap.126.com
  端口 993
  加密 SSL/TLS
* SMTP
  smtp.126.com
  端口 465
  加密 SSL/TLS
* 勾选：使用认证

首页 http://localhost/rainloop/ 直接输入账号 xx@126.com 和密码登录


### 163.com

* IMAP
  imap.163.com
  端口 993
  加密 SSL/TLS
* SMTP
  smtp.163.com
  端口 465
  加密 SSL/TLS
* 勾选：使用认证


首页输入账号 xx@126.com 和“邮箱授权码”作为密码登录




