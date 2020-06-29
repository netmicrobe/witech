---
layout: post
title: manjaro 入门使用
categories: [cm, linux]
tags: [manjaro]
---

* 参考： 
  * [Manjaro 上手使用简明教程](https://wenqixiang.com/manjaro-guide/)
  * [Manjaro 安装体验小结 - Michael翔lv-2](https://juejin.im/post/5d4e8deef265da03f77e58b0)
  * []()




## LXDE

### 屏幕分辨率设置

Application menu -\> Preferences -\> Monitor Settings


## Grub

### 菜单停留时间设置

1. `sudo vim /etc/default/grub`
  `GRUB_TIMEOUT=需要的秒数`
1. `sudo update-grub`



## 系统时间设置

* ref
  * [Adjusting Arch Linux time to local time ](https://dev.to/musale/adjusting-arch-linux-time-to-local-time-3ki1)
  * [How to Sync Linux Time with NTP Server](https://www.maketecheasier.com/sync-linux-time-with-ntp-server/)
  * [ArchLinux - System settings](https://paquier.xyz/manuals/archlinux/installation-2/system-settings/)
  * [System time - ArchLinux Wiki](https://wiki.archlinux.org/index.php/System_time)
  * []()
  * []()


* **NTP**: Network Time Protocol

### **Hardware clock**

The hardware clock (a.k.a. the Real Time Clock (`RTC`) or `CMOS clock)` stores the values of: Year, Month, Day, Hour, Minute, and Seconds. 
Only 2016, or later, UEFI firmware has the ability to store the timezone, and whether DST is used. 

~~~
# Read hardware clock
sudo hwclock --show

# Set hardware clock from system clock
hwclock --systohc
~~~

### **System clock**

The system clock (a.k.a. the software clock) keeps track of: time, time zone, and DST if applicable. 
It is calculated by the Linux kernel as the number of seconds since midnight January 1st 1970, UTC. 
The initial value of the system clock is calculated from the hardware clock, dependent on the contents of `/etc/adjtime`. 
After boot-up has completed, the system clock runs independently of the hardware clock. 
The Linux kernel keeps track of the system clock by counting timer interrupts.

~~~
# To check the current system clock time (presented both in local time and UTC) as well as the RTC (hardware clock):
timedatectl

# To set the local time of the system clock directly:
timedatectl set-time "yyyy-MM-dd hh:mm:ss"
timedatectl set-time "2014-05-26 11:13:54"
~~~

The hardware clock can be queried and set with the `timedatectl` command. 

~~~
# To change the hardware clock time standard to localtime, use:
timedatectl set-local-rtc 1

# 检查下设置效果
timedatectl | grep local

# To revert to the hardware clock being in UTC, type:
timedatectl set-local-rtc 0
~~~

* 设置时区

~~~
timedatectl set-timezone Asia/Shanghai
~~~


~~~
# 激活 NTP Service
timedatectl set-ntp true

# 查看当前时间设置
timedatectl status
~~~


### 如果是Windows多系统启动，将 Windows 的 hardware clock 设置也统一为 UTC

创建 `some.reg` 文件，内容如下：

如果是32位的Windows，Replace `qword` with `dword`

~~~
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
     "RealTimeIsUniversal"=qword:00000001
~~~

保存后双击执行。



## pacman

### 更换为中国国内源

1. 设置源
    列出国内源，按速度排序，我这边只能看到 sjtu 的源，就只能选这个，确认了。设置在 `/etc/pacman.d/mirrorlist` 中生效。

    ~~~
    sudo pacman-mirrors -i -c China -m rank
    ~~~

    如果不想使用上海交通大学sjtu的源，其他源头地址如下，直接在`/etc/pacman.d/mirrorlist` 修改就好：

    ~~~
      1.275 China          : https://mirrors.ustc.edu.cn/manjaro/
      0.245 China          : https://mirrors.tuna.tsinghua.edu.cn/manjaro/
      0.059 China          : https://mirrors.sjtug.sjtu.edu.cn/manjaro/
    ~~~

    例如，
    ~~~
    Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
    ~~~

1. 更新软件包数据库
    更换上新的国内源之后，可以刷新一下缓存，输入

    ~~~
    # -S: Sync packages
    # -yy: refresh package database, force refresh even if local database appears up-to-date
    sudo pacman -Syy
    ~~~



### 使用AUR （Arch 用户仓库) ArchLinux User Repository

* AUR 官网：  <https://aur.archlinux.org/>


* 安装 yay

  ~~~
  sudo pacman -S yay

  # 配置 yay 的 aur 源为清华源 AUR 镜像，修改的配置文件位于 ~/.config/yay/config.json
  yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
  ~~~


* 使用 yay 按照 ARU 包

  yay 安装命令不需要加 sudo。

  ~~~
  yay -S package # 从 AUR 安装软件包
  yay -Rns package # 删除包
  yay -Syu # 升级所有已安装的包
  yay -Ps # 打印系统统计信息
  yay -Qi package # 检查安装的版本
  ~~~


* 不使用 AUR 助手安装 AUR 软件包
  1. 在 [AUR 页面](https://aur.archlinux.org/)上找到要安装的软件包后
  1. 确认“许可证”、“流行程度”、“最新更新”、“依赖项”等，作为额外的质量控制步骤。
  1. 安装
      ~~~
      git clone [package URL]
      cd [package name]
      makepkg -si
      ~~~




### 直接下载安装包

* [Arch Linux Archive](https://wiki.archlinux.org/index.php/Arch_Linux_Archive)
* []()
* []()
* []()
* <https://archive.archlinux.org/packages>
* <https://archive.org/download/archlinux_pkg_linux-headers>

~~~
# 例如：
sudo pacman -U https://archive.org/download/archlinux_pkg_linux-headers
~~~



### pacman 常用设置

* 显示颜色
  在`/etc/pacman.conf` 中开放Color设置：将 `#Color` 改为 `Color`




### pcaman 常用命令

* ref
  * [pacman (简体中文) - arch wiki](https://wiki.archlinux.org/index.php/Pacman_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
  * [Pacman常用命令](https://www.jianshu.com/p/ea651cdc5530)
  * []()

~~~
# 更新系统
# 在 Archlinux 中，使用一条命令即可对整个系统进行更新：
pacman -Syyu

# 安装包
➔ pacman -S 包名：例如，执行 pacman -S firefox 将安装 Firefox。你也可以同时安装多个包，
只需以空格分隔包名即可。
➔ pacman -Sy 包名：与上面命令不同的是，该命令将在同步包数据库后再执行安装。
➔ pacman -Sv 包名：在显示一些操作信息后执行安装。
➔ pacman -U：安装本地包，其扩展名为 pkg.tar.gz。
➔ pacman -U http://www.example.com/repo/example.pkg.tar.xz 安装一个远程包（不在 pacman 配置的源里面）

# 删除包
➔ pacman -R 包名：该命令将只删除包，保留其全部已经安装的依赖关系
➔ pacman -Rs 包名：在删除包的同时，删除其所有没有被其他已安装软件包使用的依赖关系
➔ pacman -Rsc 包名：在删除包的同时，删除所有依赖这个软件包的程序
➔ pacman -Rd 包名：在删除包时不检查依赖。

# 搜索包
➔ pacman -Ss 关键字：在仓库中搜索含关键字的包。
➔ pacman -Qs 关键字： 搜索已安装的包。关键字可以是正则表达式。
➔ pacman -Qi 包名：查看有关包的详尽信息。
➔ pacman -Ql 包名：列出该包的文件。
# List packages by regex with custom output format
expac -s "%-30n %v" regex

# 搜索文件
# To query the database to know which remote package a file belongs to:
$ pacman -F /path/to/file_name
# To retrieve a list of the files installed by a remote package:
$ pacman -Fl package_name
# To retrieve a list of the files installed by a package:
$ pacman -Ql package_name


# 其他用法
➔ pacman -Sw 包名：只下载包，不安装。
➔ pacman -Sc：清理未安装的包文件，包文件位于 /var/cache/pacman/pkg/ 目录。
➔ pacman -Scc：清理所有的缓存文件。

~~~


### pacman 其他相关工具

#### pacgraph

~~~
sudo pacman -S pacgraph
~~~

~~~
# Print summary to console, does not draw a graph.
pacgraph -c | less
~~~





## 如何安装 deb 包

* [How to Install Deb Package in Arch Linux](https://www.maketecheasier.com/install-deb-package-in-arch-linux/)
* [helixarch/debtap - github](https://github.com/helixarch/debtap)
* []()
* []()


* 使用 debtap 工具

  ~~~
  sudo yay -S debtap
  debtap packagetoconvert.deb
  debtap -U *
  ~~~

* 手动安装 deb 包

  1. 解压 deb 包
  1. `cd` into the extracted Deb folder
  1. 按照包里目录结构，向系统目录拷贝，例如：
      ~~~
      cd ~/Downloads/google-chrome-stable_current_amd64/etc
      sudo mv * /etc/
      cd ~/Downloads/google-chrome-stable_current_amd64/opt
      sudo mv * /opt/
      ~~~









## 系统基础功能


### 常用快捷键

配置快捷键位置： Settings -\> Keyboard -\> Applications Shorcuts

* terminal 打开快捷键：Ctrl + Alt + t
  默认是： `xfce4-terminal --drop-down`



### xfce4-terminal

* 关闭：拷贝信息到命令行时，弹出安全提醒对话框
  xfce4-terminal Edit 菜单 \-> Preferences... -> General 选项卡 -\> 勾掉 Show unsafe paste dialog



### xfce panel

* 添加“Show Desktop”按钮
  右键系统状态栏 -\> Panel -\> Add New Items... -\> 搜索 Desktop ，添加 `Show Desktop`



### Windows Manager

设置窗口摆放位置的快捷键

Windows Manager \> Keyboard \> 设置各种 `Tile windows to xxx`





### kernel

* ref
  * [Manjaro Kernels](https://wiki.manjaro.org/index.php/Manjaro_Kernels)
  * []()
  * []()

* GUI Tool: `Manjaro Settings Manager` -\> kernel
* Terminal Commands: `mhwd-kernel`

~~~
# 当前使用的kernel
mhwd-kernel -li
~~~


### exfat

* 使用 arter97/exfat-linux
  <https://github.com/arter97/exfat-linux>
* aur 上和exfat相关的包
  <https://aur.archlinux.org/packages/?O=0&K=exfat>

~~~
sudo pacman -Rs exfat-utils
sudo pacman -S linux-headers
yay -S exfat-linux-dkms
~~~


### .bashrc

~~~
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	    . ~/.bash_aliases
fi
~~~


### msi-rgb 微星主板灯光控制

源码网站： <https://github.com/nagisa/msi-rgb>
用 rust 语言开发。

~~~
yay -S msi-rgb

# shut down led on motherboard
sudo msi-rgb 00000000 ffffffff 00000000 -x
~~~


### 显卡驱动

* [Configure Graphics Cards - wiki.manjaro.org](https://wiki.manjaro.org/Configure_Graphics_Cards)




## 常用软件

### 基础开发工具

~~~
$ sudo pacman -S base-devel

:: There are 24 members in group base-devel:
:: Repository core
   1) autoconf  2) automake  3) binutils  4) bison  5) fakeroot  6) file
   7) findutils  8) flex  9) gawk  10) gcc  11) gettext  12) grep  13) groff
   14) gzip  15) libtool  16) m4  17) make  18) pacman  19) patch  20) pkgconf
   21) sed  22) sudo  23) texinfo  24) which
~~~


### 浏览器


#### firefox

* 开机后第一次启动很慢

  * 参考：
    * <https://www.linuxquestions.org/questions/linux-general-1/firefox-takes-long-to-start-4175579278/#post5543712>

1. `about:config`
1. network.dns.disableIPv6: true



#### vivaldi

~~~
yay -S vivaldi
# 编译了好长时间，cpu 100% 吃满
yay -S vivaldi-ffmpeg-codecs
~~~


#### google chrome

1. 从 <https://aur.archlinux.org/packages/google-chrome/> 上查看git地址
1. 编译安装
    ~~~
    git clone https://aur.archlinux.org/google-chrome.git
    cd google-chrome
    makepkg -si
    ~~~


* How to enable logging
  * [How to enable logging - The Chromium Projects](https://www.chromium.org/for-testers/enable-logging)
  * [Chrome Browser debug logs - Goolge Chrome Support](https://support.google.com/chrome/a/answer/6271282?hl=en)

  To enable logging, launch Chrome with these command line flags:

  ~~~
  google-chrome-stable --enable-logging=stderr --v=1                 # Output will be printed to standard error (eg. printed in the console)
  google-chrome-stable --enable-logging=stderr --v=1 > log.txt 2>&1  # Capture stderr and stdout to a log file
  google-chrome-stable --enable-logging=stderr --v=1 2>&1 | tee log.txt
  ~~~

* 启动很慢
  * 方法1 [关闭硬件加速](#close-google-chrome-hardware-acceleration)
  * 方法2 硬件加速使用Vulkan
    ~~~
    # 安装Vulkan
    sudo pacman -S amdvlk
    ~~~

    进入chrome，`chrome://flags` 查找 Vulkan，选择 **Enable** __Use vulkan as the graphics backend. – Linux, Android__

    重启系统，启动chrome速度就快啦，还可以  `chrome://gpu` 查看下相关设置：`Vulkan: Enabled`

* 关闭硬件加速
  <a name="close-google-chrome-hardware-acceleration"></a>
  Settings -\> System -\> Use hardware acceleration when available



### 压缩软件

#### rar

* [AUR - Package Details: rar](https://aur.archlinux.org/packages/rar/)
* [Arch Wiki - rar](https://wiki.archlinux.org/index.php/Rar)

`rar` 是在 AUR 库里面，执行 `yay -S rar` 安装，同时应为冲突，卸载系统自带的 `unrar`

~~~
# 典型压缩命令
# -r 	recurse subdirectories (includes all dirs/files under the parent directory).
# -rr10 	adds recovery records to the archive. This way up to 10% of the compressed archive can become corrupt or unusable, and it will be able to recover the data through parity. 

$ rar a -r -rr10 /media/data/darkhorse-backup.rar /home/darkhorse

# Mixed-mode archives
# -m5 	Use the highest level of compression (m0 = store ... m3 = default ... m5 = maximal level of compression.
# -msjpg;mp3;tar 	ignore the compression option and store all .jpg and .mp3 and .tar files. 

$ rar a -r -rr10 -s -m5 -msjpg;mp3;tar /media/data/darkhorse-backup.rar /home/darkhorse
~~~



### 安装百度网盘

~~~
yay -S baidunetdisk-bin
~~~

也可以从deb包转化后安装。

#### 安装百度网盘deb包

* [ArchLinux安装最新百度网盘客户端](https://www.teaper.dev/2019/06/24/baidunetdiskarchlinux/)
* [Archlinux安装百度网盘](https://www.moec.top/archives/599)
* [在容器中运行Linux版百度云盘客户端](http://blog.lujun9972.win/blog/2019/07/23/%E5%9C%A8%E5%AE%B9%E5%99%A8%E4%B8%AD%E8%BF%90%E8%A1%8Clinux%E7%89%88%E7%99%BE%E5%BA%A6%E4%BA%91%E7%9B%98%E5%AE%A2%E6%88%B7%E7%AB%AF/index.html)
* []()

1. 下载官网的 baidunetdisk_linux_2.0.1.deb 安装包到本地
1. deb 包转换成 ArchLinux 包需要借助 Debtap,所以需要先安装一下
    ~~~
    yay -S debtap
    # 同步 pkgfile 和 debtap 数据源
    sudo debtap -u
    ~~~
1. 转换包
    ~~~
    debtap baidunetdisk_linux_*.deb

    Enter Packager name: #输入包名字
    Enter package license (you can enter multiple licenses comma separated): #输入许可证，随便写（大写字母+数字组合），反正是自己用
    ~~~
1. 安装
    转换成功之后，就可以看到本地多了 baidunetdisk-2.0.1-1-x86_64.pkg.tar.xz 包，使用 pacman 将其安装
    `sudo pacman -U baidunetdisk-* .pkg.tar.xz`




### 其他开放工具

~~~
yay -S heidisql
~~~



### 其他

~~~
# deepin 系的软件
sudo pacman -S deepin-picker # 深度取色器
sudo pacman -S deepin-screen-recorder # 录屏软件，可以录制 Gif 或者 MP4 格式
sudo pacman -S deepin-screenshot # 深度截图
sudo pacman -S deepin-system-monitor # 系统状态监控
yay -s deepin-wine-wechat
yay -S deepin-wine-tim
yay -S deepin-wine-baidupan
yay -S deepin.com.thunderspeed

# 开发软件
sudo pacman -S jdk8-openjdk
sudo pacman -S make
sudo pacman -S cmake
sudo pacman -S clang
sudo pacman -S nodejs
sudo pacman -S npm
sudo pacman -S goland
sudo pacman -S vim
sudo pacman -S maven
sudo pacman -S pycharm-professional # Python IDE
sudo pacman -S intellij-idea-ultimate-edition # JAVA IDE
sudo pacman -S goland # Go IDE
sudo pacman -S visual-studio-code-bin # vscode
sudo pacman -S qtcreator # 一款QT开发软件
sudo pacman -S postman-bin
sudo pacman -S insomnia # REST模拟工具
sudo pacman -S gitkraken # GIT管理工具
sudo pacman -S wireshark-qt # 抓包
sudo pacman -S zeal
sudo pacman -S gitkraken # Git 管理工具

# 办公软件
sudo pacman -S google-chrome
sudo pacman -S foxitreader # pdf 阅读
sudo pacman -S bookworm # 电子书阅读
sudo pacman -S unrar unzip p7zip
sudo pacman -S goldendict # 翻译、取词
sudo pacman -S wps-office
yay -S typora # markdown 编辑
yay -S electron-ssr # 缺少我需要的加密算法
yay -S xmind

# 设计
sudo pacman -S pencil # 免费开源界面原型图绘制工具

# 娱乐软件
sudo pacman -S netease-cloud-music

# 下载软件
sudo pacman -S aria2
sudo pacman -S filezilla  # FTP/SFTP

# 图形
sudo pacman -S gimp # 修图

# 系统工具
sudo pacman -S albert #类似Mac Spotlight，另外一款https://cerebroapp.com/
yay -S copyq #  剪贴板工具，类似 Windows 上的 Ditto

# 终端
sudo pacman -S screenfetch # 终端打印出你的系统信息，screenfetch -A 'Arch Linux'
sudo pacman -S htop
sudo pacman -S bat
sudo pacman -S yakuake # 堪称 KDE 下的终端神器，KDE 已经自带，F12 可以唤醒
sudo pacman -S net-tools # 这样可以使用 ifconfig 和 netstat
yay -S tldr
yay -S tig # 命令行下的 git 历史查看工具
yay -S tree
yay -S ncdu # 命令行下的磁盘分析器，支持Vim操作
yay -S mosh # 一款速度更快的 ssh 工具，网络不稳定时使用有奇效
~~~









## 中文环境

* ref
  * [Localization/Chinese - archlinux wiki](https://wiki.archlinux.org/index.php/Localization/Chinese)
  * []()
  * []()
  * []()



### Chinese Input Method . 中文输入法

* ref
  * [Installing fcitx (a Chinese IME) on Arch Linux](https://echoyun.com/2017/10/02/installing-fcitx-chinese-ime-arch-linux/)
  * [Fcitx - ArchLinux Wiki](https://wiki.archlinux.org/index.php/Fcitx)
  * [archlinux中fcitx安装配置与常见问题](https://blog.csdn.net/sinat_33528967/article/details/97611020)
  * [How to install Chinese fonts and input method in Arch Linux](https://medium.com/@slmeng/how-to-install-chinese-fonts-and-input-method-in-arch-linux-18b68d2817e7)
  * []()
  * []()

#### fcitx

1. 安装fcitx
    ~~~
    sudo pacman -S fcitx fcitx-sunpinyin fcitx-configtool
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
1. 搜索并添加 sunpinyin


### 安装中文字体

~~~
sudo pacman -S wqy-zenhei
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-microhei
sudo pacman -S adobe-source-han-sans-cn-fonts
sudo pacman -S adobe-source-han-serif-cn-fonts
~~~





## VirutalBox 安装配置

* [virtualbox 的历史包](https://archive.org/download/archlinux_pkg_virtualbox)

### install through command line

#### 安装最新的Virtualbox

* 最新的virtualbox 6.1 和 virtualbox 5 同时使用有问题，来回安装guest工具
* 不如直接去装 virtualbox 5.2.x（2020年Oracle停止维护）
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


#### 安装Virtualbox 5.2.x

* [Package Details: virtualbox-bin-5](https://aur.archlinux.org/packages/virtualbox-bin-5/)
* [virtualbox-ext-oracle-5](https://aur.archlinux.org/packages/virtualbox-ext-oracle-5/)

~~~
# 卸载 virtualbox 6
sudo pacman -Rs virtualbox
sudo pacman -Rs linux56-virtualbox-host-modules

yay -S virtualbox-bin-5
yay -S virtualbox-ext-oracle-5
~~~


### install through pamac-manager GUI

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
  * [ExFAT with Arch Linux](https://topher1kenobe.com/exfat-with-arch-linux/)

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

* 挂载exfat
  1. 注意提前挂载点：
      ~~~
      sudo mkdir /Volumes/your-exfat-partition
      sudo chown your-account:your-group /Volumes/your-exfat-partition
      ~~~
  1. 编辑 `/etc/fstab`，此处使用的是：  `aur/exfat-linux-dkms`
      ~~~
      # <file system>   <dir>		<type>    <options>             <dump>  <pass>
      UUID=通过“lsblk -f”和“fdisk -l”来获得             /Volumes/your-exfat-partition   exfat    rw,nosuid,nodev,relatime,uid=1000,gid=1000,fmask=0022,dmask=0022,iocharset=utf8,errors=remount-ro  0  0
      ~~~





### NTFS 支持

~~~
pacman -S ntfs-3g
~~~

一般随系统安装好了。


































