---
layout: post
title: burpsuite intercept 截包测试
description: 
categories: [cm, security, burpsuite]
tags: [cm, security, burpsuite]
---

<div markdown="0"><a class="btn btn-success" href="/wifiles/network/burpsuite/burpsuite_free_v1.5.jar">下载 burpsuite_free_v1.5</a></div>

javaw.exe -Dfile.encoding=UTF8 -jar  burpsuite_free_v1.5.jar


burpsuite 设置： 

```
proxy > Options 
Binding dialog 
  bind to port: 8087 
  bind to address: All interfaces 
```