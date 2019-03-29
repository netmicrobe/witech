---
layout: post
title: linux script 技巧 / tips
categories: [ cm, linux ]
tags: [mac, script, shell]
---

* 参考
	* []()
	* []()






### 文件名操作

#### 获取扩展名

<https://stackoverflow.com/a/2352397>

~~~ shell
file_ext=$(echo $filename |awk -F . '{if (NF>1) {print $NF}}')
~~~



#### Loop Through Files In A Directory

<https://www.cyberciti.biz/faq/unix-loop-through-files-in-a-directory/>

~~~ shell
for file in $*
do
 # do something on $file
 [ -f "$file" ] && cat "$file"
done
~~~


#### 批量重命名


~~~ shell
# 文件夹批量重命名
for f in */; do mv ${f%%/} ${f%%/}.git; done
~~~


#### Bash remove leading / trailing

* 参考
  * [Bash Shell: Remove (Trim) White Spaces From String or Variable](https://www.cyberciti.biz/faq/bash-remove-whitespace-from-string/)
  * <https://unix.stackexchange.com/a/476504>
  * [Advanced Bash-Scripting Guide - 10.1. Manipulating Strings](http://tldp.org/LDP/abs/html/string-manipulation.html)

~~~ shell
# The syntax is to remove leading whitespaces:
${var##*( )}
~~~

~~~ shell
# Just remove leading whiltespace
#turn it on
shopt -s extglob
 
output="    This is a test"
output="${output##*( )}"
echo "=${output}="
 
# turn it off
shopt -u extglob
~~~

~~~ shell
# To trim leading and trailing whitespace using bash
#turn it on
shopt -s extglob
output="    This is a test    "
 
### Trim leading whitespaces ###
output="${output##*( )}"
 
### trim trailing whitespaces  ##
output="${output%%*( )}
echo "=${output}="
 
# turn it off
shopt -u extglob
~~~






































































