---
layout: post
title: imagemagick-使用，关联 convert, 批量
categories: [ ]
tags: []
---

* 参考
  * []()
  * []()
  * []()
  * []()





## 操作pdf

图片拼接成pdf，每个图片是一页

~~~sh
convert 1.jpg 2.jpg output.pdf
~~~

文本文件转换为pdf

~~~sh
convert TEXT:1.txt output.pdf

# 如果中文在pdf不显示，指派下中文字体
# convert -list font 命令可以列出所有可用字体
convert -font WenQuanYi-Zen-Hei TEXT:2.txt out.pdf
~~~

字符串转换为 pdf

~~~sh
convert -font WenQuanYi-Zen-Hei label:中文字体 zh.pdf

# 设置下字体大小
convert -font WenQuanYi-Zen-Hei -pointsize 12 label:中文字体 zh.pdf
~~~

多个pdf合并

~~~sh
convert 1.pdf 2.pdf output.pdf
~~~



## 批量操作

~~~sh
# 将文件名生成第一个pdf
# 图片文件生成第二个pdf

for f in * ; do [ -f "$f" ] && convert -font WenQuanYi-Zen-Hei -pointsize 12 label:"$f" "$f-1.pdf" && convert "$f" "$f-2.pdf"; done
~~~




























