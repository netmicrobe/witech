---
layout: post
title: 安装 Python
categories: [ dev, python ]
tags: [ python, centos, pip, update-alternatives ]
---

* 参考
  * [Daniel Eriksson - How to install the latest version of Python on CentOS](https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/)




## Preparations – install prerequisites

~~~ shell
# Start by making sure your system is up-to-date:
yum update
# Compilers and related tools:
yum groupinstall -y "development tools"
# Libraries needed during compilation to enable all features of Python:
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel ncurses-libs libdbi-devel
# If you are on a clean "minimal" install of CentOS you also need the wget tool:
yum install -y wget
~~~



## Download, compile and install Python

~~~ shell
# Python 2.7.14:
wget http://python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
tar xf Python-2.7.14.tar.xz
cd Python-2.7.14
./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make && make altinstall
 
# Python 3.6.3:
wget http://python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
tar xf Python-3.6.3.tar.xz
cd Python-3.6.3
./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make && make altinstall
~~~

After running the commands above your newly installed Python interpreter will be available as /usr/local/bin/python2.7 or /usr/local/bin/python3.6. The system version of Python 2.6.6 will continue to be available as /usr/bin/python, /usr/bin/python2 and /usr/bin/python2.6



### strip symbols from the shared library to reduce the memory footprint.

~~~ shell
# Strip the Python 2.7 binary:
strip /usr/local/lib/libpython2.7.so.1.0
# Strip the Python 3.6 binary:
strip /usr/local/lib/libpython3.6m.so.1.0
~~~


### trouble shooting

#### make 时报告：modules were not found

参考： <https://gist.github.com/reorx/4067217>

~~~
Python build finished, but the necessary bits to build these modules were not found:
_bsddb             bsddb185           dl
imageop            sunaudiodev
To find the necessary bits, look in setup.py in detect_modules() for the module's name.
~~~

这个报错信息不是错误，这些模块都是过期或者没必要的。

It will show you the modules that can not be build, note that some of them are unnecessary or deprecated:

bsddb185: Older version of Oracle Berkeley DB. Undocumented. Install version 4.8 instead.
dl: For 32-bit machines. Deprecated. Use ctypes instead.
imageop: For 32-bit machines. Deprecated. Use PIL instead.
sunaudiodev: For Sun hardware. Deprecated.
_tkinter: For tkinter graphy library, unnecessary if you don't develop tkinter programs.





## Install/upgrade pip, setuptools and wheel


~~~ shell
# First get the script:
wget https://bootstrap.pypa.io/get-pip.py
 
# Then execute it using Python 2.7 and/or Python 3.6:
python2.7 get-pip.py
python3.6 get-pip.py
 
# With pip installed you can now do things like this:
pip2.7 install [packagename]
pip2.7 install --upgrade [packagename]
pip2.7 uninstall [packagename]
~~~
























































