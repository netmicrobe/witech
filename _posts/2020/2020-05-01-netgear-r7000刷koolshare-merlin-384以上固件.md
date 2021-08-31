---
layout: post
title: 网件 R7000 刷 Koolshare 论坛的384以上梅林固件
categories: [cm, router]
tags: [gfw, shadowsocks, koolshare, merlin, 梅林, netgear]
---

* 参考
  * [R7000刷AC68U_386.1_0成功](https://koolshare.cn/thread-193018-1-1.html)
  * [R7000刷带软件中心和AIMESH的386固件图文教程](https://koolshare.cn/thread-193031-1-1.html)
  * [R7000_386.2_4 固件](https://koolshare.cn/thread-194858-1-1.html)
  * [【2021-02-14】Netgear R7000路由器的Asuswrt-ASUS固件更新R7000_386.1_2](https://koolshare.cn/thread-192540-1-1.html)
  * [Koolshare_RMerl_New_Gen_384 - RT-AC68U 固件 - 刷CFE之后的R7000可以用](http://firmware.koolshare.cn/Koolshare_RMerl_New_Gen_384/RT-AC68U/)
  * [Koolshare_RMerl_New_Gen_386 - RT-AC68U - 刷CFE之后的R7000可以用](http://firmware.koolshare.cn/Koolshare_RMerl_New_Gen_386/RT-AC68U/)
  * []()
  * []()
  * []()
  * []()




## 刷 梅林 384、386 固件

384的好处是，支持AiMesh。

### 版本和Bug

2021.3.8  BUG反馈：USB2.0无法使用！！！USB3.0正常
2021.3.17 更新CFE_R7000_386_27DB.bin，更新内容如下：
                 * 2.4G和5G发射功率均提升为27db
                 * 解决双红叉问题。
2021.05.05 386系统下，无法使用mtd-write刷CFE，必须回384或者380；
                   但是前几天爬文的时候发现，有个网友说可以用dd命令，我尝试了两台机器，一台是DIR868L一台R6700，
                   均成功刷进，步骤就是上传新的CFE到/tmp目录，然后输入
                   dd if=/tmp/CFE_new of=/dev/mtd0      接着输入nvram erase       然后reboot就行。
                   注意：刷CFE有风险，dd命令是不做验证的，你的CFE不管对错，都会被刷进去！！！
                   所以个人建议最好还是回384刷CFE比较保险。



### 相关工具

链接： https://pan.baidu.com/s/1gRgljocNi1A6QO71X_dgeg
提取码： dy94



### 刷机步骤

1. 将R7000先刷成梅林 380 版本，成功后，开启ssh服务
1. 备份当前CFE
    ssh登陆后执行 `dd if=/dev/mtd0 of=/tmp/boot.bin`，将boot.bin 备份到本地。
1. 修改CFE中的Mac地址
1. 用CFEEDIT这个软件打开CFE_R7000_386.bin，需要修改里面的MAC地址和机器型号信息，如下：

    注意：这里不要修改这三个MAC地址的前6位，不然会导致AIMESH搜索不到节点！！！！！！

    ~~~
    et0macaddr       --> 后六位替换成路由器的mac地址
    0:macaddr        --> 后六位替换成路由器的mac地址
    1:macaddr        --> 后六位替换成路由器mac地址+4
    修改完后的CFE另存为一个，这里以CFE_R7000_386_0000.bin为例。
    ~~~
1. SCP把mtd-write和CFE_R7000_386_0000.bin上传到路由器的/tmp目录下。
1. 刷入新的CFE。
    ~~~
    cd /tmp
    chmod 755 mtd-write
    ./mtd-write -i CFE_R7000_386_0000.bin -d boot
    ~~~
1. 刷入成功后，输入reboot，回车，
1. 要先naram恢复一下：关机后，长按`wps`键，按住WPS看到电源灯闪烁是刷CFE成功的重要标志；
1. 等待一会重启，然后再关机，长按reset，重启，直到TTL=100出现5次。
     这里需要注意下，有可能是192.168.50.1通也有可能是192.168.1.1通，这里假设是192.168.50.1通。
1. 打开web浏览器，输入192.168.50.1，会弹出miniweb界面，这个时候基本就成功了。如果没出现，不用紧张，关闭电源，按住reset，通电，重新来一次，TTL=100五次以后松开，就可以进入了。
    ![](miniweb-ui.png)
1. 先点 `restore default NVRAM values`，然后上传RT-AC68U_386.2_2_koolshare.trx，静静等着上传完成的提示。
    ![](upload-complete.png)
1. 等路由器自动重启完成后，进入，检查下AIMESH和软件中心，都正常的话就成功了，以后也可以直接正常升级AC68U的固件。
1. 
1. 
1. 


























