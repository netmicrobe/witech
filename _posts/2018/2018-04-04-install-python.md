---
layout: post
title: 安装 Python
categories: [ dev, python ]
tags: [ python, centos, pip, update-alternatives ]
---

* 参考
  * <https://www.digitalocean.com/community/tutorials/how-to-set-up-python-2-7-6-and-3-3-3-on-centos-6-4>

## Installing Python from source

### 下载 Python

* Python2
  ~~~
  wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
  yum install xz-libs

  # Let's decode (-d) the XZ encoded tar archive:
  xz -d Python-2.7.6.tar.xz

  # Now we can perform the extraction:
  tar -xvf Python-2.7.6.tar
  ~~~

* Python3
  ~~~
  wget http://www.python.org/ftp/python/3.3.3/Python-3.3.3.tar.xz
  yum install xz-libs
  xz -d Python-3.3.3.tar.xz
  tar -xvf Python-3.3.3.tar
  ~~~



### build

~~~
./configure --prefix=/usr/local
make
make install
或者
make altinstall   # 不覆盖已有的python
~~~

### 配置

~~~
export PATH="/usr/local/bin:$PATH"
~~~

## 使用 update-alternatives 进行多版本管理

* 参考
  * <https://linuxconfig.org/how-to-change-from-default-to-alternative-python-version-on-debian-linux>
  * <https://packaging.python.org/guides/supporting-multiple-python-versions/>

### CentOS7 为例

1. 默认 Python 2.7.5
    ~~~ shell
    # rpm -ql python-2.7.5-34.el7.x86_64
    /usr/bin/pydoc
    /usr/bin/python
    /usr/bin/python2
    /usr/bin/python2.7
    /usr/share/doc/python-2.7.5
    /usr/share/doc/python-2.7.5/LICENSE
    /usr/share/doc/python-2.7.5/README
    /usr/share/man/man1/python.1.gz
    /usr/share/man/man1/python2.1.gz
    /usr/share/man/man1/python2.7.1.gz
    ~~~

    ~~~ shell
    # 查看 Python2.7.5 的执行文件和软链情况
    ll /usr/bin/python /usr/bin/python2 /usr/bin/python2.7
    ~~~

2. 编译 Python2.7.14 并安装

3. 配置 Python 2.7.14 为首选

    ~~~ shell
    update-alternatives --install /usr/bin/python python /opt/python/python2.7.14/bin/python2.7.14 2
    update-alternatives --list
    ~~~

4. 迁移原有的 Python 2.7.5

    ~~~
    mv /usr/bin/python2.7 /usr/bin/python2.7.5
    rm /usr/bin/python2
    mv /usr/bin/pydoc /usr/bin/pydoc2.7.5
    ln -s /opt/python/python2.7.14/bin/pydoc /usr/bin/pydoc
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7.5 1
    ~~~

5. 修改yum

    CentOS的yum以来系统自带的 python2.7.5 ，修改yum配置文件(vi /usr/bin/yum) 来继续使用老的python。

    把文件头部的 `#!/usr/bin/python` 改成 `#!/usr/bin/python2.7.5` 保存退出即可。



## 安装 pip & virtualenv 

1. 安装 setuptools

    Before installing pip, we need to get its only external dependency - setuptools.

    ~~~
    wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz

    tar -xvf setuptools-1.4.2.tar.gz
    cd setuptools-1.4.2
    python2.7 setup.py install
    ~~~

2. 安装 pip

~~~ shell
# This will install it for version 2.7.6

curl https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py | python2.7 -
~~~

3. 安装 virtualenv 

~~~
pip install virtualenv
~~~





















































