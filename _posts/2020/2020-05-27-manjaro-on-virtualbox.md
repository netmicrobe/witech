---
layout: post
title: 在 virtualbox 中使用 Manjaro 20
categories: [cm, vm, virtual-box]
tags: [cm, virtual-box, manjaro, vm, kernel, virtualize, network, ssh]
---




## 安装 增强功能 virtualbox Additions工具包

* 参考
  * []()
  * []()


### Manjaro 20 上安装步骤

* ref
  * [VirtualBox - Running Manjaro under VirtualBox - Manjaro Wiki](https://wiki.manjaro.org/index.php?title=VirtualBox#Running_Manjaro_under_VirtualBox)

#### 从 pacman 安装 virtualbox-guest-utils linux54-virtualbox-guest-modules

我用的 virtualbox 5.2.x ，当前 manjaro 20 安装的都是 6.1.x，用这个方法安装additions 完全没用。

#### **注意** 使用插入当前版本additions iso的方法安装

1. 安装依赖
    ~~~
    # 查看kernel版本，这里是linux56
    mhwd-kenerl -li

    # 安装依赖
    sudo pacman -S base-devel linux56-headers
    ~~~

1. 重启
1. 菜单 Devices -\> Insert Guest Additions CD image 插入当前版本5.2.42对应的addtions iso

1. 安装
    ~~~
    cd /run/media/wivb/VBox_GAs_5.2.42
    sudo ./VBoxLinuxAdditions.run
    ~~~
1. 重启，检查安装情况
    ~~~
    $ VBoxClient --version
    5.2.42r137960

    $ sudo systemctl list-units --type=service | grep box
      vboxadd-service.service            loaded active running vboxadd-service.service
      vboxadd.service                    loaded active exited  vboxadd.service 
    ~~~

1. 卸载
    如果感觉没有效果，就卸载吧！！！
    我用的感觉是**部分有效**，双向共享剪贴板，有效！  自动随窗口大小缩放，无效！
    ~~~
    sudo ./VBoxLinuxAdditions.run uninstall
    ~~~



## VBoxManage & Graphics Controller

* 参考
  * [Chapter 8. VBoxManage - virtualbox.org](https://www.virtualbox.org/manual/ch08.html)
  * [7.8. VBoxManage modifyvm - VBoxManage - doc.oracle.com](https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-modifyvm.html)
  * [What are differences between VBoxVGA, VMSVGA and VBoxSVGA in VirtualBox?](https://superuser.com/a/1403131)

~~~
# 列出所有vm
VBoxManage list vms

# Graphic Controller 设置
$ VBoxManage showvminfo ca8673a6-eb29-491c-9dc0-812423bbf927 | grep -i vga
Graphics Controller:         VBoxVGA
# 将 Graphic Controller 改为 vmsvga
VBoxManage modifyvm ca8673a6-eb29-491c-9dc0-812423bbf927 --graphicscontroller vmsvga
~~~


## Manjaro 20 Guest 启动慢的问题

* 参考
  * [VirtualBox 6 slow start/shutdown - forum.manjaro.org](https://forum.manjaro.org/t/virtualbox-6-slow-start-shutdown/70627/21)


禁止了 vboxadd service 之后，关机/开机 速度是有提高。 而且不影响**双向共享剪贴板**，神奇～～

~~~
sudo systemctl stop vboxadd
sudo systemctl disable vboxadd
~~~














