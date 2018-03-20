---
layout: post
title: RVM（Ruby Version Manager）安装和使用
categories: [cm, ruby]
tags: [rvm, ruby]
---

* 参考： <https://ruby-china.org/wiki/rvm-guide>

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

检查用户所在的组：`groups root`





### 修改 RVM 的 Ruby 安装源到国内的 镜像服务器，这样能提高安装速度

* 全局的配置文件在： `/usr/local/rvm/config/db` 或 `~/.rvm/config/db`
* ~/.rvm/user/ 中是用户的配置文件

Ruby China源
~~~
echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db
~~~


淘宝源
```
$ sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db
```

### 国内的下载镜像

  * https://cache.ruby-china.org/pub/ruby
  * <https://ruby.taobao.org/mirrors/ruby/>
  * <http://cache.ruby-lang.org/pub/ruby/>   [Ruby China 镜像说明](https://ruby-china.org/wiki/ruby-mirror)



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


## gemset 的使用

RVM 不仅可以提供一个多 Ruby 版本共存的环境，还可以根据项目管理不同的 gemset.

gemset 可以理解为是一个独立的虚拟 Gem 环境，每一个 gemset 都是相互独立的。

比如你有两个项目，一个是 Rails 2.3 一个是 rails3. gemset 可以帮你便捷的建立两套 Gem 开发环境，并且方便的切换。

gemset 是附加在 Ruby 语言版本下面的，例如你用了 1.9.2, 建立了一个叫 rails3 的 gemset,当切换到 1.8.7 的时候，rails3 这个 gemset 并不存在。

### 建立 gemset

~~~
rvm use 1.8.7
rvm gemset create rails23
~~~

然后可以设定已建立的 gemset 做为当前环境
use 可以用来切换语言或者 gemset

前提是他们已经被安装(或者建立)。并可以在 list 命令中看到。

~~~
rvm use 1.8.7
rvm use 1.8.7@rails23
~~~

然后所有安装的 Gem 都是安装在这个 gemset 之下。


### 列出当前 Ruby 的 gemset

~~~
rvm gemset list
~~~

### 清空 gemset 中的 Gem

如果你想清空一个 gemset 的所有 Gem, 想重新安装所有 Gem，可以这样

~~~
rvm gemset empty 1.8.7@rails23
~~~

### 删除一个 gemset

~~~
rvm gemset delete rails2-3
~~~

### 项目自动加载 gemset

RVM 还可以自动加载 gemset。 例如我们有一个 Rails 3.1.3 项目，需要 1.9.3 版本 Ruby，整个流程可以这样。

~~~
rvm install 1.9.3
rvm use 1.9.3
rvm gemset create rails313
rvm use 1.9.3@rails313
~~~

下面进入到项目目录，建立一个 .rvmrc 文件。

在这个文件里可以很简单的加一个命令：

`rvm use 1.9.3@rails313`

然后无论你当前 Ruby 设置是什么，cd 到这个项目的时候，RVM 会帮你加载 Ruby 1.9.3 和 rails313 gemset.


## 使用 RVM 快速部署 Nginx + Passenger

首先安装 Passenger

~~~
gem install passenger
~~~

然后使用 passenger-install-nginx-module 来安装 Nginx 和部署。

因为这一步需要 root 权限（因为要编译 Nginx）可以用 rvmsudo 这个东西（这个东西真是个好东西）。

~~~
rvmsudo passenger-install-nginx-module
~~~

然后会让你选择是下载 Nginx 源码自动编译安装，还是自己选择 Nginx 源码位置。

选择 Nginx 手动安装的可以添加别的编译参数，方便自定义编译 Nginx。

然后一路下载安装。默认的安装位置为 /opt/nginx.

然后看看 nginx.conf，都给你配置好了，只需要加上 root 位置（yourapp/public）就可以了。
