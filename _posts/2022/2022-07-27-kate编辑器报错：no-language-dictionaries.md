---
layout: post
title: kate编辑器报错：no-language-dictionaries，关联 KDE, arch linux, manjaro
categories: [ cm, linux ]
tags: []
---

* 参考
  * [Kate showing no language dictionary found](https://stackoverflow.com/a/70680166)
  * [sonnet.core: No language dictionaries for the language: "en"](https://www.reddit.com/r/kde/comments/5pgw88/comment/hzf86zu/?utm_source=share&utm_medium=web2x&context=3)
  * []()


* 现象

`kate some-file` 命令行里面报警告 `No language dictionaries`：

~~~
kf.sonnet.core: No language dictionaries for the language: "en_US"
kf.sonnet.core: No language dictionaries for the language: "en_US" trying to load en_US as default
~~~


* 解决

~~~sh
#安装下对应的dictionary
sudo pacman -S hunspell-en_us
~~~







