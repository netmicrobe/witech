---
layout: post
title: mysql 非root用户远程执行Load Data
categories: [cm, mysql]
tags: [cm, mysql]
---


## 参考

* <http://www.9enjoy.com/mysql-priv-file/>
* <http://www.2cto.com/database/201304/201050.html>

## 如何设置

mysql默认设置，非root用户是不能远程执行Load Data的。

使用root用户对这个用户赋权：

GRANT FILE ON \*.\* TO hx@localhost;

注意：

1. GRANT ALL 不包含 GRANT FILE
2. FILE 是全局设置，只能针对所有库表，不能针对单个表。