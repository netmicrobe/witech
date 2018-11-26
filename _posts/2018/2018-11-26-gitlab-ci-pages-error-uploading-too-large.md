---
layout: post
title: gitlab ci 编译 jekyll - pages 报错：Uploading artifacts too large
categories: [ cm, git ]
tags: [gitlab, jekyll]
---

* 参考
  * [Gitlab CI upload artifact fails: too large](https://pauledenburg.com/gitlab-ci-upload-artifact-fails-large/)


### 现象，job编译报错

~~~
ERROR: Uploading artifacts to coordinator... too large archive  id=12263 responseStatus=413 Request Entity Too Large status=413 Request Entity Too Large token=x3rHp58i
FATAL: Too large  
~~~

### 解决，修改gitlab对文件大小的限制

gitlab 对 artifactors 和 pages 的大小都有限制

进入 Admim -- Settings <gitlab-host/admin/application_settings》

* Pages -- Maximum size of pages(MB) 改成5000（5G，够大吧）
* Continuous Integration -- Maximum artifacts size (MB)改成5000（5G，够大吧）





