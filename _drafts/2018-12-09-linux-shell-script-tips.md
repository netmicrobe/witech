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





