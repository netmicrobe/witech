---
layout: post
title: linux bash 常用特殊变量 / arguments , variables / $# $@ $? ...
categories: [cm, linux]
tags: [script, shell, bash]
---

* 参考
  * [Bash scripting cheatsheet](https://devhints.io/bash)
  * [Special parameters and shell variables](https://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables)
  * []()
  * []()




## 参数变量

~~~sh
$#    Number of arguments
$*    All positional arguments (as a single word)
$@    All positional arguments (as separate strings)
$1    First argument
$_    Last argument of the previous command
~~~

Note: $@ and $* must be quoted in order to perform as described. Otherwise, they do exactly the same thing (arguments as separate strings).



## 特殊变量

~~~sh
Special variables
$?	Exit status of last task
$!	PID of last background task
$$	PID of shell
$0	Filename of the shell script
$_	Last argument of the previous command
~~~











