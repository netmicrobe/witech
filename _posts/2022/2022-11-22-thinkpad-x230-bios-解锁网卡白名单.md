---
layout: post
title: thinkpad-x230-bios-解锁网卡白名单，关联 1vyrain, IVprep
categories: [ ]
tags: []
---

* 参考
  * [github.com - IVprep](https://github.com/n4ru/IVprep)
  * [github.com - 1vyrain](https://github.com/n4ru/1vyrain)
  * [1vyrain — An xx30 ThinkPad Jailbreak](https://medium.com/@n4ru/1vyrain-an-xx30-thinkpad-jailbreak-fd4bb0bdb654)
  * <https://1vyra.in/>
  * [笔记本攻略 篇六：老ThinkPad免编程器刷BIOS上WIFI6网卡](https://post.smzdm.com/p/alpwonvg/)
  * []()
  * []()



## 问题： 

安装了新的 AX210 无线网卡，无法启动 x230，提示： 

~~~
Boot error 1802: unauthorized network card is plugged in

System is halted
~~~


## 解决

修改BIOS，绕过网卡白名单。


### 1vyrain 刷机BIOS


1. 进入BIOS，设置：
    1. Security \> SecureBoot : Disabled
    1. Flash BIOS Updating by End-User改成Enable，Secure RollBack Prevention改成Disabled。
1. 下载 [github.com - IVprep](https://github.com/n4ru/IVprep) ，拷贝到 Windows 系统，执行 `downgrade.bat`
    按 Enter 确认后，会自动重启降级 BIOS，刷入成功后，BIOS版本为 2.60
1. --- ---

1. 下载 `1vyrain.iso` 从 <https://1vyra.in/>
1. 用 rufus 将 `1vyrain.iso` 刷进 U盘
    期间会提示选择模式，要选DD模式。
1. 设置bios启动模式为 uefi
1. 从 `1vyrain.iso` U盘启动
1. 程序会自动识别机型，并匹配相对应的MOD bios。最后会让你确认是否刷如bios，选1即可。
    ~~~
    1) Flash Modified Lenovo BIOS
    2) Flash a custom BIOS from URL
    3) Shutdown / Abort Procedure
    ~~~
    期间会有CRC安全提示，属于正常现象，重启就没有了。
1. 重启后bios的修改就完成了，能在bios中看到高级菜单。刷完bios后，还能解锁超频。

































