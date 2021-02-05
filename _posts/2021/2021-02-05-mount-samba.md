---
layout: post
title: 挂载samba共享目录
categories: [cm, linux]
tags: [samba,cifs, manjaro]
---

* 参考： 
    * [wiki.archlinux.org - samba](https://wiki.archlinux.org/index.php/samba#Manual_mounting)
    * []()
    * []()
    * []()




~~~
# 手动执行会弹出密码输入提示
sudo mount -t cifs //SERVER/sharename /mnt/mountpoint -o username=username,iocharset=utf8,uid=username,gid=group
~~~





