---
layout: post
title: windows上查看哪些端口有程序Listening
description: 
categories: [cm, network, windows]
tags: [cm, windows, network, netstat]
---

```
netstat -aon | find /i "listening"
```

加参数-b可以看到哪个app在该port上

```
netstat -abno
netstat -a -b
```

直接执行netstat -a -b   在这个命令里边不要使用grep -i listening，实际app信息显示在下面一行;
例如：

```
  TCP    0.0.0.0:443            ethan-PC:0             LISTENING
 [httpd.exe]
```


