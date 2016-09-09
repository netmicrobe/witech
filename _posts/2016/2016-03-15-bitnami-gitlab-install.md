---
layout: post
title: Bitnami Gitlab 安装
categories: [cm, git]
tags: [cm, git, gitlab]
---



## 在Bitnami上下载 64 位的安装包

<https://bitnami.com/stack/gitlab>

拷贝到Linux 上，chmod 改成可执行。然后以root权限执行安装包。

使用的安装包：bitnami-gitlab-8.5.7-0-linux-x64-installer.run

在 Ubuntu 14.04 x64和i386都试过， 安装失败，老报告权限问题，即使使用root权限，也没啥用。
在 Red Hat 5.8 上安装无问题。




## Gitlab 启动/关闭

根目录下的 ctlscript.sh 是控制脚本，bitnami的风格啊！

./ctlscript.sh status
./ctlscript.sh start
./ctlscript.sh stop





## SMTP 邮件发送设置

* 参考
  * <http://guides.rubyonrails.org/action_mailer_basics.html>
  * <http://guides.ruby-china.org/configuring.html#configuring-action-mailer>

修改 SMTP 邮件服务器设置，以 126 邮箱为例子：

> /opt/gitlab-8.5.7-0/apps/gitlab/htdocs/config/environments/production.rb

```
  config.action_mailer.smtp_settings = {
    :address => "smtp.126.com",
    :port => 25,
    :domain => "126.com",
    :authentication => :plain,
    :user_name => "eg_noti_jmeter@126.com",
    :password => "此处是密码",
    :openssl_verify_mode => 'none',
    #:enable_starttls_auto => false
  }
```

> /opt/gitlab-8.5.7-0/apps/gitlab/htdocs/config/gitlab.yml

这边email_from 要和smtp中账号保持一致，126服务器的安全要求。

```
gitlab:
    ... ...
    email_from: eg_noti_jmeter@126.com
    ... ...
```

补充说明：如果账号不一致，在管理员界面 Background Jobs 中 “重试” 就会看到失败。
去服务器查看日志，/opt/gitlab-8.5.7-0/apps/gitlab/htdocs/log/sidekiq.log 中能看到错误信息：
Net::SMTPFatalError: 553 Mail from must equal authorized user
据此也可以看出，gitlab 利用 gitlab_sidekiq 组件来生成后台异步任务，发送邮件。失败了，还能等段时间自动重试。高大上啊！！


## 修改 uploads 文件夹权限

安装完默认uploads文件夹权限没有可执行权限，导致上传的文件，访问不了 403.

具体原因不了解，可能是 cgi 模块 passenger 只能接受可执行的文件，然后才会把静态文件给apache。

PS：uploads 目录的位置：/opt/gitlab-8.5.7-0/apps/gitlab/htdocs/public/uploads






