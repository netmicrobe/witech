---
layout: post
title: manjaro-vim无法和系统剪切板交互
categories: [ cm, linux ]
tags: [gvim, clipboard]
---

* 参考：
  * [bbs.archlinux.org - gvim is vim (you can still call it with vim) but with X11 support compiled in, vim isn't compiled with X11 support and hence has no ability to access the clipboard.](https://bbs.archlinux.org/viewtopic.php?pid=1821221#p1821221)
  * []()

* 问题现象

    manjaro 中 vim 无法和剪贴板交互，因为 vim 包没有包含GUI的支持。

* 解决

    卸载 vim ，安装 gvim 包，同样可以在命令行中使用vim。
    
    ~~~
    sudo pacman -Rs vim
    sudo pacman -S gvim
    ~~~


