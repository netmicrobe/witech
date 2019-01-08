---
layout: post
title: mac os 上安装python 和 pip
categories: [ cm, python ]
tags: [mac, script, pip]
---

* 参考
	* [Install Python3 on a Mac](https://programwithus.com/learn-to-code/install-python3-mac/)
	* []()


## python 2.7

mac os 10.14 Mojave 自带 python 2.7

所以，只需要安装下 pip ： `sudo easy_install pip`

~~~
$ pip --version
pip 18.1 from /Library/Python/2.7/site-packages/pip-18.1-py2.7.egg/pip (python 2.7)
~~~


## python 3

1. 到App Store 安装 Xcode
2. Install Brew  <https://brew.sh/#install>
      ~~~
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ~~~
3. Install Python3 with Brew
      ~~~
    brew install python3
    ~~~
4. 设置PATH environment
      ~~~
    # Add the following line to your ~/.profile file

    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
    ~~~


