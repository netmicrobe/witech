---
layout: post
title: 配置 CentOS 6 启动 runlevel
categories: [cm, linux]
tags: [centos, runlevel]
---

## 配置启动runlevel

编辑 /etc/inittab

### 字符界面，多用户

```
id:3:initdefault:
```

### 图形界面，多用户

```
id:5:initdefault:
```

## runlevel运行时切换

### 从字符界面切换到图形界面

```
init 5
```



## 附录

### runlevel 说明

 The following runlevels are defined by default under Red Hat Enterprise Linux:

        0 — Halt

        1 — Single-user text mode

        2 — Not used (user-definable)

        3 — Full multi-user text mode

        4 — Not used (user-definable)

        5 — Full multi-user graphical mode (with an X-based login screen)

        6 — Reboot

