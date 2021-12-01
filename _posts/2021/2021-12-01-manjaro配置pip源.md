---
layout: post
title: manjaro配置pip源.md
categories: [ dev, python ]
tags: []
---

* 参考：
  * [pip 使用国内镜像源](https://www.runoob.com/w3cnote/pip-cn-mirror.html)
  * []()
  * []()
  * []()
  * []()


## 方法一、修改配置文件

manjaro 上 pip 的配置文件位置： `~/.config/pip/pip.conf`


* 清华

~~~
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = pypi.tuna.tsinghua.edu.cn
~~~




## 方法二、使用配置命令

~~~bash
# 清华源
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 或：
# 阿里源
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# 腾讯源
pip config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# 豆瓣源
pip config set global.index-url http://pypi.douban.com/simple/
~~~



## 方法三、执行pip时，使用 `-i` 参数指定

~~~bash
pip install markdown -i https://pypi.tuna.tsinghua.edu.cn/simple
~~~







