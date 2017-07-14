---
layout: post
title: 向 vim 拷贝内容
categories: [cm, vim]
tags: 
  - vim
  - copy
  - indent
  - editor
---

### 问题：拷贝到vim，缩进累加

例如，第二行缩进是 原来第一行缩进 + 原来第二行缩进 

#### 解决方法 

~~~
:set nosmartindent
:set noautoindent
~~~


