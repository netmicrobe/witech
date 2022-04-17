---
layout: post
title: Ubuntu安装gitea，关联git,scm,gitlab
categories: [cm, git]
tags: []
---

* 参考
  * <https://github.com/go-gitea/gitea>
  * [docs.gitea.io / Database Preparation](https://docs.gitea.io/zh-cn/database-prep/)
  * [docs.gitea.io / 从二进制安装 ](https://docs.gitea.io/zh-cn/install-from-binary/)
  * [使用gitea通过码云完整克隆github源码库到本地备份](https://blog.csdn.net/u014038143/article/details/106789620)
  * [docs.gitea.io / config-cheat-sheet](https://docs.gitea.io/en-us/config-cheat-sheet)
  * <https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini>
  * [blog.68hub.com - Gitea 安装手册](https://blog.68hub.com/posts/install-gitea-note/)
  * [docs.gitea.io / logging-configuration](https://docs.gitea.io/en-us/logging-configuration)
  * []()
  * []()



1. 创建git用户
    ~~~sh
    sudo adduser --system --shell /bin/bash --gecos 'Git Version Control' --group --disabled-password --home /home/git git

    # 或，如果挂载群晖的nfs共享
    # 使用 1024 uid 对应群晖 admin 的uid
    sudo adduser --system -u 1024 --shell /bin/bash --gecos 'the same uid as ds918 admin' --group --disabled-password --home /home/synology-admin synology-admin
    ~~~

1. 准备数据库
    1. mysql
        ~~~sql
        CREATE USER 'gitea' IDENTIFIED BY 'gitea';
        CREATE DATABASE giteadb CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
        GRANT ALL PRIVILEGES ON giteadb.* TO 'gitea';
        FLUSH PRIVILEGES;
        ~~~
1. 从二进制安装，下载： <https://github.com/go-gitea/gitea/releases>
    ~~~sh
    wget -O gitea https://dl.gitea.io/gitea/1.16.5/gitea-1.16.5-linux-amd64
    chmod +x gitea

    # 命令行运行测试下，会在 3000 端口启动
    ./gitea web
    ~~~
1. 访问 http://server-ip:3000 后，第一个页面进行初始化，配置被存储在 `./custom/conf/app.ini`
    1. 填写数据库配置信息：帐号、密码、数据库名称
    1. Repository Root Path 、 LFS Root Path
    1. 服务端口、管理帐号等

1. 配置开机自启动
    ~~~sh
    cd ~
    wget https://raw.githubusercontent.com/go-gitea/gitea/main/contrib/systemd/gitea.service
    ~~~

1. 根据本地的参数，修改 gitea.service

    `vim gitea.service`

    ~~~sh
    [Unit]
    Description=Gitea (Git with a cup of tea)
    After=syslog.target
    After=network.target

    Wants=mysql.service
    After=mysql.service

    [Service]
    # Modify these two values and uncomment them if you have
    # repos with lots of files and get an HTTP error 500 because
    # of that
    ###
    #LimitMEMLOCK=infinity
    #LimitNOFILE=65535
    RestartSec=2s
    Type=simple
    User=git
    Group=git
    WorkingDirectory=/opt/gitea/gitea-1.16.5-linux-amd64
    # If using Unix socket: tells systemd to create the /run/gitea folder, which will contain the gitea.sock file
    # (manually creating /run/gitea doesn't work, because it would not persist across reboots)
    #RuntimeDirectory=gitea
    ExecStart=/opt/gitea/gitea-1.16.5-linux-amd64/gitea web --config /opt/gitea/gitea-1.16.5-linux-amd64/custom/conf/app.ini
    Restart=always
    Environment=USER=git HOME=/home/git GITEA_WORK_DIR=/opt/gitea/gitea-1.16.5-linux-amd64
    # If you install Git to directory prefix other than default PATH (which happens
    # for example if you install other versions of Git side-to-side with
    # distribution version), uncomment below line and add that prefix to PATH
    # Don't forget to place git-lfs binary on the PATH below if you want to enable
    # Git LFS support
    #Environment=PATH=/path/to/git/bin:/bin:/sbin:/usr/bin:/usr/sbin
    # If you want to bind Gitea to a port below 1024, uncomment
    # the two values below, or use socket activation to pass Gitea its ports as above
    ###
    #CapabilityBoundingSet=CAP_NET_BIND_SERVICE
    #AmbientCapabilities=CAP_NET_BIND_SERVICE
    ###

    [Install]
    WantedBy=multi-user.target
    ~~~

1. 安装service并设置自启动
    ~~~
    sudo mv gitea.service /etc/systemd/system/

    sudo systemctl enable gitea.service
    sudo systemctl start gitea.service
    ~~~


## 其他设置

### 日志保存文件

编辑 `custom/conf/app.ini`，默认 日志 是 console MODE

~~~
[log]
MODE      = file
LEVEL     = info
ROOT_PATH = /opt/gitea/data/log
LOG_ROTATE = true
DAILY_ROTATE = true
MAX_DAYS = 30
MAX_SIZE_SHIFT = 28
COMPRESS = true
COMPRESSION_LEVEL = -1
~~~


### 关闭注册

编辑 `custom/conf/app.ini`， `[service]` - `DISABLE_REGISTRATION` 设置为 true


## 问题

### 创建repo时候报错： exit status 128 - fatal: unsafe repository, directory is owned by someone else

~~~
2022/04/17 07:45:52 ...ers/web/repo/repo.go:190:handleCreateError() [E] CreatePost: initRepository: openRepository: exit status 128 - fatal: unsafe repository ('/mnt/nfs-folder/gitea/data/gitea-repositories/your-name/new-repo.git' is owned by someone else)

To add an exception for this directory, call:

	git config --global --add safe.directory /github/workspace
~~~

据说为了解决 CVE-2022-24765 这个安全问题，04-12 之后git进行了安全升级导致的。

目前无解，只能一个一个的用 safe.directory 添加，这样gitea无法在nfs挂载的目录上使用。除非挂载目录的uid和运行gitea的UID是一致的。

* 参考
  * [fatal: unsafe repository (REPO is owned by someone else) with ubuntu 20.04 container #760](https://github.com/actions/checkout/issues/760)
  * [I cannot add the parent directory to *safe.directory* in Git](https://stackoverflow.com/questions/71849415/i-cannot-add-the-parent-directory-to-safe-directory-in-git)
  * [About some reviewdogs failing with `exit status 128`](https://zenn.dev/1060ki/articles/322b72dbd6ce42)
  * [Git error - Fatal: Not a git repository](https://www.datree.io/resources/git-error-fatal-not-a-git-repository)
  * [fatal: unsafe repository on mounted volume](https://superuser.com/questions/1716223/fatal-unsafe-repository-on-mounted-volume)
  * []()
  * []()
  * []()






















