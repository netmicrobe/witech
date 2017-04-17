---
layout: post
title: 利用 public key （公钥文件）进行免密码ssh登录
categories: [cm, linux]
tags: [ssh, authentication, ssh-keygen]
---

## 如何配置免密码登录

1. 在《PC》上生成公钥/密钥对
```
ssh-keygen
然后一路回车，密码留空
```
2. 将公钥内容追加到《服务器》上：
```
cat your-idid_rsa.pub >> authorized_keys
```
3. 在《PC》上直接执行 ssh your-name@server-address 即可登录
  * 如果生成公钥密钥时指定了密码，此处要输入公钥密码


## 可能遇到的问题

### root 用户无法登录，《服务器》的sshd禁止root用户登录

* 解决

修改 /etc/ssh/sshd_config

1. 把 PermitRootLogin no 改为 PermitRootLogin yes
2. 重启sshd服务
```
service sshd restart
```

### cygwin 上 dsa类型的公钥无法登录，总是提示输入密码

* 原因
  * 配置的 dsa 类型的公密钥： ssh-keygen -t dsa
  * Cygwin 上装的 OpenSSH_7.5p1，The new openssh version (7.0+) deprecated DSA keys
    * 参考： <https://unix.stackexchange.com/a/247614>


* 解决方法
  * 方法一，设置 ssh 允许 dsa 类型的公密钥（还没试过，以后有空试试～～）
    * 在 ~/.ssh/config 添加
    ```
    PubkeyAcceptedKeyTypes +ssh-dss
    ```
  * 方法二，不使用 dsa 类型，使用 rsa 类型的公密钥
















  


