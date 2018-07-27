---
layout: post
title: 在 CentOS 6/7 上安装 nodejs & npm
categories: [dev, javascript, nodejs]
tags: [javascript, nodejs, npm]
---

* 参考
  * [How To Install Node.js on a CentOS 7 server ](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-a-centos-7-server)

---

## 从源码安装

### 安装高版本 gcc

To compile newer versions of Node.js, GCC 4.8 or higher is required.

#### 在 CentOS 6 上安装 gcc 4.9

``` shell
cd /etc/yum.repos.d
wget http://linuxsoft.cern.ch/cern/scl/slc6-scl.repo
yum -y --nogpgcheck install devtoolset-3-gcc devtoolset-3-gcc-c++
scl enable devtoolset-3 bash
gcc --version
```

* 参考
  * <http://superuser.com/a/926327>


#### 下载 & 安装 v6.9.2

```
wget https://nodejs.org/dist/v6.9.2/node-v6.9.2.tar.gz
tar xzf node-v6.9.2.tar.gz
./configure
make
make install
```

#### 安装成功

```
which node
/usr/local/bin/node

which npm
/usr/local/bin/npm
```


## 从 EPEL Repository 安装

~~~ shell
sudo yum install -y epel-release
sudo yum install -y nodejs npm
node --version
npm --version
~~~



