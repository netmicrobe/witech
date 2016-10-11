---
layout: post
title: vbs 获取硬件序列号等信息 、 BIOS信息、Machine Name
categories: [cm, windows, vbs]
tags: [cm, vbs, windows, bios]
---

* 参考
  * <http://msdn.microsoft.com/en-us/library/aa394077%28v=vs.85%29.aspx>
  * <http://www.dreamincode.net/forums/topic/253305-use-vbscript-to-find-and-display-my-computers-serial-number/>
  * <http://www.activexperts.com/admin/scripts/wmi/vbscript/0047/>


## 获取硬件序列号等信息 、 BIOS信息

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")


Set colBIOS = objWMIService.ExecQuery("Select * from Win32_BIOS")

For each objBIOS in colBIOS
  WScript.Echo "SERIAL=" & objBIOS.SerialNumber & vbCrlf & _
        "Manufacturer=" & objBIOS.Manufacturer &vbCrlf & _
        "Name=" & objBIOS.Name &vbCrlf & _
        "Status=" & objBIOS.Status &vbCrlf & _
        "Version=" & objBIOS.Version &vbCrlf & _
        "Caption=" & objBIOS.Caption &vbCrlf & _
        "Description=" & objBIOS.Description &vbCrlf & _
        "CodeSet=" & objBIOS.CodeSet &vbCrlf & _
        "BuildNumber=" & objBIOS.BuildNumber &vbCrlf & _
        "CurrentLanguage=" & objBIOS.CurrentLanguage &vbCrlf & _
        "TargetOperatingSystem=" & objBIOS.TargetOperatingSystem &vbCrlf & _
        "OtherTargetOS=" & objBIOS.OtherTargetOS &vbCrlf & _
        "SoftwareElementID=" & objBIOS.SoftwareElementID &vbCrlf & _
        "SoftwareElementState=" & objBIOS.SoftwareElementState &vbCrlf & _
        "InstallDate=" & objBIOS.InstallDate &vbCrlf
Next
```

##  获取 机器名称 Machine Name

```
Set wshShell = WScript.CreateObject( "WScript.Shell" )
strComputerName = wshShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
WScript.Echo "Computer Name: " & strComputerName
```

