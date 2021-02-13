---
layout: post
title: ubuntu18开启ssh服务
categories: [cm, linux]
tags: [ubuntu, openssh, ufw]
---

* 参考： 
    * [How to Enable SSH on Ubuntu 18.04](https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/)
    * []()
    * []()



~~~
sudo apt install openssh-server
sudo systemctl status ssh
sudo systemctl enable ssh
sudo ufw allow ssh
~~~




