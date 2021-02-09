---
layout: post
title: ubuntu通过rdp连接windows
categories: [cm, linux]
tags: [rdp, remmina]
---

* 参考： 
    * [How to install Remmina](https://remmina.org/how-to-install-remmina/)
    * []()
    * []()

## Remmina

### Ubuntu and Linux Mint 上安装和使用

Linux Mint 19.3 Tricia 上可以直接安装

1. apt直接安装
    ~~~
    sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret

    # Make sure Remmina is not running. 
    sudo killall remmina
    ~~~
1. 系统菜单启动 Remmina
1. Remmia Remote Desktop Client 界面打开后，点击左上角“+”添加 RDP连接
    Protocol: RDP
    Server: 要连接的Windows IP
    User name: windows帐号
    User password: windows密码
    Resolution: 选小点的分辨率，桌面显示不下，比较尴尬
    Color depth: 选 High color(16 bpp)
        * 选16位色深比较保险。32位可能报错： 
          your libfreerdp does not support H264. Please check Color Depth settings
1. 点击save and run 就可以啦。












