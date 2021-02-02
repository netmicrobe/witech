---
layout: post
title: pacman安装低版本的package
categories: [cm, linux]
tags: [pacman, arch-linux, manjaro]
---

* 参考： 
  * []()
  * []()


1. 到 <https://archive.archlinux.org/packages> 找到对应的版本
1. 使用 `sudo pacman -U packages-path-or-url`
    * 直接使用URL安装，例如， `pacman -U https://archive.archlinux.org/packages/path/packagename.pkg.tar.xz`
    * 下载 xxx.pkg.tar.xz（或 zst）， 以及 xxx.pkg.tar.xz（或 zst）.sig 。 然后本地安装 `sudo pacman -U packages-path`





