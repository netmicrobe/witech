---
layout: post
title: 查看linux shell的变量
categories: [ cm, linux ]
tags: [ shell, env, set ]
---


参考：<https://askubuntu.com/a/275972>



to print all the environment variables:

~~~
printenv
~~~


To show a list including the "shell variables"

~~~
set -o posix ; set
~~~




参考：<https://askubuntu.com/a/277969>


see all variables with the declare builtin.

~~~
declare -p
~~~


only interested in environment variables, use

~~~
declare -xp
~~~










