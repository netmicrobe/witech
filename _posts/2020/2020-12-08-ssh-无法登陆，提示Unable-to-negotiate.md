---
layout: post
title: ssh-无法登陆，提示Unable-to-negotiate, no matching key exchange method found
categories: [cm, ssh]
tags: [shell, terminal, diffie]
---

* 参考： 
  * [How To Configure Custom Connection Options for your SSH Client](https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client)
  * [OpenSSH Legacy Options](https://www.openssh.com/legacy.html)
  * <https://unix.stackexchange.com/questions/340844/how-to-enable-diffie-hellman-group1-sha1-key-exchange-on-debian-8-0>
  * []()


## 报错

~~~
Unable to negotiate with 192.168.251.82 port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
~~~

## 解决

### 方法一

~~~
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 123.123.123.123
~~~

### 方法二

编辑 `~/.ssh/config`

~~~
Host 123.123.123.123
    KexAlgorithms +diffie-hellman-group1-sha1
~~~

或者，带上wildword

~~~
Host 192.168.1.*
    KexAlgorithms +diffie-hellman-group1-sha1
~~~
~~~







