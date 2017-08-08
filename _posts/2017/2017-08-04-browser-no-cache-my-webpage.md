---
layout: post
title: 使得浏览器不要缓存页面和 CSS/Javascript 资源
categories: [dev, web]
tags: [jekyll, no-cache, website]
---

### 在 html 页面 head 中添加 meta

~~~
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
~~~

### 在 csc/js 之后添加 “?timestamp”

例如： http://your-host/css/jquery.3.2.1.css?20170804


#### jekyll 中如何添加时间戳到 css/js 文件路径

~~~ html
<link rel="stylesheet" href="{{ site.baseurl }}/css/bootstrap.min.css?{{ site.time | date:'%Y%m%d%U%H%N%S' }}">
~~~
