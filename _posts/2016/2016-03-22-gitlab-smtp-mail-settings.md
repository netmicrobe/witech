---
layout: post
title: GitLab smtp mail 设置
categories: [cm, git]
tags: [cm, git, gitlab]
---

## 参考

* [Using an external SMTP server with GitLab](https://elijahpaul.co.uk/using-an-smtp-server-with-gitlab/)
* [GitLab Documentation  SMTP settings](http://doc.gitlab.com/omnibus/settings/smtp.html)




## GitLab 配置通过 smtp.163.com 发送邮件

* 摘自：<https://ruby-china.org/topics/20450>

Git · sailorhero · 于 1 年前发布 · 最后由 odirus 于 9 月前回复 · 13268 次阅读

配置SMTP发送邮件配置，使用163邮箱。

```
$ sudo vi /etc/gitlab/gitlab.rb                            

# Change the external_url to the address your users will type in their browser
external_url 'http://xxhost.com'#Sending application email via SMTP
gitlab_rails['smtp_enable']=true
gitlab_rails['smtp_address']="smtp.163.com"
gitlab_rails['smtp_port']= 25 
gitlab_rails['smtp_user_name']="xxuser@163.com"
gitlab_rails['smtp_password']="xxpassword"
gitlab_rails['smtp_domain']="163.com"
gitlab_rails['smtp_authentication']= :login
gitlab_rails['smtp_enable_starttls_auto']=true
```

发送不成功，·sudo gitlab-ctl tail`检查日志报错如下：

```
2014-07-11_16:12:08.439452014-07-11T16:12:08Z12595TID-dxf7cSidekiq::Extensions::DelayedMailerJID-061604dc558ce8560b273cbeINFO:fail:0.574sec2014-07-11_16:12:08.449552014-07-11T16:12:08Z12595TID-dxf7cWARN:{"retry"=>true,"queue"=>"default","class"=>"Sidekiq::Extensions::DelayedMailer","args"=>["---\n- !ruby/class 'Notify'\n- :project_access_granted_email\n- - 4\n"],"jid"=>"061604dc558ce8560b273cbe","enqueued_at"=>1405094359.354158,"error_message"=>"553 Mail from must equal authorized user\n","error_class"=>"Net::SMTPFatalError","failed_at"=>"2014-07-11 15:59:28 UTC","retry_count"=>5,"retried_at"=>2014-07-1116:12:08UTC}
```

Google大法后，错误码对应解释网易服务器smtp机器要求身份验证帐号和发信帐号必须一致，如果用户在发送邮件时，身份验证帐号和发件人帐号是不同的，因此拒绝发送。

修改gitlab.rb，修改发信人和身份验证帐号一致，163发信OK。

```
$ sudo vi /etc/gitlab/gitlab.rb                            

# Change the external_url to the address your users will type in their browser
external_url 'http://xxhost.com'#Sending application email via SMTP
gitlab_rails['smtp_enable']=true
gitlab_rails['smtp_address']="smtp.163.com"
gitlab_rails['smtp_port']= 25 
gitlab_rails['smtp_user_name']="xxuser@163.com"
gitlab_rails['smtp_password']="xxpassword"
gitlab_rails['smtp_domain']="163.com"
gitlab_rails['smtp_authentication']= :login
gitlab_rails['smtp_enable_starttls_auto']=true##修改gitlab配置的发信人
gitlab_rails['gitlab_email_from']="xxuser@163.com"
user["git_user_email"]="xxuser@163.com"
```

