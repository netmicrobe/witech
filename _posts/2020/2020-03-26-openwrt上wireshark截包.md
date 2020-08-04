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
  1. 安装 tcpdump `opkg install tcpdump` 或者 编译openwrt时候将tcpdump编译进去


* 方法一： 从 WAN (例如，eth1)截取报文，保存到文件，然后下载到本地，使用wireshark分析
    ~~~
    killall tcpdump
    tcpdump -i eth1 -vv -w pcap.cap
    ~~~

* 方法二：
1. 在Ubuntu上安装wireshark
    ~~~
    sudo apt install wireshark
    sudo usermod -aG wireshark $(whoami)
    sudo reboot
    ~~~
2. 执行如下命令，启动wireshark从路由器获取数据流
    记得会提示输入密码，ssh一次，sudo一次，要避免输入密码，可以：
    1. `sudo -i` 进入root权限
    2. 将root的密钥（`~/.ssh/id_rsa.pub`的内容）拷贝到openwrt路由器的 `/etc/dropbear/authorized_keys`
        * openwrt 不适用的 openssh 而是 dropbear
    ~~~
    ssh user@myledebox tcpdump -i eth1 -U -s0 -w - 'not port 22' | sudo wireshark -k -i -
    ~~~





















































