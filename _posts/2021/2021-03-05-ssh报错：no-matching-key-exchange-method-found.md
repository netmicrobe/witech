---
layout: post
title: ssh报错：no matching key exchange method found.
categories: [cm, linux]
tags: [openssh]
---

* 参考： 
    * [ssh unable to negotiate - no matching key exchange method found](https://unix.stackexchange.com/a/402749)
    * []()


* 报错现象

~~~
Unable to negotiate with 192.168.2.82 port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
~~~

* 解决

~~~
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c 3des-cbc enduser@192.168.2.82
~~~

