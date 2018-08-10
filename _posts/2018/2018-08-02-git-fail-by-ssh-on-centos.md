---
layout: post
title: CentOS 上，针对 ssh:// 的代码库地址， git 命令不能使用，配置 GIT_SSH / GIT_SSH_COMMAND / core.sshCommand 可解决
date: 2018-08-02 10:55:18 +0800
categories: [ cm, git ]
tags: [ssh, linux]
---

### 现象

执行 git 命令就报错：

~~~
sshd re-exec requires execution with an absolute path
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
~~~


### 分析

git 直接调用的 `ssh` 来使用系统的openssh客户端，
centos 上 openssh 新版本要求执行 `ssh` 或 `sshd` 时，必须给出绝对路径，
也就是 `/usr/bin/ssh` `/usr/sbin/sshd`


### 解决方法

#### 2.10 之前的版本，使用 GIT_SSH 环境变量

直接使用

~~~
GIT_SSH='/usr/bin/ssh' git push origin master
~~~

或者，配置到启动文件中，例如 `/etc/profile.d/your-custom.sh`

~~~ shell
export GIT_SSH=/usr/bin/ssh
~~~



#### git 2.10+ (Q3 2016) 之后版本，使用 GIT_SSH_COMMAND

* 参考: <https://stackoverflow.com/a/38474220/3316529>

~~~ shell
export GIT_SSH_COMMAND=/usr/bin/ssh
~~~

或者，使用git的新配置项目 

~~~ shell
git config core.sshCommand /usr/bin/ssh
~~~


















