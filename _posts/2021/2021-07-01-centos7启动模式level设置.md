---
layout: post
title: centos7启动模式level设置
categories: [ cm, linux ]
tags: [ centos, systemctl, runlevel ]
---

* 参考
  * [Change default runlevel in CentOS 7 / RHEL 7](https://www.itzgeek.com/how-tos/linux/centos-how-tos/change-default-runlevel-in-centos-7-rhel-7.html)
  * []()
  * []()
  * []()
---


~~~shell
# 当前target
#   如果是图形界面（原来的level 5）则显示：graphical.target
#   命令行界面（level 3），则显示： multi-user.target

systemctl get-default



# 设置为 level 3
systemctl set-default multi-user.target

# 设置为 level 3
systemctl set-default graphical.target



# 列出所有可用的target
systemctl list-units --type=target
~~~


































































