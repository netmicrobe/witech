---
layout: post
title: 在Linux上使用xargs连接命令
categories: [cm, linux]
tags: [xargs]
---

* 参考
    * [xargs原理剖析及用法详解](https://www.cnblogs.com/f-ck-need-u/p/5925923.html)
    * [xargs命令_Linux xargs命令：一个给其他命令传递参数的过滤器](http://c.biancheng.net/linux/xargs.html)
    * []()



## `-I` 参数，指定占位符字符串

* `-I replace-str`
  Replace  occurrences of replace-str in the initial-arguments with names read from standard input.
  Also, unquoted blanks do not terminate input items; instead the separator is the newline character.

~~~

git config --global alias.pushall '!git remote | xargs -L1 -I R git push R '

ls -1 ./*jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf

find books/ | grep -i python | xargs -I '{}' mv {} materials/material/language.python/

~~~





