---
layout: post
title: 如何设置Testlink 附件最大文件大小
categories: [cm, testlink]
tags: [cm, testlink]
---

* 参考：
<http://www.wpbeginner.com/wp-tutorials/how-to-increase-the-maximum-file-upload-size-in-wordpress/>

### 修改Testlink设置

文件 config.inc.php

```php
$tlCfg->repository_max_filesize = 64; //MB
```

### 修改php.ini

文件最大限制要生效，还要调整php设置，修改 /etc/php.ini

```php
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 300
max_input_time = 300
```


