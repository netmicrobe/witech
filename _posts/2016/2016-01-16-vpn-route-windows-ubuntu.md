---
layout: post
title: VPN连接后同时访问内外网（Windows、Ubuntu）
categories: [cm, network, vpn]
tags: [cm, network, vpn]
---


## Windows7 上设置

### 配置内网路由

第一步。关闭VPN默认路由

在VPN属性中选择 网络－Internet协议（TCP/IP）－属性－高级，去掉“在远程网络上使用默认网关”的勾。

第二步。拨VPN，添加静态路由

连接VPN后在VPN连接的状态－详细信息 中找到客户端IP。

运行CMD，在命令行中输入route add 目标IP mask 子网 客户端IP，如：route add 1.1.1.1 mask 255.255.255.255 10.10.10.10

```
route add 目标IP mask 子网 客户端IP
route add 192.168.10.0 mask 255.255.255.0 192.168.10.220 metric 1
```

如果你的VPN连接IP是固定了的话到这里就可以了。在route add命令最后加上-p，这样就算重启也不会丢失。但是，现在绝大部分的VPN都不会是固定IP，怎么办？每次拨VPN都进行一下这样的操作，好麻烦的。不过好，windows系统有强大的批处理功能让计算机来自动处理这些事。

将以下代码另存为vpn.bat,执行这个就可以了

{% highlight bat %}
@echo off
rasdial VPN-name username password
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i 10.10') do set vpnip=%%i
route add Destination mask Netmask %vpnip%
{% endhighlight %}

代码说明：

第一行：关闭回显

第二行：拨入VPN，其中VPN换为你的VPN连接名称，username和password分别是用户名和密码

* 注意！！注意密码中的特殊字符：
  * 密码用双引号括起来
  * %：使用%%来转义

第三行：查看拨入的VPNIP并转为变量“vpnip”，将10.10替换为你拨VPN后获取的IP段

第四行：写入静态路由，将destination换为你需要访问的目标地址，也可以是网段，将netmask换为目标子网，也目标地址对就应，如果目录地址为单个IP，如1.1.1.1，那么子网为255.255.255.255，如果目标地址为网段，如1.1.1.0，那么子网为255.255.255.0

                  
### 如何以管理员权限运行拨号的bat

                  
1. 创建一个针对bat的日常任务。
2. 计划任务 》 新建任务：
3. 填写任务名称，勾选“使用最高权限运行”，
4. 操作选项卡中，新建操作“启动程序”路劲指向bat脚本，
5. 确定完成创建。
6. 创建快捷方式指向刚创建的机会任务。
  * 例如，C:\Windows\System32\schtasks.exe /run /tn "\wi\vpn_dail_105.224"
  "\wi\vpn_dail_105.224"，在wi目录下载计划任务（计划任务管理程序以目录树的形式管理任务）。



## Ubuntu 13.10 上设置

参考：
<http://leegorous.net/blog/2012/06/11/ubuntu-vpn-connection-can-not-access-internet-and-intranet-simultaneously/>

### 设置VPN拨号

设置内网使用的路由

系统状态条 网络设置 》 VPN Connections 》Configure VPN… 》弹出对话框 Network Connections 》选中刚配置的VPN 》 Edit… 》弹出对话框 Edting… Your-VPN 》 IPv4 Settings 》 Routes... 》

1. 添加一条route：子网地址，mask，网关，metric
  * 例如：
  Address：192.168.251.0   Netmask：255.255.255.0    Gateway：192.168.251.1    Metric：1
2. 勾选“Ignore automatically obtained routes”
3. 勾选“Use this connection only for resources on its network”




### 其他命令

```
$ route -n    命令显示当前的route表
```











