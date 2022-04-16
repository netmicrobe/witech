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
  * []()
  * []()




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
1. 
1. 
1. 
1. 
















