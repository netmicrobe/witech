---
layout: post
title: Windows-Linux-子系统WSL中无法修改C盘文件
categories: [ cm, windows ]
tags: [wsl]
---

* 参考
  * [Unable to change file permissions on Ubuntu Bash for Windows 10](https://stackoverflow.com/a/50856772)
  * []()
  * []()


chmod 修改文件时候报错：

~~~
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0777 for 'privkey.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "privkey.pem": bad permissions
Permission denied (publickey).
~~~

* **解决**

Edit or create (using sudo) `/etc/wsl.conf` and add the following:

~~~
[automount]
options = "metadata"
~~~

改好重启Windows