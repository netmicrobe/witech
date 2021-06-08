---
layout: post
title: 在 CentOS 6 上安装 gcc 4.9
categories: [cm, linux, centos]
tags: [cm, linux, centos, gcc]
---


```
cd /etc/yum.repos.d
wget http://linuxsoft.cern.ch/cern/scl/slc6-scl.repo
yum -y --nogpgcheck install devtoolset-3-gcc devtoolset-3-gcc-c++
scl enable devtoolset-3 bash
gcc --version
```

* 参考
  <http://superuser.com/a/926327>




