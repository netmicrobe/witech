---
layout: post
title: Bing壁纸RESTful-API，关联 
categories: [ cm ]
tags: []
---

* 参考
  * <https://www.ahhhhfs.com/26185/>
  * []()
  * []()


一个Bing壁纸RESTful API，可用再博客网站等等场合上，使用简单，支持各种参数的调用，指定分辨率、指定日期、指定宽度高度、指定日期、指定质量等等。

Bing壁纸RESTful API 地址 api：https ://bingw.jasonzeng.dev 

Bing壁纸RESTful API 参数使用 解析度/分辨率 壁纸图像的分辨率。默认为1920x1080。 
选项值： UHD 1920x1200 1920x1080 1366x768 1280x768 1024x768 800x600 800x480 768x1280 720x1280 640x480 480x800 400x240 320x240 240x320 

格式 
响应格式，可以是json. 如果不设置，会直接重定向到壁纸图片。resolution=UHD 指数 壁纸的索引，从0开始。默认0表示获取今天的图片，1表示获取昨天的图片，以此类推。或者您可以将其指定为random选择随机索引。index=randon或者index=1 

日期

按日期获取壁纸，从20200314今天到今天。date=20220807 

w 壁纸的宽度。w=1080 
H 墙纸的高度。H=1080 

qlt 

壁纸的质量，从0到100。qlt=88 Bing壁纸RESTful 

API使用示范 
参数使用：http://bingw.jasonzeng.dev?resolution=UHD&index=random&w=1080&qlt=86 
解释：分辨率为UHD，随机索引照片，宽度为108o像素的bing壁纸























