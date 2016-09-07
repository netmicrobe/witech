---
layout: post
title: Mysql Timestamp
categories: [cm, mysql]
tags: [cm, mysql]
---

参考：<http://dev.mysql.com/doc/refman/5.7/en/timestamp-initialization.html>

Mysql 支持自动更新时间戳字段的功能，但是这样的字段，每个表只能有一个。我去！

### 同时使用 DEFAULT CURRENT_TIMESTAMP 和 ON UPDATE CURRENT_TIMESTAMP

例如：TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  

在创建新记录和修改现有记录的时候都对这个数据列刷新

### 只使用 DEFAULT CURRENT_TIMESTAMP  

在创建新记录的时候把这个字段设置为当前时间，但以后修改时，不再刷新它

### 只使用 ON UPDATE CURRENT_TIMESTAMP

在创建新记录的时候把这个字段设置为0，以后修改时刷新它

### 使用 DEFAULT ‘yyyy-mm-dd hh:mm:ss’ ON UPDATE CURRENT_TIMESTAMP  

在创建新记录的时候把这个字段设置为给定值，以后修改时刷新它

MySQL目前不支持列的Default 为函数的形式,如达到你某列的默认值为当前更新日期与时间的功能,你可以使用TIMESTAMP列类型

By default, the first TIMESTAMP column has both DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP if neither is specified explicitly.





