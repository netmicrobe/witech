---
layout: post
title: 在 windows 10 卸载自带应用
categories: [cm, windows]
tags: ["windows 10", OneDrive, OneNote]
---

* 参考：
  * <https://lifehacker.com/how-to-completely-uninstall-onedrive-in-windows-10-1725363532>
  * <http://www.win8china.com/html/10523.html>
  * <https://malwaretips.com/threads/how-to-uninstall-default-apps-and-onenote-from-windows-10.49422/>


## OneDrive

### 卸载OneDrive

1. 启动管理员权限命令行

2. `taskkill /f /im OneDrive.exe` 结束正在运行的OneDrive

3. 卸载
    ~~~
    # 32-bit Windows 10 
    %SystemRoot%\System32\OneDriveSetup.exe /uninstall

    # 64-bit Windows 10
    %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
    ~~~



### 重新安装OneDrive

`%SystemRoot%\SysWOW64\` 目录下执行 `OneDriveSetup.exe`



### 本地组策略中设置

1. 使用组合键Win+R，或者右击开始按钮，打开运行对话框，输入gpedit.msc，打开本地组策略编辑器

2. 依次定位到计算机配置》管理模板》Windows组》OneDrive目录。

3. 双击打开禁止使用OneDrive进行文件存储策略设置，选择“已启用”

4. 选择确定后，生效。








## Store

关闭自动更新
app store/ setting/ turn off "Update apps automatically" 









## 使用Powershell删除自带应用

Start / Type 'Powershell' / Right-click / Run as administrator

Remove OneNote from Windows 10 with PowerShell
~~~
Get-AppxPackage *OneNote* | Remove-AppxPackage
~~~

Remove 3D from Windows 10 with PowerShell
~~~
Get-AppxPackage *3d* | Remove-AppxPackage
~~~

Remove Camera from Windows 10 with PowerShell
~~~
Get-AppxPackage *camera* | Remove-AppxPackage
~~~

Remove Mail and Calendar from Windows 10 with PowerShell
~~~
Get-AppxPackage *communi* | Remove-AppxPackage
~~~

Remove Money, Sports, News and Weather from Windows 10 with PowerShell
~~~
Get-AppxPackage *bing* | Remove-AppxPackage
~~~

Remove Groove Music and Film & TV from Windows 10 with PowerShell
~~~
Get-AppxPackage *zune* | Remove-AppxPackage
~~~

Remove People（人脉） from Windows 10 with PowerShell
~~~
Get-AppxPackage *people* | Remove-AppxPackage
~~~

Remove Phone Companion（手机助手） from Windows 10 with PowerShell
~~~
Get-AppxPackage *phone* | Remove-AppxPackage
~~~

Remove Photos from Windows 10 with PowerShell
~~~
Get-AppxPackage *photo* | Remove-AppxPackage
~~~

Remove Solitaire（微软纸牌） Collection from Windows 10 with PowerShell
~~~
Get-AppxPackage *solit* | Remove-AppxPackage
~~~

Remove Voice Recorder from Windows 10 with PowerShell
~~~
Get-AppxPackage *soundrec* | Remove-AppxPackage
~~~

Remove Xbox from Windows 10 with PowerShell
~~~
Get-AppxPackage *xbox* | Remove-AppxPackage
~~~

### 恢复所有被删除的built-in apps

~~~
Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
~~~




## 关闭Cortana（小娜）


1. Type Start button/ Click on Start icon.
2. Select Settings.
3. Type Cortana and select Cortana and search settings.
4. Click on the button to disable.





