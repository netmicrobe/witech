---
layout: post
title: openssh默认不支持ssh-rsa
categories: [cm, linux]
tags: []
---

* 参考
  * [Unable to negotiate with XX.XXX.XX.XX: no matching host key type found. Their offer: ssh-dss](https://stackoverflow.com/questions/34208495/unable-to-negotiate-with-xx-xxx-xx-xx-no-matching-host-key-type-found-their-of)
  * [OpenSSH 8.8 client incompatibility and workaround](https://community.atlassian.com/t5/Bitbucket-articles/OpenSSH-8-8-client-incompatibility-and-workaround/ba-p/1826047)
  * [OpenSSH 8.8 到货，告别 ssh-rsa 支持、错误修复等](https://www.linuxadictos.com/zh-CN/openssh-8-8-%E5%88%B0%E8%B4%A7%EF%BC%8C%E5%91%8A%E5%88%AB-ssh-rsa-%E6%94%AF%E6%8C%81%E9%94%99%E8%AF%AF%E4%BF%AE%E5%A4%8D%E7%AD%89.html)
  * [OpenSSH 8.8 arrives saying goodbye to ssh-rsa support, bug fixes and more](https://www.linuxadictos.com/en/openssh-8-8-llega-diciendo-adios-al-soporte-de-ssh-rsa-correcciones-de-errores-y-mas.html)
  * [OpenSSH 8.8 release disabling rsa-sha digital signature support](https://www.itsfoss.net/openssh-8-8-release/)
  * [Why OpenSSH 8.8 cannot find a host key type if ssh-rsa is provided](https://dev.to/cloudx/why-openssh-8-8-cannot-find-a-host-key-type-if-ssh-rsa-is-provided-49i)
  * []()
  * []()
  * []()
  * []()
  * []()
  * []()


## 问题现象

openssh默认不支持 dss,rsa，执行报错：

~~~bash
Unable to negotiate with 192.168.1.12 port 22: no matching host key type found. Their offer: ssh-rsa,ssh-dss
~~~

## 解决方法


### 方法：修改openssh client 的全局配置

`sudo vim /etc/ssh/ssh_config`

~~~bash
Host *
    HostkeyAlgorithms +ssh-rsa
    PubkeyAcceptedAlgorithms +ssh-rsa
~~~


### 方法：修改用户配置参数

`vim $HOME/.ssh/config`

~~~bash
Host *
    HostkeyAlgorithms +ssh-dss
    PubkeyAcceptedKeyTypes +ssh-dss
~~~



### 方法：命令行里面带加密协议参数：

~~~bash
ssh -oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedAlgorithms=+ssh-rsa  user@192.168.1.12

GIT_SSH_COMMAND="ssh -oHostKeyAlgorithms=+ssh-dss -oPubkeyAcceptedAlgorithms=+ssh-rsa" git clone ssh://user@host/path-to-repository
~~~






































