---
layout: post
title: Windows10上安装Linux子系统-WSL
categories: [cm, Windows]
tags: [WSL, Windows-Subsystem-Linux]
---

* 参考： 
    * [Manually download Windows Subsystem for Linux distro packages](https://docs.microsoft.com/en-us/windows/wsl/install-manual#download-using-curl)
    * []()
    * []()
    * []()
    * []()


## 开启Windows 10 对Linux 子系统支持

系统设置 》应用和功能 》程序和功能 》启动或关闭Windows功能 》勾选“适用于Linux的Windows子系统” 》重启系统

## 从 Microsoft app store 安装

1. 启动 `Microsoft Store`
1. 搜索 Ubuntu，选择一个linux，例如，Ubuntu 18.04，点击安装


## 离线安装 WSL

1. 下载
    * Download using PowerShell
        例如，下载Ubuntu 16.04
        ~~~
        Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing
        ~~~
    * Download using curl
        ~~~
        curl.exe -L -o ubuntu-1604.appx https://aka.ms/wsl-ubuntu-1604
        ~~~
1. 安装下载的appx文件
    * 直接双击
    * 通过Powershell安装 `Add-AppxPackage .\app_name.appx`
1. 如果安装不了appx，可以检查是否限制安装来源：
    * 系统设置 》应用和功能 》选择获取应用的位置 》选择“任何来源”
    * Windows 安全中心 》开发者选项 》打开“从任意源（包括松散文件）安装应用”


### 下载链接

* [Ubuntu 20.04](https://aka.ms/wslubuntu2004)
* [Ubuntu 20.04 ARM](https://aka.ms/wslubuntu2004arm)
* [Ubuntu 18.04](https://aka.ms/wsl-ubuntu-1804)
* [Ubuntu 18.04 ARM](https://aka.ms/wsl-ubuntu-1804-arm)
* [Ubuntu 16.04](https://aka.ms/wsl-ubuntu-1604)
* [Debian GNU/Linux](https://aka.ms/wsl-debian-gnulinux)
* [Kali Linux](https://aka.ms/wsl-kali-linux-new)
* [OpenSUSE Leap 42](https://aka.ms/wsl-opensuse-42)
* [SUSE Linux Enterprise Server 12](https://aka.ms/wsl-sles-12)
* [Fedora Remix for WSL](https://github.com/WhitewaterFoundry/WSLFedoraRemix/releases/)

























