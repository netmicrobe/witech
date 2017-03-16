---
layout: post
title: 从 ssh 通过 hostname 在局域网中访问服务器
categories: [cm, linux]
tags: [linux, hostname]
---

## 查看 hostname

```
cat /proc/sys/kernel/hostname
```

或者

```
cat /etc/sysconfig/network
```

## 利用 hostname 从 ssh 登录

hostname 后面加 “.local” 即可

```
ssh username@hostname.local
```
