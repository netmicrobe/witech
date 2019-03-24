---
layout: post
title: 安装gitlab ce docker image
categories: [cm, docker]
tags: [gitlab, virtualization, synology]
---

* 参考： 
  * []()
  * []()



## docker on Mac

### MacOS Docker 安装

* <https://hub.docker.com/editions/community/docker-ce-desktop-mac>

1. 使用 Homebrew 安装: `brew cask install docker`
    或者，从 [官网](https://download.docker.com/mac/stable/Docker.dmg) 下载dmg 文件，安装
    网络条件不好，建议手动下载dmg安装，要下载大概500M+的文件。
1. 在载入 Docker app 后，点击 Next，可能会询问你的 macOS 登陆密码，你输入即可。之后会弹出一个 Docker 运行的提示窗口，状态栏上也有有个小鲸鱼的图标
1. 在 docker app 中输入用户名和密码登陆（在 docker.com 注册）
    不要使用邮箱作为用户名登陆，否则`docker run`的时候会报错 “unauthorized: incorrect username or password”。
1. 验证安装结果。
    命令行运行： `docker --version` `docker run "hello-world"`



### 设置镜像服务器，加速image下载

* 网易的镜像地址： `http://hub-mirror.c.163.com`

1. 在任务栏点击 Docker for mac 应用图标 -\> Perferences... -\> Daemon -\> Registry mirrors。
2. 在列表中填写加速器地址即可。修改完成之后，点击 Apply & Restart 按钮，Docker 就会重启并应用配置的镜像地址了。
3. 之后我们可以通过 `docker info` 来查看是否配置成功。




### 下载&运行gitlab镜像

~~~
docker pull gitlab/gitlab-ce:latest
docker run --detach --hostname gitlab.your-host.local --publish 443:443 --publish 80:80 --publish 22:22 --name gitlab --restart always --volume /Users/your-host/docker/gitlab/config:/etc/gitlab --volume /Uers/your-host/docker/gitlab/logs:/var/log/gitlab --volume /Users/your-host/docker/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:lastest
~~~



## docker on Synology DSM

### 安装docker

套件中心选择docker安装


### 安装gitlab-ce

不要从“套件中心”安装gitlab，没用起来。。

1. 启动docker -\> 注册表中搜索 `gitlab-ce`
3. 下载 `gitlab/gitlab-ce
4. Docker -\> 镜像 -\> 选择并启动 `gitlab/gitlab-ce:latest`
4. Docker -\> 容器 -\> 选择刚启动的gitlab容器，点击“详情”
5. "端口设置" 中添加映射端口，例如 880:80 8433:433 822:22
6. "卷/volume" 中设置文件夹映射
    docker/gitlab/config  ---  /etc/gitlab
    docker/gitlab/data    ---  /var/opt/gitlab
    docker/gitlab/logs    ---  /var/log/gitlab
7. 重新启动，日志查看的位置：Docker -\> 容器 -\> gitlab-gitlab-ce1 的容器详情 -\> 终端机 或 日志
    “终端机”中“新增”，可以新打开命令行窗口，直接和容器系统交互。


### 配置gitlab smtp 邮箱

1. Docker -\> 容器 -\> 选择刚启动的gitlab容器，点击“详情” -\> 终端机
2. 新增bash终端，执行 `vim /etc/gitlab/gitlab.rb`
3. 编辑 gitlab.rb
    ~~~
    gitlab_rails['gitlab_email_enabled'] = true
    gitlab_rails['gitlab_email_from'] = 'your-mail-name@126.com'
    gitlab_rails['gitlab_email_display_name'] = 'gitlab-on-winas'
    gitlab_rails['smtp_enable'] = true
    gitlab_rails['smtp_address'] = "smtp.126.com"
    gitlab_rails['smtp_port'] = 465
    gitlab_rails['smtp_user_name'] = "your-mail-name"
    gitlab_rails['smtp_password'] = "授权码"
    gitlab_rails['smtp_domain'] = "126.com"
    gitlab_rails['smtp_authentication'] = "login"
    gitlab_rails['smtp_enable_starttls_auto'] = true
    gitlab_rails['smtp_tls'] = true
    ~~~





