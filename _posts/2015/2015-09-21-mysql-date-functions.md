---
layout: post
title: mysql 时间日期函数
categories: [cm, mysql]
tags: [cm, mysql]
---


### 获取 datetime 列的年月日

```sql
SELECT DISTINCE YEAR(t), MONTH(t), DAYOFMONTH(t) FROM <table-name>;
```
