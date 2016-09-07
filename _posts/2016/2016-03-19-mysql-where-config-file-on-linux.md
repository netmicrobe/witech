---
layout: post
title: linux 下配置目录、data目录
categories: [cm, mysql]
tags: [cm, mysql]
---

配置目录
/etc/my.cnf


data目录

进入mysql执行，show variables like '%dir%'

其中 datadir 的值就是data目录的地方，一般是 /var/lib/mysql




