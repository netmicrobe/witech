---
layout: post
title: Redmine配置邮箱
categories: [cm, redmine]
tags: [cm, redmine]
---

## 配置configuration.yml

完成后才能在redmine的Administrator页面中看到Email设置。
 
redmine-2.4.2\config\configuration.yml

以126邮箱为例；按照yml文件配置规则，不能有TAB，缩进用2个空格。

```
default:
  # Outgoing emails configuration (see examples above)
  email_delivery:
       delivery_method: :smtp
       smtp_settings:
      address: smtp.126.com
      port: 25
      domain: smtp.126.com
      authentication: :login
      user_name: "your-email-account@126.com"
      password: "your-email-password"
      enable_starttls_auto: true
```

## 在管理页面中配置下邮箱地址

![](/images/cm/redmine/config_mail_on_redmine_webpage.png)
 
 