---
layout: post
title: gerrit 支持中文
categories: [cm, git]
tags: [cm, git, gerrit]
---


So what I did to fix this was simple:

- Dump the database to an SQL file, using

  栗子1： mysqldump -u gerrit -p > gerrit.sql
  栗子2：mysqldump --opt -p -u root --port=3306 reviewdb > reviewdb.sql

- First replace: latin1_bin for utf8_unicode_ci ; this is the COLLATE  latin1 value
- Second replace: latin1 for utf8 . Replacing this after the COLLATE operation near guarantees you won't have "utf8_bin", which we don't want.
- Third replace: ENGINE=MyISAM for ENGINE=INNODB. This way, tables are recreated using INNODB, which actually also seems to be faster, though this might just be a placebo effect.
- Finally, reimport all the things to a NEW DATABASE (I cannot stress this enough) in order to test the charset modification before going into production, using this:
  - mysql -p -u gerrit gerrit2 < gerrit2.sql 
  where gerrit2 is the name of the new database.

### gerrit mysql setting

```
[database]
    type = mysql
    url = jdbc:mysql://localhost:3306/reviewdb?user=gerrit&password=gerrit&useUnicode=true&characterEncoding=UTF-8
```

### mysql设置：在my.ini

```
[mysqld]
character-set-server = utf8
character-set-filesystem = utf8
```


## 其他参考


### 团队约定

所有文本文件都必须存储成utf8编码

git 设置
（如下设置未验证，参考网络）

```
git config --global core.quotepath false
git config --global i18n.logoutputencoding utf8
git config --global i18n.commitencoding utf8
```

