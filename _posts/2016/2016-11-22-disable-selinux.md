---
layout: post
title: 关闭 SeLinux
categories: [cm, linux]
tags: [linux, selinux]
---

## 临时关闭

```shell
shell> setenforce 0 #关闭 Selinux  
```





## 永久关闭

修改 /etc/selinux/config 文件，修改 SELINUX=disabled，重启后查看：

```
shell> getenforce   
Disabled  
```