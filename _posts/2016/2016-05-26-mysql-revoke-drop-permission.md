---
layout: post
title: 回收mysql 库和表的删除权限
categories: [cm, mysql]
tags: [cm, mysql]
---

```sql
revoke DROP on qalink.* from 'qaadmin'@'%';
FLUSH PRIVILEGES;
```

参考：
<https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql>

* ALL PRIVILEGES- as we saw previously, this would allow a MySQL user all access to a designated database (or if no database is selected, across the system)
* CREATE- allows them to create new tables or databases
* DROP- allows them to them to delete tables or databases
* DELETE- allows them to delete rows from tables
* INSERT- allows them to insert rows into tables
* SELECT- allows them to use the Select command to read through databases
* UPDATE- allow them to update table rows
* GRANT OPTION- allows them to grant or remove other users' privileges





