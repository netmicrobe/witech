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
  * [NFS4 mount shows all ownership as "nobody" or 4294967294](https://www.suse.com/support/kb/doc/?id=000017244)
  * [Mapping UID and GID of local user to the mounted NFS share](https://serverfault.com/questions/514118/mapping-uid-and-gid-of-local-user-to-the-mounted-nfs-share)
  * [wiki.archlinux.org - NFS](https://wiki.archlinux.org/title/NFS)
  * [TrueNAS创建NFS共享](https://www.hao0564.com/210.html)
  * [“mount.nfs: access denied by server while mounting” – how to resolve](https://www.thegeekdiary.com/mount-nfs-access-denied-by-server-while-mounting-how-to-resolve/)
  * []()
  * []()
  * []()


## truenas core 12 上配置 NFS服务

1. 开启NFS服务
    1. Services - NFS 条目： 开启 Running 和 Start Automatically
    1. NFS 条目 点击编辑图标，进入configure
    1. Number of servers： 4  （我分配了4个线程给truenas虚拟机）
        默认就是`sysctl -n kern.smp.cpus`的执行结果。指定创建多少个servers 来服务 NFS Clients。如果 NFS client 响应慢了就增加这个数值，但是数值最好小于等于CPU的线程数（即 sysctl -n kern.smp.cpus 的结果），避免频繁的 CPU context switching。
    1. 勾选 Enable NFSv4
    1. 勾选 NFSv3 ownership model for NFSv4
        如果没勾选，在客户端上挂载后，可能看到的文件owner=nobody,group=4294967294
        勾选之后，在客户端上会显示，服务器端上 UID 在本地对应的用户
        其实感觉都不影响使用，勾了满足下强迫症而已。
1. 添加共享目录
1. Paths ，选择要共享的 dataset 或子路径。
1. 勾选 All dirs
    勾选之后就可以单独挂载子目录。
1. 勾选 Enabled
    当然要选，否则就关掉共享了。
1. 点开 Advance Options
1. `Maproot User/Group` 和 `Mapall User/Group` 这2组设置，只能同时设置一组，互斥。
    * `Mapall User/Group` 指定了用户/组，比如，jack:maintainer，那么所有客户端创建的文件，在truenas上的owner都是 jack:maintainer
    设置好了，可以在设置文件看下效果：
        ~~~sh
        # cat /etc/exports

        V4: / -sec=sys
        /mnt/pool/servers -alldirs -mapall="jack":"maintainer" -sec=sys
        ~~~

    * `Maproot User/Group` 指定了用户/组，比如，root:wheel，那么客户端root用户，产生的文件的owner就是 root:wheel；而客户端其他用户产生的文件，owner就保留在客户端上的 UID/GID
        ~~~sh
        # cat /etc/exports

        V4: / -sec=sys
        /mnt/pool/servers -alldirs -maproot="server":"servers" -sec=sys
        ~~~

1. Security: 可以选 SYS，也可以不选。KRB有点复杂，再是没研究，个人用也不需要这么高安全。
1. Networks 和 Hosts 可以限制哪些客户端访问，提高安全性。
    不在允许范围的客户端，可以挂载，但是访问就报错： Input/Output error
1. 


### /etc/exports

exports 文件中 NFSv4 挂载点必须以 "V4: " 为前缀修饰词，且 "V4" 必须使用英文大写字母。

`-alldirs` 表示所有子目录都可以被客户端当作独立挂载点进行挂载

`-alldirs,quiet`  中 quiet 表示如果出错，则以静默方法记录日志








## nfs 客户端


### mount 手动挂载

~~~sh
mount -t nfs server-ip:/usr/ports  /mnt

mount -t nfs -o nfsvers=3 x.x.x.x:/share /mnt

mount -t nfs -o nfsv4 server-ip:/usr/ports  /mnt
~~~


### /etc/fstab 手动挂载

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

### 查看client的版本

~~~sh
# 列出挂载的nfs信息（推荐这种方法）
nfsstat -m

# OR
# 会打印出统计信息，其中有版本信息
nfsstat -c
~~~

















