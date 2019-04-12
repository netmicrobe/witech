---
layout: post
title: MX Linux 入门使用
categories: [cm, linux]
tags: []
---

* 参考： 
  * []()
  * []()


## 安装

* 安装时，语言选择 "en_US.utf8" 不要选择中文界面，实在是中文和英文混杂，而且命令不容易搜索。
  * 安装完成后，可以在登录界面左上角调整语言。

## 升级


默认自动下升级包，点开系统状态栏上的升级提醒，只能选择升级、不升级，也不知道有哪些包升级了。。。




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






## Xfce

### 快捷键

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







### 文件管理器 Thunar



### 屏幕分辨率设置




## 中文支持


### 中文输入法配置


* 参考： <https://mxlinux.org/wiki/other/chinese-simplified-input/>

1. 启动 MX Package Installer
2. 在 Language（语言）类中安装Chinese相关包
3. `im-config -n ibus` 或 `im-config -n fcitx` 切换输入法框架，重启就可以使用
    * Geany 编辑器有问题，候选词窗口始终出现的“屏幕左下角”这个固定位置，不知道Geany在其他distro上什么情况。






## VirutalBox 安装配置

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

































