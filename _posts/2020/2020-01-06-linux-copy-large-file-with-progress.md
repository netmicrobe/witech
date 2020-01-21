---
layout: post
title: linux中拷贝大文件，同时显示进度
categories: [cm, linux]
tags: [rsync, dd]
---

* 参考： 
  * [Rsync Show Progress Bar While Copying Files](https://www.cyberciti.biz/faq/show-progress-during-file-transfer/)
  * []()


### rsync

~~~
# 使用 -P 参数显示进度
rsync -av -P /media/yourname/disk-a/somefile.tgz /media/yourname/disk-b

# 使用 --progress 参数显示进度
rsync -av ---progress /media/yourname/disk-a/somefile.tgz /media/yourname/disk-b

# 从远程服务器拷贝文件
rsync -av --progress root@nas01:/tmp/*Office* .

~~~






