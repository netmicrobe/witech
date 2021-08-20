---
layout: post
title: 安装windows-image-deploy-server，自定义ISO
categories: [ cm, windows ]
tags: [  ]
---

* 参考
  * [Youtube - Craft Computing - Install Windows like a PRO! Windows Deployment Services Tutorial](https://www.youtube.com/watch?v=ARDjb2UV3Nw)
  * [Youtube - Craft Computing - THIS is what Windows 10 should look like! - Custom Windows Image Tutorial](https://www.youtube.com/watch?v=PdKMiFKGQuc&t=1542s)
      * [Youtube - Craft Computing - Decrapify Script](https://drive.google.com/file/d/1p5kzaeLoBzUDKqH1p4cgvi2sNShFHU5i/edit)
          * [2020-DeCrapify.ps1](2020-DeCrapify.ps1)
  * [kilObit – Learn Tips & Tricks, Discover Apps & Games](https://kil0bit.blogspot.com/2020/09/how-to-make-your-own-windows-10-lite.html)
  * [Microsoft - Download Windows 10 Disc Image (ISO File)](https://www.microsoft.com/en-au/software-download/windows10ISO)
  * [Microsoft - Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx)
  * [MSMG Toolkit](https://msmgtoolkit.in/?i=2)
  * [Microsoft - Download and install the Windows ADK](https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install)
  * []()
  * []()
---

## 部署 Windows Deployment Services

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



## 创建自定义的 windows 安装文件

1. 使用 `Windows System Image Manager` 创建 answerfile （应答文件），answer file 包含了windows 10安装过程中的配置。
1. 下载 Windows ADK 工具集合，其中包含工具 Windows System Image Manager
    [ADK download for Windows 10](https://support.microsoft.com/en-us/windows/adk-download-for-windows-10-2a0b7ff2-79b7-b989-f727-43ae506e36ad)
1. 安装 ADK 工具集合，启动 `Windows System Image Manager`
1. 文件 菜单 》新建应答文件
1. Windows 映像 》Components 》amd64_Microsoft-Windows-Setup_10.0.19041.1_neutral
    1. UserData 》 右键菜单 》添加设置以传送1 WindowsPE（1）
    1. UserData - AcceptEula: true
    1. UserData - ProductKey - Key : 产品序列号
1. amd64_Microsoft-Windows-Shell-Setup_10.0.19041.1_neutral
    1. OOBE - 右键菜单 - Add Setting to Pass 7 oobeSystem
        1. HideEULAPage : true
        1. HideOEMREgistrationScreen : true
        1. HideOnlineAccountScreen : true
        1. HideWirelessSetupInOOBE : true
        1. NetworkLocation: Work
        1. SkipMachineOOBE: true
        1. SkipUserOOBE: true
        1. 删除 OOBE - VMModeOptimizations
    1. UserAccounts - 右键菜单 - Add Setting to Pass 7 oobeSystem
        1. AdministratorPassword - value : 设置管理员密码
        1. 删除 DomainAccounts
        1. LocalAccounts - 右键菜单 - 插入新建 LocalAccount
            1. Group: Administrator
            1. Name: your-account-name
            1. DisplayName: your-name
            1. LocalAccount - Password 设置密码
1. FirstLogonCommands - SynchronousCommands
    1. CommandLine: `reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "disabledmwappushservice" /t REG_SZ /d "sc config dmwappushservice start= disabled"`
    1. description: Disable DM WAP Push Service
    1. Order: 1
    1. RequireUserInput: false
1. 
1. 创建的应答文件 unattend.xml，拷贝到当前运行的Windows 10 的 `C:\WIndows\System32\Sysprep` 下面

1. Sysprep
    1. 双击启动Sysprep
        1. System Cleanup Action: Enter System Out-of-Box Experience(OOBE)
        1. 勾选 Generalize
        1. Shutdown Options: Shutdown
        1. 确定后会运行一段时间，然后关机
    1. 如果报错，可查看 `C:\WIndows\System32\Sysprep\setupact.log`
1. VM 设置从Network 启动，启动到Image Deploy Server
1. 看到 Windows Setup 界面后，按下 `Shift + F10` 进入命令行界面
    ~~~
    net use z: \\ip-of-deploy-server\REMINST /user:Administrator your-password

    # 进入 z 盘
    z:

    # 生成wim文件
    # 命令中的C:\ 是指windows系统盘，实际可能不一定是C盘，也可能D盘或者其他盘，执行前，用dir先查查看
    dism /Capture-Image /ImageFile:Win10-Pro-20H2.wim /CaptureDir:C:\ /Name:"Windows 10 Pro 20H2"
    ~~~
    
    
1. 生成wim文件存放在 deploy server 的 `C:\RemoteInstall` 目录下
1. 将生成的 wim 文件导入 deploy server
1. 设置应答文件
    1. 双击这个Image，勾选 `Allow image to install in unattended mode`
    1. 选择 Select File... ，在弹出的文件对话框中选择目标 `unattend.xml`
1. 
1. 
1. 
1. 

这个方法生成install.wim 打包进 iso，安装时到专业版、教育版选项的时候，没有选项了。。。。





## 将当前运行的 Windows 10 生成 iso 安装文件

1. 删除当前用户，此电脑 》管理 》用户
1. 运行 `cleanmgr` ，进行临时文件清理
1. `%windir%\System32\Sysprep\sysprep.exe /audit /reboot`
    1. 重启后，弹出“系统准备工具 3.14”对话框，上面2个选项：
    1. 系统清理操作：进入系统全新体验（OOBE）
    1. 勾选“通用”
    1. 关机选项：关机
1. 确定关机
1. 启动这个windows就进入了 欢迎设置界面。一通安装windows配置。。。
1. 在C盘另外的盘，例如D盘，创建文件夹 `Scratch`
1. 从windows安装U盘启动
1. 启动到Windows安装的第一个界面时，按 `Shift + F10` 进入命令行
1. `diskpart` 进入 diskpart 软件
1. `list vol` 看看各个分区的盘符，例如，系统盘C现在是F，D盘现在是E
1. `dism /capture-image /imagefile:E:\install.wim /captureDir:F:\ /ScratchDir:E:\Scratch /name:"windoes10Prox64" /compress:maximum /checkintegrity /verify /bootable`
1. 执行完成，重启进入Windows之后，D盘就可以看到 `install.wim` 文件
1. mount windows 原来iso文件，进入mount的光盘，把文件都拷贝出来，例如，新建个名叫 myiso 文件夹放着。
1. 用生成的 `install.wim` 替换 `myiso/sources/install.wim`
1. 下载 Windows ADK 工具 `adksetup`
    <https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install>
1. 已管理员身份运行 `adksetup`
    1. Select the Features you want to install 页面选择： 只选 Deployment Tools
1. 安装完成后，在开始菜单找到 `Deployment and Imaging Tools`，这是个命令行工具，已管理员身份运行
1. 运行
`oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bd:\myiso\boot\etfsboot.com#pEF,e,bd:\myiso\efi\microsoft\boot\efisys.bin d:\myiso d:\Windows10Prox64.iso`
1. 
1. 
1. 
1. 
1. 
1. 



## 附录

### install.esd 与 install.wim 文件转换


1. 打开powershell，执行：
    ~~~
    dism /Get-WimInfo /WimFile:windows-20h2.stardard.esd

    # SourceIndex 来自上一条命令，表面是esd中的哪个image

    dism /export-image /SourceIMageFile:windows-20h2.stardard.esd /SourceIndex:1 /DestinationImageFile:C;\Wim\Win10-20h2-home.wim  /Compress:max /CheckIntegrity
    ~~~
1. 
1. 


### 运行 Sysprep 报错 Package Microsoft.LanguageExperiencePackzh-CN_19041.26.68.0_neutral__8wekyb3d8bbwe was installed for a user

* 参考
  * <https://www.itsk.com/thread-412125-1-1.html>

~~~
2021-07-06 13:53:57, Error                 SYSPRP Package Microsoft.LanguageExperiencePackzh-CN_19041.26.68.0_neutral__8wekyb3d8bbwe was installed for a user, but not provisioned for all users. This package will not function properly in the sysprep image.
2021-07-06 13:53:57, Error                 SYSPRP Failed to remove apps for the current user: 0x80073cf2.
2021-07-06 13:53:57, Error                 SYSPRP Exit code of RemoveAllApps thread was 0x3cf2.
2021-07-06 13:53:57, Error                 SYSPRP ActionPlatform::LaunchModule: Failure occurred while executing 'SysprepGeneralizeValidate' from C:\Windows\System32\AppxSysprep.dll; dwRet = 0x3cf2
2021-07-06 13:53:57, Error                 SYSPRP SysprepSession::Validate: Error in validating actions from C:\Windows\System32\Sysprep\ActionFiles\Generalize.xml; dwRet = 0x3cf2
2021-07-06 13:53:57, Error                 SYSPRP RunPlatformActions:Failed while validating Sysprep session actions; dwRet = 0x3cf2
2021-07-06 13:53:57, Error      [0x0f0070] SYSPRP RunDlls:An error occurred while running registry sysprep DLLs, halting sysprep execution. dwRet = 0x3cf2
2021-07-06 13:53:57, Error      [0x0f00d8] SYSPRP WinMain:Hit failure while pre-validate sysprep generalize internal providers; hr = 0x80073cf2
~~~

解决方法：

删除这个包

~~~
PowerShell -Command "Get-AppxPackage Microsoft.LanguageExperiencePackzh-CN* | Remove-AppxPackage"
~~~


















































