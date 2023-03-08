---
layout: post
title: ssh登录centos宿主机很慢，关联 
categories: [ ]
tags: []
---

* 参考
  * <https://serverfault.com/a/815545>
  * <https://serverfault.com/a/816187>



### 可能

`/etc/resolv.conf` 中的 NameServer 未响应或者很慢

把NameServer改成一个快的。

或者，`/etc/ssh/sshd_config` 中的 `UseDNS` 设置改成 `no`


### 可能

1. `/etc/ssh/sshd_config` 中的 `GSSAPIAuthentication` 设置改成 `no`
2. 重启sshd： `systemctl restart sshd`

说明：

GSSAPI (Generic Security Service Application Programming Interface) is essentially an API that utilises Kerberos libraries to provide strong network encrypton.

















