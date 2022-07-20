---
layout: post
title: endeavour-os-使用，关联 android, fcitx5, virtualbox, remmina
categories: [ cm, linux ]
tags: []
---

* 参考
    * []()
    * []()

## Android 使用

### adb 无法 连接 手机，报错： no permissions

* 参考
    * [wiki.archlinux.org - Android Debug Bridge](https://wiki.archlinux.org/title/Android_Debug_Bridge)
    * []()
    * []()
    * []()


1. 使用 `lsusb` 找到手机的 `vendor id` 和 `product id`
    没插手机执行一下 `lsusb` ，插上再执行下，对比下就能找到
1. 添加 udev rules： `/etc/udev/rules.d/51-android.rules`
    文件内容：
    ~~~
    SUBSYSTEM=="usb", ATTR{idVendor}=="[VENDOR ID]", MODE="0660", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="[VENDOR ID]", ATTR{idProduct}=="[PRODUCT ID]", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="[VENDOR ID]", ATTR{idProduct}=="[PRODUCT ID]", SYMLINK+="android_fastboot"
    ~~~
1. 重新查一下手机，udev应该就能自动识别新规则了
1. 如果不行手动reload rule：
    ~~~sh
    udevadm control --reload
    udevadm trigger
    ~~~

## Virtualbox

~~~sh
sudo pacman -S virtualbox virtualbox-ext-vnc virtualbox-guest-iso virtualbox-guest-utils virtualbox-host-dkms
yay -S virtualbox-ext-oracle
~~~

## 中文输入法

~~~sh
sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-gtk fcitx5-material-color fcitx5-nord fcitx5-qt
~~~

## 远程连接工具

### remmina

~~~sh
yay -S remmina  remmina-plugin-rdesktop freerdp
~~~


## KDE / plasma Desktop

### 安装

* refer
    * [Install KDE Desktop Environment on EndeavourOS|Garuda](https://techviewleo.com/install-kde-desktop-environment-on-endeavouros-garuda/)
    * [How to install Desktop Environments next to your existing ones](https://discovery.endeavouros.com/desktop-environments/how-to-install-desktop-environments-next-to-your-existing-ones/2021/03/)
    * [Can't load up display manager. Getting '... File Exists."](https://bbs.archlinux.org/viewtopic.php?id=151156)
    * []()


~~~sh
sudo pacman -Syyu

# Install Xorg
sudo pacman -S --needed xorg sddm

# Install KDE plasma applications.
sudo pacman -S --needed plasma kde-applications
~~~

~~~sh
# 禁用 lightdm
sudo systemctl status lightdm
sudo systemctl disable lightdm
# 启用 sddm
sudo systemctl enable sddm

sudo systemctl enable NetworkManager
~~~

修改配置文件，指定主题

~~~sh
sudo vim /usr/lib/sddm/sddm.conf.d/default.conf
~~~

~~~
[Theme]
# current theme name
 Current=breeze
~~~

重启系统

~~~sh
sudo systemctl reboot
~~~

在login界面，可以切换 Desktop Environment 。


### kconsole 配色

1. Settings \> Manage Profiles... \> New...
1. 设置新的Profile
    * Appearence \> Dark Pastels
1. `.bashrc` 设置 PS1
    拷贝如下
    ~~~sh
    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
    else
    # green
        #PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
    # red
        #PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \w\[\033[01;32m\]]\$\[\033[00m\] '
    # yellow
        PS1='\[\033[01;33m\][\h\[\033[01;36m\] \W\[\033[01;33m\]]\$\[\033[00m\] '
    fi
    ~~~








































