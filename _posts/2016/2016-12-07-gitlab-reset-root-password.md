---
layout: post
title: 重设 Gitlab root 密码
categories: [cm, git, gitlab]
tags: [cm, git, gitlab]
---


* 参考
  * [GitLab Documentation - How to reset your root password](https://docs.gitlab.com/ce/security/reset_root_password.html)

```
gitlab-rails console production
或者
sudo -u git -H bundle exec rails console production
```

进行修改

```
user = User.where(id: 1).first
user.password = 'secret_pass'
user.password_confirmation = 'secret_pass'
user.save!
```
