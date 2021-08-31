---
layout: post
title: 网件 R7000 刷 Koolshare 论坛的梅林固件
categories: [cm, router]
tags: [gfw, shadowsocks, koolshare, merlin, 梅林, netgear]
---

* 参考
  * [[固件发布] 【网件系列】【20180927】380.70_0-X7.9.1 固件发布 ](https://koolshare.cn/thread-139324-1-1.html)
  * [KoolShare 固件下载服务器 - Netgear/R7000/](http://firmware.koolshare.cn/Koolshare_Merlin_Legacy_380/Netgear/R7000/)
  * [X7.9 - 过度固件(chk)/OFW固件(trx)下载](http://firmware.koolshare.cn/Koolshare_Merlin_Legacy_380/Netgear/)
  * [KoolShare 固件列表](http://firmware.koolshare.cn/)




##【网件原厂】刷【koolshare改版固件】 380及之前版本  （测试可用，安全刷机）

1. 在原厂固件升级页面（Advanced -\> Administration -\> Router Update）下直接上传.chk后缀的过度固件，本帖下方提供；
    .chk 刷机后重启有点慢，不行关闭电源再打开试试。
1. 过渡固件刷好后，会停留在设置向导页面，点击“跳过设置向导”
1. 在过度固件里恢复一次出厂设置后，在固件更新也没，上传 `.trx` 后缀的koolshare改版固件（如果chk版本和trx版本一致则不需要，跳到第三步）；
1. 等待刷机完成后，在【系统管理】 – 【系统设置】内勾选：Format JFFS partition at next boot（下次重启格式化jffs分区） 和 Enable JFFS custom scripts and configs（开启jffs自定义脚本），点击应用本页面设置，成功应用后重启路由器；
1. 重启完成后，确保路由器连上网络，然后进入软件中心，首先点击更新按钮，将更新软件中心到最新版本，然后即可安装并使用插件。


【koolshare改版固件/梅林原版固件】刷【koolshare改版固件】：

1. 在梅林固件升级页面下直接上传.trx后缀的固件，本帖下方提供；
1. 从X7.x系列升级X7.9，不需要清空配置和格式化jffs分区；
1. 从X7.x系列升级X7.9.1，不需要清空配置和格式化jffs分区，skipdv1数据库会自动升级为skipdv3；
1. 从X7.9.1降级为X7.x，不需要清空配置，但需要格式化jffs分区
1. 从X7.9.1降级为X6.x，需要清空配置并格式化jffs分区
1. 从X6.x系列升级X7.9/X7.9.1，需要清除路由器配置和格式化jffs分区；
1. 如果升级后界面有问题，尝试清除浏览器缓存或者强制刷新（ctrl + F5）一次


## 刷 梅林 384、386 固件（要刷CFE，伪装成RT-AC68U，风险高，没试过）

384的好处是，支持AiMesh。

* [R7000刷AC68U_386.1_0成功](https://koolshare.cn/thread-193018-1-1.html)
* []()
* []()
* []()




## 梅林固件设置

### 无线网设置

* 参考：
  * <https://www.chiphell.com/thread-1415465-1-1.html>

*关于2.4G:有设备搜不到2.4G信号，此时请检查无线设置中的2.4G信号，信道设置在13可能会造成部分设备无法搜索到信号，通常建议使用1或6信道。此外，频道带宽也有可能影响信号的搜索，在不确定设备支持情况时请使用20Mhz，保证最大兼容。注意，此时2.4G的连接速率会比40Mhz低一半。
*关于5G:有支持5G的设备设备搜不到5G信号。部分用户购买的国际版手机可能工作在国内不支持的信道。遇到此类问题，请不要把信道设置为36-64；一般情况下正常终端应该都会支持149-165，您可以尝试将信道设置在此范围内然后再试

1. 关闭WPS ： 高级设置 》无线网络 》WPS 》启用WPS 》OFF
1. 设置2.4G/5G网络 ： 高级设置 》无线网络 》一般设置
    * 启动Smart Connect ： OFF
    * SSID ： 自己取个名字
    * 无线模式： 自动
    * 频道带宽： 20/40/80MHz  （80MHz速度最快，但是覆盖范围就低啦，20MHz就是2.4G的频段）
    * 频道： 157
      36信道 是 2.4G，不要把信道设置为36-64。
      一般情况下正常终端应该都会支持149-165，153-157信号一般速率都能达到867Mbps以上，有需要高速接入的，就必须把信道设定为153或157这样的高频信号。
    * 扩展频道：自动
    * 授权方式： WPA2-Personal
    * WPA加密：AES
    * 受保护的管理帧：停用
    * WPA群组密钥转动间隔： 3600
1. 高级设置 》无线网络 》专业设置
    * 地区： All Area
1. 
1. 
1. 
1. 

* 改一个wifi设置都要重启，重启很慢，但是，设置完啦很爽，刷满带宽。




## dd-wrt

### 从 DD-wrt 刷回原厂固件

* [原厂固件下载地址](https://www.netgear.com/support/product/R7000.aspx)
* [tweaking4all - NetGear R7000 – How to install DD-WRT …](https://www.tweaking4all.com/hardware/netgear-r7000-dd-wrt/)


1. 登陆DD-WRT管理页面 》Administration 》Firmware Upgrade 》选择 chk 固件文件 》点击 Upgrade
1. 等10分钟左右刷机完毕。
1. 关机。开机。指示灯显示正常。用回行针插进reset孔，30秒松开，路由器自动重启。
1. 指示灯显示正常，将网线插入LAN口，对应指示灯显示白色，说明启动正常。
1. 浏览器输入 192.168.1.1 进行登陆。会要求设置admin密码。

我从 `DD-WRT v3.0-r40189 std 07/04/19` 刷回 `R7000-V1.0.9.88_10.2.88` 成功。


































