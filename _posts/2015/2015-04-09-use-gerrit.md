---
layout: post
title: Using Gerrit
categories: [cm, git]
tags: [cm, git, gerrit]
---


## 先设置本地git的用户信息

```shell
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```



## Who is Admin

The first user to login automatically gets the administrator status.
 
Create a the new Git repository in Gerrit via the following command.

```
# assumes that Gerrit runs on port 29418
# on localhost

ssh -p 29418 <userid>@localhost gerrit create-project demo/gerrittest
```




## For Developer

You can also do this setup directly via the Git command line.

```
git config remote.origin.push refs/heads/*:refs/for/*
```
 
### 设置full-name、邮箱

进入帐号设置，验证邮箱并设置Full-Name。
邮箱验证会发验证邮件到邮箱。

![](/images/cm/git/gerrit/gerrit_set_fullname_mail_on_page.png)



### 添加公匙

在~/.ssh下执行 ssh-keygen 来生成密钥对（公钥/私钥）。

```
ssh-keygen -C "test gerrit for developerA" -f id_developera
```

执行后，会在目录下面生成文件：id_developera（私钥），id_developera.pub（公钥）。
 
将公钥的内容拷贝到gerrit网站上帐号设置》”SSH Public Keys“。

![](/images/cm/git/gerrit/gerrit_set_ssh_key_on_page.png)



### Cygwin多个SSH帐号设置

同样，在~/.ssh 下生成密钥对，在gerrit网站上设置帐号的公钥。

```
ssh-keygen -C "test gerrit for developerB" -f id_developerb
```
 
在Cygwin中设置新的SSH 连接。在 ~/.ssh/config 中设置：

```
Host gerrit-developerA
Hostname localhost
Port 29418
User developerA
IdentityFile /home/ethan/.ssh/id_developera
 
Host gerrit-developerB
Hostname localhost
Port 29418
User developerB
IdentityFile /home/ethan/.ssh/id_developerb
```

在ssh-agent中注册：

```
eval `ssh-agent -s`
ssh-add /home/ethan/.ssh/id_developerb
ssh-add -l       # 列出添加的内容
```

* 参考：<https://gist.github.com/suziewong/4378434>


### 安装change-id hook

下载gerrit-site上的committ-msg hook，例如： http://localhost:7666/gerrit/tools/hooks/commit-msg
 
拷贝到项目的.git/hooks 目录下。
 
有了这个hook，每次commit都会生成一个Change ID到comment里边。

例如：

```
commit bfd38249b52bad688e7f71dd4b26ee189e02ef10
Author: developerA <developerA@163.com>
Date:   Sun Feb 9 15:24:49 2014 +0800
 
  add second file
 
  Change-Id: I7bdc292c32696a733e445a2afa4cb03ed2d07acc
```

### 修改并提交Commit（to review）

例子：

git push origin master:refs/for/master

将会生成一个 review在gerrit网站上。


### 处理冲突

 
提交review的commit已经落后于gerrit上目标分支，不是fast-forward提交：
可能会产生自动merge；
也可能会产生conflict；
 
所以如果长时间没有push，那么先下载目标分支rebase一下：
git pull --rebase    # 此处命令省略 remote分支参数，读者根据需要自己添加。
 
如果产生Conflict，那就需要pull --rebase一下，然后手动修改解决conflict，git add修改的文件。
重新提交commit去review。如果想修改下commit message，说明下新的修改，可以使用 git commit --amend，但是不要修改message中自动生成的change-id。






## For Reviewer

 
### Reviewing a change request

导航菜单 All > Open 列出所有待reviewer的CR

CR详情：

![](/images/cm/git/gerrit/gerrit_change_request_webpage.png)

点击Side-by-Side，查看修改。Commit Message也能进行review。
点击右侧行号，可以添加comment。

![](/images/cm/git/gerrit/gerrit_add_comments_to_cr.png)



### Publishing your review result

点Review就可以将评审结果发布出来。可以打分 +2 到 -2。

![](/images/cm/git/gerrit/gerrit_cr_preview.png)

![](/images/cm/git/gerrit/gerrit_cr_score.png)

点击 Publish and Submit，发布评审结果的同时，将Change提交到目标branch上。





## For All Users

下载CR的commit

gerrit网站CR详情页面提供下载各种命令：

![](/images/cm/git/gerrit/gerrit_download_cr.png)


## Gerrit网站按“？”显示快捷键提醒

## 参考

* <http://www.vogella.com/tutorials/Gerrit/article.html>
* <http://blog.csdn.net/yz2574648679/article/details/10362747>
 
 
### 更多资料

 
* Gerrit Code Review - A Quick Introduction
  * <http://gerrit-documentation.googlecode.com/svn/Documentation/2.6/intro-quick.html>
  * <http://gerrit-documentation.googlecode.com/svn/Documentation/2.7/intro-quick.html>
 
* Gerrit at Eclipse
  * <http://wiki.eclipse.org/Gerrit>
 







