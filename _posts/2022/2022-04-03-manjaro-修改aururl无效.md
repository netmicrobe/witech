---
layout: post
title: manjaro-修改aururl无效，关联arch
categories: [cm, linux]
tags: []
---

* 参考
  * []()



* 现象

~~~
error fetching rar: fatal: 无法访问 'https://aur.tuna.tsinghua.edu.cn/rar.git/'：Could not resolve host: aur.tuna.tsinghua.edu.cn
~~~

清华源无法连接，该官方源，

~~~
yay --aururl "https://aur.archlinux.org" --save
~~~

但是 `yay -S google-chrome` 还是往清华源上去连接


* 解决办法

在 `~/.cache/yay` 中找到对应软件，然后删除 ，比如， `rm -fr google-chrome/`
再重新安装。









