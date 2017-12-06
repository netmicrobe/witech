---
layout: post
title: 处理文件名包含特殊字符的文件
categories: [cm, linux]
tags: [ linux, illegible-character, find, inode, ls ]
---

文件名包含特殊字符，在shell里边特殊字符会显示为`？`，无从输入文件名，只会得到“No such file or directory”的错误。如何把文件名改回来呢？

两个办法：

例如：有错误文件名afile?：

~~~
$ ls
-rw-r--r-- 1 ethan ethan 0 Jan 5 00:55 afile?
~~~

### 方法一：使用`*`来通配

~~~
$ mv afile* afile_new
~~~

### 方法二：使用inode指定文件，而不是依靠文件名

“ls -li”找到文件的inode：

~~~
$ ls -li
8916313 -rw-r--r-- 1 ethan ethan 0 Jan 5 00:55 afile?

$ find . -inum 8916313 -exec mv {} afile_new \;
~~~



