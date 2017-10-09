---
layout: post
title: Mysql 字符集（character set）相关
categories: [cm, mysql]
tags: [cm, mysql, charset, character-set, collate, collation]
---

## 字符集
 
### 技巧
 
#### 检查支持的字符集

SHOW CHARACTER SET;
 
#### 检查当前会话的字符集设置

SHOW VARIABLES LIKE 'character_set_%'
 
#### 设置当前会话的字符集

```sql
SET NAMES 'charset_name'
SET CHARACTER SET charset_name
```

SET NAMES 'x'语句与这三个语句等价：

```sql
mysql> SET character_set_client = x;
mysql> SET character_set_results = x;
mysql> SET character_set_connection = x;
```

