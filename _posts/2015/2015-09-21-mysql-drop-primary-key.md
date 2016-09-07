---
layout: post
title: MySql：删除主键约束
categories: [cm, mysql]
tags: [cm, mysql]
---


如果主键是自增长，则需要首先取消自增长 

```sql
ALTER TABLE tb_package_removed MODIFY id INT(10) UNSIGNED; 
```

然后，删除主键 

```sql
ALTER TABLE tb_package_removed DROP PRIMARY KEY;
```