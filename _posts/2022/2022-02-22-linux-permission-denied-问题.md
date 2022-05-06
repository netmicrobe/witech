---
layout: post
title: linux-permission-denied-问题，关联 mount, remount, cdrom
categories: [cm, linux]
tags: []
---

* 参考： 
    * [Kali Linux VM: Permission denied to run shell script, as root](https://superuser.com/a/768125)
    * []()
    * []()




`permission denied` 问题，可能是：

1. 文件没有执行权限
    解决： `chmod a+x your-file`
    
1. 挂载参数包含 `noexec`
    It might be that the `/media/cdrom0` filesystem has the noexec flag set.
    执行 `mount -v | grep cdrom0` 看下挂载参数有么 `noexec`
    
    解决： 重新挂载， `sudo mount -o remount,exec,ro /media/cdrom0`























