---
layout: post
title: manjaro-安装Virtualbox-5
categories: [cm, vm]
tags: []
---

* 参考： 
    * [virtualbox 的历史包](https://archive.org/download/archlinux_pkg_virtualbox)
    * [Package Details: virtualbox-bin-5](https://aur.archlinux.org/packages/virtualbox-bin-5/)
    * [virtualbox-ext-oracle-5](https://aur.archlinux.org/packages/virtualbox-ext-oracle-5/)
    * []()
    * []()


## 安装 VirtualBox 5.2.x

VirtualBox 5.2.44 是 virtualbox5（2020年Oracle停止维护） 最后一个版本，在 `kernel 5.4 LTS` 到 `5.7` 实测可运行，
5.8以后就无法运行，只能选择 Virtualbox 6。

所以：
1. 安装virtualbox 5 之间检查当前kernel，最好只留一个5.4 LTS kernel
1. 只能去 aur 安装 virtualbox 5 了，官方软件库，早就升级到 6 了


### 降级 kernel 到 5.4

~~~
# 检查当前使用kernel
mhwd-kernel -li

# 如果没有安装 5.4,安装下
sudo mhwd-kernel -i linux54

# 重启，以 5.4 内核启动系统

# ====== 删除其他kernel ====== 

# 删除最新kernel
sudo pacman -Rcsnu linux-latest-headers
sudo pacman -R linux59-rt-headers linux-rt-manjaro
# 如果还有其他安装的模块，可用 sudo pacman -Rcsnu linux-latest linux-latest-nvidia-440xx linux-latest-virtualbox-host-modules linux-latest-bbswitch

# 以5.8 为例子，删除制定kernel
sudo pacman -R linux58-headers
sudo mhwd-kernel -r linux58
~~~



### 安装Virtualbox 5

~~~
# 卸载 virtualbox 6
sudo pacman -Rs virtualbox
sudo pacman -Rs linux56-virtualbox-host-modules

# 安装 AUR 里面的virtualbox 5，如果已安装，也执行下如下安装命令，重新安装。
yay -S virtualbox-bin-5
yay -S virtualbox-ext-oracle-5
~~~
z）
* 还有bug，
  * 比如，从锁屏唤醒，键盘没用，鼠标可以。解决方面，在host系统中使用下键盘，在回到virtualbox guest系统就可以使用键盘了。

1. To list what kernels is installed use mhwd 
    ~~~
    $ mhwd-kernel -li
    Currently running: 5.6.11-1-MANJARO (linux56)
    The following kernels are installed in your system:
       * linux56
    ~~~
1. install the kernel modules for your installed kernels, here is **linux56**
    ~~~
    sudo pacman -Syu virtualbox linux56-virtualbox-host-modules
    ~~~








## 报错处理

### 无法启动 5.2.x，报错：kernel drvier not installed(rc=-1908)

* 错误提示
  The VirtualBox Linux kernel driver is either not loaded or not setup correctly.
  Please try setting it up again by executing
  `/sbin/vboxconfig`
  as root.

* 解决：

re-install virtualbox: `yay -S virtualbox-bin-5`

~~~
$ sudo /opt/VirtualBox/vboxdrv.sh setup

vboxdrv.sh: Stopping VirtualBox services.
vboxdrv.sh: Starting VirtualBox services.
~~~

~~~
$ lsmod | grep vbox
vboxpci                28672  0
vboxnetadp             28672  0
vboxnetflt             32768  0
vboxdrv               516096  4 vboxpci,vboxnetadp,vboxnetflt
~~~

~~~
$ mhwd-kernel -li
Currently running: 5.7.19-2-MANJARO (linux57)
The following kernels are installed in your system:
   * linux57
   * linux58
   * linux56-rt
~~~













