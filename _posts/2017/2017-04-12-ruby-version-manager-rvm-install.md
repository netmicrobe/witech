---
layout: post
title: RVM（Ruby Version Manager）安装和使用
categories: [cm, ruby]
tags: [rvm, ruby]
---

## 安装RVM

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | sudo bash -s stable
```

https 如果连不上，tmd GFW，就改成http就可以了。

sudo 方式会安装在 /usr/local/rvm ，供所有用户使用，否则只是安装在当前用户的HOME下。

执行完之后，会提醒：

```
Installation of RVM in /usr/local/rvm/ is almost complete:


  * First you need to add all users that will be using rvm to 'rvm' group,

    and logout - login again, anyone using rvm will be operating with `umask u=rwx,g=rwx,o=rx`.


  * To start using RVM you need to run `source /etc/profile.d/rvm.sh`

    in all your open shell windows, in rare cases you need to reopen all shell windows.

```



将用户加入到刚安装脚本创建的rvm组

```
usermod -a -G rvm root redmine
```

检查用户所在的组：groups root







修改 RVM 的 Ruby 安装源到国内的 淘宝镜像服务器，这样能提高安装速度

```
$ sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db
```



## 使用 RVM


### 当前安装的ruby

```
$ rvm list
```

### 所有可以安装的rubies

```
$ rvm list known
```


### Install a version of Ruby (eg 2.1.1):

```
rvm install 2.1
```


### Use the newly installed Ruby:

```
rvm use 2.1
```


### 当前正在使用的ruby版本:

ruby -v

ruby 2.1.1p76 (2014-02-24 revision 45161) [x86_64-linux]



### 为每个shell设定默认的ruby版本，注意：这将覆盖系统的ruby

```
rvm use 2.1 --default
```


### ruby版本的信息（已安装，会包含安装文件位置，一般是都在 /usr/local/rvm 下面）

```
rvm info 1.9.3
```

## 卸载 RVM

```
rvm implode
or
rm -rf ~/.rvm
```

Don’t forget to remove the script calls in your .bashrc and/or .bash_profile (or whatever shell you’re using).






