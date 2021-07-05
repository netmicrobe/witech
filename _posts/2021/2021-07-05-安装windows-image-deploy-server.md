---
layout: post
title: 安装windows-image-deploy-server
categories: [ cm, windows ]
tags: [  ]
---

* 参考
  * [Youtube - Craft Computing - Install Windows like a PRO! Windows Deployment Services Tutorial](https://www.youtube.com/watch?v=ARDjb2UV3Nw)
  * []()
  * []()
---



1. 
1. 安装Windows Server 2019

1. 在 Server 2019 上 安装 Deployment Services
    1. 开始菜单 》Server Manager 》 Manage 》 Roles And Features
    1. 一路 Next，选择 role： `Windows Deployment Services` \> Add Feature \> 一路 Next
    1. Role Services 要勾选 Deployment Server 和 Transport Server

1. 在 Server 2019 上 配置使用 Deployment Services
    1. 开始菜单 》 Windows Deployment Services
    1. 邮件菜单 WDS-HL \> Configure Server > 下一步 》 `Standalone Server`
    1. Remote Installation Folder Location 保持默认 `C:\RemoteInstall`
    1. PXE Server Initial Settings : `Respond to all client computers(known or nknown)`
    1. 下一步直到配置完成。

1. 获取 windows image 文件
    1. 打开windows 10 iso，进入sources目录
    1. 找到 boot.wim 和 install.wim，拷贝到 `C:\RemoteInstall`
        1. 可以重命名下，后面好找，比如 boot.wim 重命名为 win10-202h-boot.wim
    1. 在 Deployment Server 中右击 boot images 文件夹图标，选择刚刚的boot.wim文件，并添加。 
    1. 在 Deployment Server 中右击 install images 文件夹图标， 创建一个Image Group，比如`win10 20h2`，选择刚刚的 install.wim文件，并添加所有出现的 image，但是 不勾选 `Use the default name and description for each of the selected images`，后面自己取个简洁的名字。 
1. 
1. 使用 Windows Deployment Server 给 VM 安装 windows
    1. 在virtualbox上创建虚拟机，设置 System \> Motherboard \> Boot Order \> 勾选 Network 并放置到顶部
    1. 启动虚拟机，按F12进行PXE 网络启动
    1. 弹出的用户名，填写 Server 2019上的帐号，用户名： `WIN-FVLQEOJ3HLB\Administrator`
    `WIN-FVLQEOJ3HLB` 是 Windows Deployment Server 界面中的服务器名称。
1. 
1. 
1. 
1. 




### install.esd 与 install.wim 文件转换


1. 打开powershell，执行：
    ~~~
    dism /Get-WimInfo /WimFile:windows-20h2.stardard.esd

    # SourceIndex 来自上一条命令，表面是esd中的哪个image

    dism /export-image /SourceIMageFile:windows-20h2.stardard.esd /SourceIndex:1 /DestinationImageFile:C;\Wim\Win10-20h2-home.wim  /Compress:max /CheckIntegrity
    ~~~
1. 
1. 

























































