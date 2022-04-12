---
layout: post
title: truenas-使用-nfs，关联
categories: [cm, nas]
tags: []
---

* 参考
  * [truenas.com - nfsshare](https://www.truenas.com/docs/core/sharing/nfs/nfsshare/)
  * [ixsystems.com - freenas - unix-nfs-shares](https://www.ixsystems.com/documentation/freenas/11.2/sharing.html#unix-nfs-shares)
  * [China FreeBSD - 使用NFS网络文件系统](https://chinafreebsd.cn/article/59da3ea17c94e)
  * [NFS 权限和慢速复制](https://cxywk.com/unix/q/Nxxt3dKc)
  * [知乎 - NFS共享存储实战](https://zhuanlan.zhihu.com/p/81752517)
  * [认识 NFS 文件共享协议](https://zhuanlan.zhihu.com/p/31626338)
  * []()
  * []()




~~~sh
# cat /etc/exports

V4: / -sec=sys
/mnt/pool/servers -alldirs -mapall="server":"servers" -sec=sys
~~~


~~~sh
# cat /etc/exports

V4: / -sec=sys
/mnt/pool/servers -alldirs -maproot="server":"servers" -sec=sys
~~~

exports 文件中 NFSv4 挂载点必须以 "V4: " 为前缀修饰词，且 "V4" 必须使用英文大写字母。

-alldirs 表示所有子目录都可以被客户端当作独立挂载点进行挂载

-alldirs,quiet  中 quiet 表示如果出错，则以静默方法记录日志


~~~sh
mount -t nfs server-ip:/usr/ports  /mnt

mount -t nfs -o nfsv4 server-ip:/usr/ports  /mnt
~~~


~~~sh
# 对于 NFSv3 协议调节/etc/fstab

server-ip:/usr/ports   /usr/ports   nfs  rw  0   0

# 对于 NFSv4 协议调节/etc/fstab

server-ip:/usr/ports   /usr/ports   nfs  rw,nfsv4  0   0
~~~

### 客户端使用showmount -e查看远程服务器rpc提供的可挂载nfs信息

~~~sh
[root@nfs-client ~]# showmount -e 172.16.1.31
Export list for 172.16.1.31:
/data 172.16.1.0/24
~~~

### 提高 nfs 速度

挂载时候设置 udp，增加 rsize 和 wsize

例如， fstab 的设置

~~~sh
server:/dir  /dir  nfs  rw,soft,intr,rsize=8192,wsize=8192  0 0
~~~

例如， 使用 UDP 连接：

~~~sh
sudo mount -o udp 192.168.5.60:/home/some_user/downloads ~/test
~~~



















