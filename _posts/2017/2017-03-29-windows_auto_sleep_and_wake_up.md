---
layout: post
title: Windows 系统自动睡眠、自动唤醒（开关休眠/Hibernate功能）
categories: [cm, windows]
tags: [windows, schedule]
---

* 参考：
  * [Winaero - How to sleep a Windows computer from the command line](http://winaero.com/blog/how-to-sleep-a-windows-computer-from-the-command-line/)
  * [Microsoft - Powercfg Command-Line Options](https://technet.microsoft.com/en-us/library/cc748940(v=ws.10).aspx)
  * [Microsoft - PsShutdown 下载](https://technet.microsoft.com/en-us/sysinternals/bb897541.aspx)

## 思路

使用 **计划任务** ，配置睡眠命令和唤醒，来实现自动睡眠和自动唤醒。

## 结果

**没有解决** 这个问题，卡在自动睡眠上。只有“开始”菜单的自动睡眠，可以自动唤醒。

### 试过两种方法都不行。

#### PsShutdown 工具
    
  这个工具无所谓 powercfg -h on/off 打开或者关闭系统的 *休眠* 功能。

  ```
  管理员权限执行 cmd
  psshutdown.exe -d -t 0 -accepteula
  ```  

  *失败原因：* 这个命令执行后，电脑进入睡眠状态，但是呆一会电脑就唤醒了，不知道为什么。
      
#### powrprof.dll,SetSuspendState
  
  这个function SetSuspendState ，将电脑带入 **深度睡眠**， 计划任务无法唤醒，按键也无法唤醒，除了按“电源键”或“左Ctrl键”

  ```
  管理员权限执行 cmd
  powercfg -h off
  rundll32.exe powrprof.dll,SetSuspendState 0,1,0
  ```

  *失败原因：* 这个命令执行后，电脑进入**深度睡眠**，计划任务无法唤醒。
      
    
## 成果

### 开关系统的“休眠”（hibernate）功能

  ```
  管理员权限执行 cmd
  打开休眠
  powercfg -h on
  关闭休眠
  powercfg -h off
  ```

打开休眠功能，会在`C:\`下面产生一个好几个G的文件 `hiberfil.sys`，关闭休眠功能后会被删除。



### 休眠 命令

  ```
  管理员权限执行 cmd
  shutdown -h
  ```

### psshutdown 命令来睡眠电脑

  ```
  管理员权限执行 cmd
  psshutdown.exe -d -t 0 -accepteula
  ```
  
### powrprof.dll,SetSuspendState 睡眠电脑
  
  ```
  管理员权限执行 cmd
   - 先将休眠功能关闭
  powercfg -h off
   - 睡眠电脑
  rundll32.exe powrprof.dll,SetSuspendState 0,1,0
  ```

### 唤醒的计划任务配置

  * 计划任务 》 创建任务
  * “常规”选项卡
    * 填写：名称、描述
    * 勾选：不管用户是否登陆都要运行
    * 勾选：使用最高权限运行
    * “配置”：Windows Vista、Windows Server 2008
  * “触发器”选项卡：配置唤醒时间点
  * “操作”选项卡：C:\Windows\System32\cscript.exe //Nologo //B D:\tools\vbs\just_echo.vbs
  * “条件”选项卡
    * 勾选：“唤醒计算机运行此任务”

  **just_echo.vbs**
  ```
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objFile = objFSO.CreateTextFile("D:\tools\vbs\test.txt", True)
  objFile.WriteLine Now
  objFile.Close

  Wscript.Echo "wakeup!"

  ```
