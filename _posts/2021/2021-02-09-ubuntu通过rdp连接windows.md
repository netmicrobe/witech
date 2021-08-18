---
layout: post
title: linux 通过rdp连接windows
categories: [cm, linux]
tags: [rdp, remmina, remote-desktop, rdesktop, freerdp]
---

* 参考： 
    * [remmina.org - How to install Remmina](https://remmina.org/how-to-install-remmina/)
    * [Your libfreerdp does not support H264](https://gitlab.com/Remmina/Remmina/-/issues/1584)
    * [Remmina can't remote into Windows Server](https://unix.stackexchange.com/a/440813)
    * [Connect to a Windows PC from Ubuntu using Remote Desktop Connection](https://www.digitalcitizen.life/connecting-windows-remote-desktop-ubuntu/)
    * [ArchLinux - Remmina](https://wiki.archlinux.org/index.php/Remmina)
    * [How to connect to a remote desktop from Linux](https://opensource.com/article/18/6/linux-remote-desktop)
    * [Best Linux remote desktop clients of 2021](https://www.techradar.com/best/best-linux-remote-desktop-clients)

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


### Arch Linux / Manjaro 上使用 Remmina

* [wiki.archlinux.org - Remmina](https://wiki.archlinux.org/index.php/Remmina)
* []()
* []()
* []()

~~~
# 如果freerdp存在问题，比如，经常自动断线，可以试试安装 rdesktop
sudo pacman -S freerdp
yay -S remmina remmina-plugin-rdesktop

sudo killall remmina
~~~


## rdesktop

~~~
rdesktop -r sound:local -r disk:nameOnHost=/home/your-name/Downloads -P 192.168.0.103
~~~

登陆成功后，在目标windows 我的电脑下面，会出现`重定向的驱动程序和文件夹`分组下能看到设置的共享文件夹 `/home/your-name/Downloads`


### 报错： CredSSP required by server

* 报错信息
  ~~~
  Failed to initialize NLA, do you have correct Kerberos TGT initialized ?
  Failed to connect, CredSSP required by server (check if server has disabled old TLS versions, if yes use -V option).
  ~~~

* 解决方法：

  在目标Windows上设置： 此电脑 》右键菜单 》属性 》高级系统设置 》系统属性 》远程 tab 页 》取消勾选`仅允许运行使用网络级别身份验证的远程桌面的计算机连接（建议）`

* 参考：
  * [rdesktop连接Windows远程桌面因CredSSP 报错解决办法](https://zhuanlan.zhihu.com/p/371497627)
  * []()
  * []()














































