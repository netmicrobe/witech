---
layout: post
title: Windows Server 2003 踢掉远程桌面用户
description: 
categories: [cm, network, windows]
tags: [cm, windows, network, remote-desktop]
---

方法一
----------------------

```
query user
```

找出对应的session ID

```
logoff <the-session-ID>
```

上述方法会注销该用户，session会被破坏，下次重新登录初始化。



方法二（推荐，不破坏session）
----------------------

在RDP admin工具中，直接断开session而不是主要，重新再连接后，原来打开的app还在。
推荐该方法。

Windows XP and Windows Server 2003 or earlier:

Click on Start -> Run and type %SystemRoot%\System32\tsadmin.exe

Windows Vista Windows Server 2008:

Click on Start and type tsadmin.msc into Start Search box.

