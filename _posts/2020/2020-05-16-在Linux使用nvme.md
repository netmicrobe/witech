---
layout: post
title: 在Linux使用nvme
categories: [cm, linux]
tags: [nvme]
---

* 参考： 
  * [linux-nvme/nvme-cli - gihub](https://github.com/linux-nvme/nvme-cli)
  * []()
  * []()
  * []()



~~~
# 获取nvme模块相关信息
$ modinfo nvme
~~~

~~~
sudo apt install nvme-cli
~~~


~~~
sudo apt-get install build-essential libncurses5-dev

git clone https://github.com/linux-nvme/nvme-cli.git

cd nvme-git
make
make install
~~~

~~~
# nvme 测速
sudo hdparm -Tt --direct /dev/nvme0n1
~~~





