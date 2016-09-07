---
layout: post
title: mysql帐号管理：创建用户，修改用户
categories: [cm, mysql]
tags: [cm, mysql]
---

root帐户登入mysql，然后执行：

```sql
UPDATE user SET password=PASSWORD('123456') WHERE user='root';
FLUSH PRIVILEGES;
```

### 创建新的mysql帐号

```sql
GRANT ALL ON wiphone.* TO 'wi'@'%' IDENTIFIED BY 'Homei$3fe';
FLUSH PRIVILEGES;
```

### 修改密码：

```sql
SET PASSWORD FOR 'user-name-here'@'hostname-name-here' = PASSWORD('new-password-here');
```

或：

```sql
UPDATE mysql.user SET Password=PASSWORD('new-password-here') WHERE User='user-name-here' AND Host='host-name-here';
```



