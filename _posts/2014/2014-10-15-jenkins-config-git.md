---
layout: post
title: jenkins中配置git
description: 
categories: [cm, jenkins]
tags: [cm, jenkins, git]
---

## 安装git plugin

Manage Jenkins > Manage Plugins > 找到git plugin 勾选安装。

直接在线安装可能报告：连不上 www.google.com，可以下载插件的hpi文件，上传安装。

![](/images/cm/jenkins/git_plugin_info.png)

进入Jenkins界面，Manage Jenkins->Manage Plugins->Advanced标签，Upload plugin界面如下图所示：

![](/images/cm/jenkins/install_git_plugin_offline.png)

点击Browse按钮，选择已经下载好的plugin的hpi文件，然后点击Upload按钮安装，

参考：
<https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin>

1）在linux中安装git

安装完成后，要能在命令行直接执行git --version

2）在jenkins中配置git

Manage Jenkins > Git > Path to Git executable = 'git'

如下图

![](/images/cm/jenkins/config_git_in_jenkins.png)


## 问题：在job中配置git地址时出错。

我是用jenkins用户启动tomcat的，但git被执行时，将home目录认成/root

```
Failed to connect to repository : Command "git ls-remote -h http://192.168.251.72:8000/gerrit/BuiltinClient7th HEAD" returned status code 128:
stdout: 
stderr: fatal: unable to access '/root/.config/git/config': Permission denied
```

![](/images/cm/jenkins/jenkins_fail_on_git_path.png)


### 解决方法一、用sh脚本封装下git

git-jenkins 文件内容：

```
#!/bin/sh
HOME="/home/jenkins" git $@
```

在jenkins的git设置的时候，命令由git改为git-jenkins


### 解决方法二、在tomcat service启动脚本启动jsvc之前，设置HOME变量

export HOME="/home/jenkins"




