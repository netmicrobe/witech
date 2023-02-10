---
layout: post
title: linux-find-查找大文件，关联 
categories: [ ]
tags: []
---

* 参考
  * [How to use find command to search for files based on file size](https://linuxconfig.org/how-to-use-find-command-to-search-for-files-based-on-file-size)
  * []()
  * []()


发现大于100K的图片

~~~sh
find . -type f -size +100k | grep '.png\|.jpg'
# 或
find . -type f -size +100k -name "*.png" -o -name "*.jpg"

find . -type f -size +100k \( -name \*.png -or -name \*.jpg \)
~~~

发现小于10K的文件

~~~sh
find . -size -10k
~~~



