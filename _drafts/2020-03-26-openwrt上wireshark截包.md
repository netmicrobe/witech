---
layout: post
title: openwrt上wireshark截包. interception
categories: [cm, openwrt]
tags: [wireshark, tcpdump]
---

* 参考： 
  * [How to capture, filter and inspect packets using tcpdump or wireshark tools](https://openwrt.org/docs/guide-user/firewall/misc/tcpdump_wireshark)
  * [ANALYZING NETWORK TRAFFIC WITH OPENWRT](https://www.ayomaonline.com/security/analyzing-network-traffic-with-openwrt/)
  * []()
  * []()
  * []()


* 前提
  1. 安装 tcpdump
      ~~~
      opkg install tcpdump
      ~~~


* 方法一： 从 WAN (例如，eth1)截取报文，保存到文件，然后下载到本地，使用wireshark分析
    ~~~
    killall tcpdump
    tcpdump -i eth1 -vv -w pcap.cap
    ~~~

* 方法二：
1. 在Ubuntu上安装wireshark
    ~~~
    sudo apt-get install wireshark
    sudo mkfifo /tmp/pipe
    sudo chmod 777 /tmp/pipe
    ~~~
1. 将PC的ssh key设置到路由器的 `~/.ssh/authorized_keys`
1. 
~~~
wireshark -k -i /tmp/pipe & ssh root@192.168.1.1 "tcpdump -i any -s 0 -U -w - not port 22" > /tmp/pipe
~~~
1. 
1. 
~~~
ssh user@myledebox tcpdump -i eth1 -U -s0 -w - 'not port 22' | sudo wireshark -k -i -
~~~
1. 
1. 
1. 






















































