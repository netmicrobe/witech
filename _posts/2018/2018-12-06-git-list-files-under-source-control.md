---
layout: post
title: 列出当前处于git版本库跟踪下的文件，ls-tree
categories: [ cm, git ]
tags: [git]
---

* 参考
  * <https://superuser.com/a/429694>
  * <https://stackoverflow.com/a/15606995/3316529>



### 当前目录下的版本库文件

~~~
git ls-tree --name-only HEAD
~~~

### 当前目录（递归子目录）下的版本库文件

~~~
git ls-tree -r master --name-only
~~~

### 当前目录下的版本库文件，包括曾经存在此目录的文件

~~~
git log --pretty=format: --name-status . | cut -f2- | sort -u
~~~

### 版本库所有文件，包括曾经存在的文件

~~~
git log --pretty=format: --name-status | cut -f2- | sort -u
~~~

~~~
git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'
~~~



