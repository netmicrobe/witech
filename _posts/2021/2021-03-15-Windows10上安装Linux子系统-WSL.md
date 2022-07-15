---
layout: post
title: Windows10上安装Linux子系统-WSL
categories: [cm, Windows]
tags: [WSL, Windows-Subsystem-Linux]
---

* 参考： 
    * [Manually download Windows Subsystem for Linux distro packages](https://docs.microsoft.com/en-us/windows/wsl/install-manual#download-using-curl)
    * [Manual installation steps for older versions of WSL](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
    * [How to install wsl2 offline](https://ripon-banik.medium.com/how-to-install-wsl2-offline-b470ab6eaf0e)
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

### 安装 Ubuntu_2204 到 windows 10 2021 上报错：

`Add-AppxPackage -Path .\Ubuntu2204-220620.AppxBundle`

~~~
Add-AppxPackage : 部署失败，原因是 HRESULT: 0x80073CF3, 包无法进行更新、相关性或冲突验证。
Windows 无法安装程序包 CanonicalGroupLimited.Ubuntu22.04LTS_2204.0.10.0_x64__79rhkp1fndgsc，因为此程序包依赖于一个找不到的框架。请随要安装的此程序包一起提供由“CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US”发布的框架“Microsoft.VCLibs.140.00.UWPDesktop”(具有中性或 x64 处理器体系结构，最低版本为 14.0.24217.0)。当前已安装的名称为“Microsoft.VCLibs.140.00.UWPDesktop”的框架为: {}

注意: 有关其他信息，请在事件日志中查找 [ActivityId] 55d6d2fb-9745-0000-4adf-d6554597d801，或使用命令行 Get-AppPackageLog -ActivityID 55d6d2fb-9745-0000-4adf-d6554597d801
所在位置 行:1 字符: 1
+ Add-AppxPackage -Path .\Ubuntu2204-220620.AppxBundle
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : WriteError: (C:\Users\mortal...0620.AppxBundle:String) [Add-AppxPackage], IOException
    + FullyQualifiedErrorId : DeploymentError,Microsoft.Windows.Appx.PackageManager.Commands.AddAppxPackageCommand
~~~

* 解决方法

1. 下载 Microsoft.VCLibs.x64.14.00.Desktop.appx
    <https://docs.microsoft.com/en-us/troubleshoot/developer/visualstudio/cpp/libraries/c-runtime-packages-desktop-bridge>

1. 安装： `Add-AppxPackage -Path .\Microsoft.VCLibs.x64.14.00.Desktop.appx`
1. 在安装Ubuntu 2204 就好了。
    `Add-AppxPackage -Path .\Ubuntu2204-220620.AppxBundle`


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

























