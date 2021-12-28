---
layout: post
title: MX Linux 18.3/19.4 使用
categories: [cm, linux]
tags: [fcitx, anti-linux]
---

* 参考： 
  * []()
  * []()


## 弃坑理由

1. 外接显示器，启动黑屏。
1. 老提醒升级，也关闭不了。

## 安装

* 安装时，语言选择 "en_US.utf8" 不要选择中文界面，实在是中文和英文混杂，而且命令不容易搜索。
  * 安装完成后，可以在登录界面左上角调整语言。

## 升级


默认自动下升级包，点开系统状态栏上的升级提醒，只能选择升级、不升级，也不知道有哪些包升级了。。。


## 查看当前版本信息

~~~
uname -a
lsb_release -a
cat /etc/antix-version
~~~


## 更换国内源


* 参考： 
  * [Debian 10 更换国内源 (中科大、网易源、阿里云)](https://www.jianshu.com/p/b4a792945d99)
  * [Debian 官方源换为国内的源的操作方法](https://developer.aliyun.com/article/765348)
  * [Aliyun - Debian 镜像](https://developer.aliyun.com/mirror/debian?spm=a2c6h.13651102.0.0.3e221b11QWjv7Z)
  * [USTC - Debian 源使用帮助](https://mirrors.ustc.edu.cn/help/debian.html)
  * [清华大学开源软件镜像站]https://mirrors.tuna.tsinghua.edu.cn()
  * [MX社区源，对应 mx.list - MX and MEPIS Community Repository](http://mxrepo.com/)
  * [antiX-19 Packages，对应 antix.list](https://antixlinux.com/antix-19-packages/)
  * [Debian 官方源](https://wiki.debian.org/SourcesList)
  * [Repos – MX-19](https://mxlinux.org/wiki/system/repos-mx-19/)

`sudo vim /etc/apt/sources.list.d/debian.list`

~~~
# Debian 10 buster

### Official ###

deb http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free

deb http://deb.debian.org/debian-security buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

deb http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free

deb http://deb.debian.org/debian buster-backports main contrib non-free
deb-src http://deb.debian.org/debian buster-backports main contrib non-free



# 中科大源

# deb http://mirrors.ustc.edu.cn/debian buster main contrib non-free
# deb http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
# deb http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
# deb http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free

# deb-src http://mirrors.ustc.edu.cn/debian buster main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free



# 官方源

# deb http://deb.debian.org/debian buster main contrib non-free
# deb http://deb.debian.org/debian buster-updates main contrib non-free
# deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free

# deb-src http://deb.debian.org/debian buster main contrib non-free
# deb-src http://deb.debian.org/debian buster-updates main contrib non-free
# deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free



# 网易源

# deb http://mirrors.163.com/debian/ buster main non-free contrib
# deb http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

# deb-src http://mirrors.163.com/debian/ buster main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

# 阿里云

# deb http://mirrors.aliyun.com/debian/ buster main non-free contrib
# deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
# deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
# deb http://mirrors.aliyun.com/debian-security buster/updates main

# deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib
# deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.aliyun.com/debian-security buster/updates main
~~~



`sudo vim /etc/apt/sources.list.d/mx.list`

~~~
# MX Community Main and Test Repos

### Official ###
# For MX-19:
#deb http://mxrepo.com/mx/repo/ buster main non-free  
# MX-19 Testing repo
#deb http://mxrepo.com/mx/testrepo/ buster test
# ahs hardware stack repo
#deb http://mxrepo.com/mx/repo/ buster ahs

### 阿里云 ###
#deb https://mirrors.aliyun.com/mxlinux/mx/repo/ buster main non-free

#ahs hardware stack repo
#deb https://mirrors.aliyun.com/mxlinux/mx/repo/ buster ahs

### 华为云 ###
#deb https://mirrors.huaweicloud.com/mxlinux/mx/repo/ buster main non-free

### 清华 ###
#deb https://mirrors.tuna.tsinghua.edu.cn/mxlinux/mx/repo/ buster main non-free
#deb https://mirrors.tuna.tsinghua.edu.cn/mxlinux/mx/testrepo/ buster test

#ahs hardware stack repo
#deb https://mirrors.tuna.tsinghua.edu.cn/mxlinux/mx/repo/ buster ahs
~~~



## remmina 远程登录 windows

1. apt直接安装
    ~~~
    sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret rdesktop

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


* **如果连接不了**

使用rdesktop命令行执行，看有没有错误信息：

~~~
rdesktop -r sound:local -r disk:nameOnHost=/home/your-name/Downloads -P 192.168.0.103
~~~

如果有错误提示`CredSSP required by server`，在目标windows进行如下设置：

* 解决方法：

  在目标Windows上设置： 此电脑 》右键菜单 》属性 》高级系统设置 》系统属性 》远程 tab 页 》取消勾选`仅允许运行使用网络级别身份验证的远程桌面的计算机连接（建议）`




## 安装 Google Chrome

* 参考
  * [How to install Google Chrome on MX Linux](https://www.fosslinux.com/36130/how-to-install-google-chrome-on-mx-linux.htm)
  * [How To Install Google Chrome on MX Linux 21,19](https://daylifetips.com/install-google-chrome-on-mx-linux/)
  * [How to Install Latest Google Chrome on MX Linux 19.2 / Debian 10](https://gist.github.com/stardigits/e9f3e46c22639fc73a5be91871da0a5c)
  * []()


* 安装 Google Chrome
~~~
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
~~~



* 更新 Google Chrome

~~~
cat /etc/apt/sources.list.d/google-chrome.list

### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
~~~

~~~
sudo apt update
sudo apt upgrade
~~~





## hibernate 休眠功能

MX默认不支持休眠功能，认为不稳定，如何设置参考：  <https://mxlinux.org/wiki/system/hibernate/>

### 设置

1. 查看swap分区的内核名称，例如 `/dev/sda2`
    ~~~
    inxi -P | grep swap
    ~~~
1. 添加 grub 的启动参数
    * 方法一： 修改 `/etc/default/grub` ，添加 `resume = /dev/sdx` ，其中 `sdx` 是swap分区的名称
      ~~~
      GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume = /dev/sda2"
      ~~~
    * 方法二，使用“ Grub Customizer”
      1. 在 MX Package Installer 中安装 "Grub Customizer"
      1. 启动 Grub Customizer -\> General Settings -\> kernel parameters 中添加 `resume = /dev/sdx`

### 使用

* Login Screen
  右上角的Power icon展开菜单有“休眠选项”


* 在Logout对话框（`xfce4-session-logout`）中显示“休眠”按钮
  1. 编辑 `~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml`
  2. Edit lines 36-38 to change ShowHibernate to “true” so it looks like this:
      ~~~
      <property name="shutdown" type="empty">
      <property name="ShowHibernate" type="bool" value="true"/>
      </property>
      ~~~
  3. 注销再登录进来就有“休眠”按钮


* 休眠命令
  1. sysvinit : `sudo pm-hibernate`
  2. systemd  : `systemctl hibernate`





## GUI

MX18.3 使用的是： Xfce 4.12

### 显示反色 invert color

* 参考： <https://superuser.com/questions/570666/debian-ubuntu-invert-all-colours-in-desktop-session-colors>

1. `sudo apt-get install xcalib`
1. `xcalib -i -a` 或 `xcalib -invert -alter`


* 报错 `xcalib error - unsupported ramp size`

参考： <https://askubuntu.com/a/945565>

原因： 新版X和xcalib命令不兼容。

Intel驱动的解决办法， Thinkpad X230 可行：

1. `sudo apt install xorg xserver-xorg-video-intel`
2. 创建文件 `/etc/X11/xorg.conf.d/20-intel.conf` ，写入
~~~
Section "Device"
Identifier "Intel Graphics"
Driver "intel"
EndSection
~~~

补充说明: 在 Ubuntu 上有用的 compiz 在 MX 是没用的。


### Xfce 快捷键

设置和查看到位置： Windows Manager -\> keyborad

Ctrl + Alt + D
: 显示桌面

Windows key
: Brings up the Whisker menu

Ctrl-Alt-Esc
: Changes the cursor into a white x to kill any program

Ctrl-Alt-Del
: Locks the desktop by calling xflock4

Alt-F2
: Brings up a dialog box to run an application

Alt-F3
: Opens the Application Finder which also allows editing menu entries

Alt-F4
: 关闭当前窗口

PrtScr
: Opens the Screenshooter for screen captures


---
: ---

F4
: Drops a terminal down from top of screen

Ctrl-Alt-Bksp
: Closes the session (without saving!) and returns you to the login screen

Ctrl-Alt-F1
: Drops you out of your X session to a command line; use Ctrl-Alt-F7 to return.

Alt-F1
: Opens this MX Linux Users Manual




### 桌面部件 Conky


1. Install conky-manager2 from the repos.
2. Click Start menu > Accessories to find Conky Manager 2.
3. 设置需要显示在桌面的部件


### 便签程序每次启动都出现

启动的一次便签程序，之后每次启动都出现，很烦。

解决： 系统菜单》Session and Startup 》Application AutoStart 找到Note，不勾选。


### 文件管理器 Thunar



### 屏幕分辨率设置




## 中文支持

### 使用fcitx

1. 安装fcitx

    ~~~
    sudo apt install fcitx fcitx-bin fcitx-pinyin fcitx-sunpinyin fcitx-chewing fcitx-config-common fcitx-gtk fcitx-data fcitx-frontend-all fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt4 fcitx-frontend-qt5 fcitx-module-dbus fcitx-module-kimpanel fcitx-module-x11 fcitx-modules fcitx-table-all fcitx-table-boshiamy fcitx-table fcitx-ui-classic
    ~~~

1. 在 home 目录下创建 `.xprofile`
    ~~~
    # .xprofile or .xinitrc
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    ~~~
1. 注销
1. 重新登陆后，启动fcitx设置，Input Method 选项页，点击 “+”
1. 取消勾选：Only Show Current Language
1. 搜索并添加 sunpinyin 或者 pinyin

#### 'Ctrl + Alt + Shift + u' 无效，无法进行unicode 输入

* 解决办法

修改 `/etc/default/keyboard` 删除 `grp:alt_shift_toggle` 配置，例如，

`XKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp"`

改成：

`XKBOPTIONS="grp_led:scroll,terminate:ctrl_alt_bksp"`

可能的原因是 `Alt+Shift` 被系统设置为 `Next Group` 键，导致 `Ctrl + Alt + Shift` 的快捷键都没法用。

* 参考
  * <https://unix.stackexchange.com/a/609732>



### 中文输入法配置


* 参考： <https://mxlinux.org/wiki/other/chinese-simplified-input/>

1. 启动 MX Package Installer
2. 在 Language（语言）类中安装Chinese相关包
3. `im-config -n ibus` 或 `im-config -n fcitx` 切换输入法框架，重启就可以使用
    * Geany 编辑器有问题，候选词窗口始终出现的“屏幕左下角”这个固定位置，不知道Geany在其他distro上什么情况。






## VirutalBox 安装配置


MX 18.3 安装不了5.2.26,只能安装 5.2.24。

MX Package Installer -\> 搜索 VirtualBox ，点击安装。一同安装的还有2个expacks（usb的、vnc的）

安装的速度是真慢，从mx的官方源上安装的。

1. `Super` + R 运行 `pamac-manager`  打开软件管理器
    或者， Application Menu -\> Preferences -\> Add\/Remove Software  
1. 搜索 virtualbox ，安装 VirtualBox
1. 安装过程中，被询问使用什么provider，使用当前内核版本对应的provider
1. 重启电脑
1. 安装extension
    1. 到Oracle官网下载对应版本的extension
    2. 执行 `sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.26.vbox-extpack`
    3. 重启电脑
    4. `VBoxManage list extpacks` 查看安装结果



## 文件系统

### 自动挂载fs

* 参考：
  * [ArchWiki - fstab (简体中文)](https://wiki.archlinux.org/index.php/Fstab_\(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87\))
  * [ArchWiki - NTFS-3G (简体中文)](https://wiki.archlinux.org/index.php/NTFS-3G_\(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87\))
  * <https://community.linuxmint.com/tutorial/view/1513>
  * [CSDN - Archlinux下实现NTFS分区自动挂载](https://blog.csdn.net/baimaozi/article/details/3134267)

* 挂载ext4
  1. 注意提前挂载点：`sudo mkdir /your-mount-point`
  2. 编辑 `/etc/fstab`
      ~~~
      # <file system>   <dir>		<type>    <options>             <dump>  <pass>
      # /dev/sda1
      UUID=通过“lsblk -f”和“fdisk -l”来获得  /your-mount-point   ext4    defaults,noatime 0 0  
      ~~~
  3. ext4 系统自带owner、gid、uid信息，创建filesystem的时候就存在，fstab文件中指定 uid、gid、fmask、dmask，都是没有用的，会导致系统启动失败。

* 挂载ntfs
  1. 注意提前挂载点：
      ~~~
      sudo mkdir /mnt/windows
      sudo chown your-account:your-group /mnt/windows
      ~~~
  1. 编辑 `/etc/fstab`
      ~~~
      # <file system>   <dir>		<type>    <options>             <dump>  <pass>
      /dev/NTFS-partition  /mnt/windows  ntfs-3g   defaults,noatime,uid=username,gid=users,umask=0022,locale=zh_CN.utf8    0 0
      ~~~





### NTFS 支持

随系统安装好了。

~~~
sudo apt-get install ntfs-3g
~~~

### 支持 exfat

随系统安装好了。

~~~
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install -y exfat-fuse exfat-utils
~~~



## Development


### git

~~~
git config --global user.name your-name
git config --global user.email your-email@some-site.com

git config --global alias.l "log --decorate --oneline --graph"
git config --global alias.ll "log --oneline --decorate --graph -10"
git config --global alias.st status
git config --global alias.d diff
git config --global alias.co checkout
git config --global alias.pushall '!git remote | xargs -L1 -I R git push R '

git config --global core.autocrlf input
git config --global color.ui true
git config --global core.filemode false
git config --global http.sslverify false
git config --global http.postbuffer 524288000

git config --global core.editor "vim"
git config --global core.checkStat minimal
~~~


### vim

~~~
# 要用只读模式启动 Vim，可以使用这个命令： 
vim -R file
~~~



### notepadqq

类似 notepad++ 的编辑器。

~~~
sudo add-apt-repository ppa:notepadqq-team/notepadqq
sudo apt-get update
sudo apt-get install notepadqq
~~~

ps: 不要使用snap安装，安装的版本很怪，打开文件时候一个文件都读取不到。


或者，编译安装：

~~~
sudo apt-get update
sudo apt-get install -y qt5-default qttools5-dev-tools qtwebengine5-dev libqt5websockets5-dev libqt5svg5 libqt5svg5-dev libuchardet-dev

git clone https://github.com/notepadqq/notepadqq.git
cd notepadqq/
./configure --prefix /usr
~~~

make 之前修改 `src/ui/Makefile` 和 `src/ui-tests/Makefile`
将其中 qmake 地址不对的地方（`/usr/lib/qt5/bin/qmake`）
改为正确的（`/usr/lib/x86_64-linux-gnu/qt5/bin/qmake`）
mint无此问题，将bin安装到 /usr/lib/qt5/bin ，然后就 /usr/lib/x86_64-linux-gnu/qt5/bin 里面所有执行文件链接到 /usr/lib/qt5/bin，
而debian 9没有。

~~~
make
sudo make install
~~~

#### root权限运行 notepadqq

~~~
sudo notepadqq --allow-root --new-window file-owned-by-root
~~~



## 问题处理

### 启动完成，黑屏，点击鼠标后显示登录窗口

* 描述

Thinkpad X230 连接外置显示器，三星S24D360HL ，启动完成，黑屏，点击鼠标后显示登录窗口。

Ctrl + Alt + F1 切换命令行，发现报错信息是：

~~~
startpar: Service(s) returned failure: plymouth ... failed
~~~

* 解决办法

将 `.Xauthority` 删除或移走

~~~
sudo -i
mv /var/lib/lightdm/.Xauthority /var/lib/lightdm/.Xauthority.bak
~~~














