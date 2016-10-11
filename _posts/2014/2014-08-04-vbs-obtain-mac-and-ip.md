---
layout: post
title: vbs 获取Mac地址和IP地址
categories: [cm, windows, vbs]
tags: [cm, vbs, windows, mac]
---

## 获取已连接的Mac地址和IP地址

```
'获取已连接的Mac地址和IP地址

strMachineName = "."

echoMAC strMachineName


Sub echoMAC(strComputer)
    On error Resume Next
    Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
    Set colItems = objWMIService.ExecQuery _
        ("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
        
    For Each objItem in colItems
        
        If IsArray( objItem.IPAddress ) Then
            If UBound( objItem.IPAddress ) = 0 Then
                strIP = "IP Address: " & objItem.IPAddress(0)
            Else
                strIP = "IP Addresses: " & Join( objItem.IPAddress, "," )
            End If
        End If
        
        Wscript.Echo objItem.MACAddress & " " & strIP
    Next
    
End Sub
```


## 获取所有mac，无论是否已经连接

```
'Retrieve Your Computer's MAC Address(es)
'获取所有mac，无论是否已经连接

intCount = 0
strMAC   = ""
' We're interested in MAC addresses of physical adapters only

strQuery = "SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionID > ''"

Set objWMIService = GetObject( "winmgmts://./root/CIMV2" )
Set colItems      = objWMIService.ExecQuery( strQuery, "WQL", 48 )

For Each objItem In colItems
    If InStr( strMAC, objItem.MACAddress ) = 0 Then
        strMAC   = strMAC & "," & objItem.MACAddress
        intCount = intCount + 1
    End If
Next

' Remove leading comma    
If intCount > 0 Then strMAC = Mid( strMAC, 2 )

Select Case intCount
    Case 0
        WScript.Echo "No MAC Addresses were found"
    Case 1
        WScript.Echo "MAC Address: " & strMAC
    Case Else
        WScript.Echo "MAC Addresses: " & strMAC
End Select
```

