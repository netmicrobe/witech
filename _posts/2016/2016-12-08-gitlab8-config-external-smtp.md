---
layout: post
title: Gitlab 8 配置外部smtp服务
categories: [cm, git, gitlab]
tags: [cm, git, gitlab]
---


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

