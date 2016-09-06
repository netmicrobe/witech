---
layout: post
title: apache，创建 alias
description: 
categories: [cm, apache]
tags: [cm, apache]
---

```
    alias /php_yii "/home/ethan/git_repo/misc/php_yii"
    <Directory "/home/ethan/git_repo/misc/php_yii">
        Options FollowSymlinks
        # Limit: Allow use of the directives controlling host access (Allow, Deny and Order).
        AllowOverride Limit
        Require all granted
    </Directory>
```

Windows：直接在httpd.conf 中添加

Ubuntu：在/etc/apache2/mods-available/alias.conf