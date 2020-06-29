---
layout: post
title: 使用修改时间批量重命名文件
categories: [ cm, linux ]
tags: [mac]
---

* 参考
	* [How to get extension of a file in shell script](https://stackoverflow.com/a/2352397)
	* [Renaming a bunch of files with date modified timestamp at the end of the filename?](https://unix.stackexchange.com/a/43551)


~~~ shell
for f in * ; do [ -f "$f" ] && echo "VIDEO_"$(date -r "$f" +%Y%m%d_%H%M%S)"."$(echo "$f" | awk -F . '{if (NF>1) {print $NF}}'); done

for f in * ; do [ -f "$f" ] && mv -- "$f" "VIDEO_"$(date -r "$f" +%Y%m%d_%H%M%S)"."$(echo "$f" | awk -F . '{if (NF>1) {print $NF}}'); done

for f in * ; do [ -f "$f" ] && mv -- "$f" "IMG_"$(date -r "$f" +%Y%m%d_%H%M%S)"."$(echo "$f" | awk -F . '{if (NF>1) {print $NF}}'); done
~~~

* 文件名加前缀

~~~
for f in * ; do [ -f "$f" ] && echo "我是前缀_""$f"; done
for f in * ; do [ -f "$f" ] && mv -- "$f" "我是前缀_""$f"; done
~~~





