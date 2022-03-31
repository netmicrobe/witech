---
layout: post
title: 下载安装google-chrome，关键词：standalone, offline
categories: [cm]
tags: []
---

* 参考
  * [How to download Google Chrome's offline installer](https://www.bleepingcomputer.com/news/google/how-to-download-google-chromes-offline-installer/)
  * []()

## Linux

### debian 系发行版安装

~~~sh
# 下载
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# 查看版本号等信息
dpkg --info google-chrome-stable_current_amd64.deb

# 安装
sudo dpkg -i google-chrome-stable_current_amd64.deb
~~~

## Windows

Windows 系统下访问如下地址，可下载离线安装包

<https://www.google.com/chrome/?standalone=1>



