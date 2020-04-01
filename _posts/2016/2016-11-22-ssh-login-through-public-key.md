---
layout: post
title: 利用 public key （公钥文件）进行免密码ssh登录
categories: [cm, linux]
tags: [ssh, authentication, ssh-keygen, openssh, openwrt, dropbear]
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




## Openwrt 上免密登录

* 参考：
  * [Dropbear public-key authentication HowTo](https://openwrt.org/docs/guide-user/security/dropbear.public-key.auth)
  * [openwrt - forum - SSH key authentification vs Dropbear](https://forum.openwrt.org/t/solved-ssh-key-authentification-vs-dropbear/17624)
  * [How to Passwordless SSH to an OpenWrt Router?](https://www.systutorials.com/how-to-passwordless-ssh-to-an-openwrt-router/)

openwrt 的 authorized_keys 文件位置为：`/etc/dropbear/authorized_keys`

~~~
cat your-idid_rsa.pub >> /etc/dropbear/authorized_keys
chmod 600 /etc/dropbear/authorized_keys
~~~



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







### 无法登陆，依然提示输入密码

* 现象

配置了 public key 到服务器的 .ssh/authorized_keys 文件，依然提示输入密码

查看 sshd 日志 /var/log/secure ，提示： Authentication refused: bad ownership or modes for directory /home/the_user_name

* 原因

sshd 对 $HOME , .ssh, .ssh/authorized_keys 的文件权限有要求

* 解决方法

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod go-w ~
```

* 参考
  * <http://stackoverflow.com/a/6377073>






### selinux 导致不能登录

sshd_config 的 PermitRootLogin 设置成yes；.ssh , authorized_keys 权限也都设置，依然不能登录。

```
# ls -laZ ~/.ssh
drwx------. root root unconfined_u:object_r:ssh_home_t:s0 .
drwxr-xr--. root root system_u:object_r:admin_home_t:s0 ..
-rw-------. root root unconfined_u:object_r:admin_home_t:s0 authorized_keys
-rw-------. root root unconfined_u:object_r:ssh_home_t:s0 id_rsa
-rw-r--r--. root root unconfined_u:object_r:ssh_home_t:s0 id_rsa.pub
-rw-r--r--. root root unconfined_u:object_r:ssh_home_t:s0 known_hosts
```

* 原因

authorized_keys 是 root 用户手动创建的，文件的属性不符合 selinux 的安全规则。

* 解决方法

```
# restorecon -Rv ~/.ssh
restorecon reset /root/.ssh/authorized_keys context unconfined_u:object_r:admin_home_t:s0->unconfined_u:object_r:ssh_home_t:s0

# ls -laZ ~/.ssh
drwx------. root root unconfined_u:object_r:ssh_home_t:s0 .
drwxr-xr--. root root system_u:object_r:admin_home_t:s0 ..
-rw-------. root root unconfined_u:object_r:ssh_home_t:s0 authorized_keys
-rw-------. root root unconfined_u:object_r:ssh_home_t:s0 id_rsa
-rw-r--r--. root root unconfined_u:object_r:ssh_home_t:s0 id_rsa.pub
-rw-r--r--. root root unconfined_u:object_r:ssh_home_t:s0 known_hosts
```

* 参考：
  * <https://serverfault.com/a/457596>




  


