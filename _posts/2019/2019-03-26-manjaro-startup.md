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




## 常用软件

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

~~~
# 基础开发工具
$ sudo pacman -S base-devel

:: There are 24 members in group base-devel:
:: Repository core
   1) autoconf  2) automake  3) binutils  4) bison  5) fakeroot  6) file
   7) findutils  8) flex  9) gawk  10) gcc  11) gettext  12) grep  13) groff
   14) gzip  15) libtool  16) m4  17) make  18) pacman  19) patch  20) pkgconf
   21) sed  22) sudo  23) texinfo  24) which
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

### install through command line

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
1. 
1. 
1. 
1. 

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

~~~
pacman -S ntfs-3g
~~~

一般随系统安装好了。


































