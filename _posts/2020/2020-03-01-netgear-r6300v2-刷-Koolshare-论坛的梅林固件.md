---
layout: post
title: 网件 netgear-r6300v2 刷 Koolshare 论坛的梅林固件
categories: [cm, router]
tags: [koolshare, merlin, 梅林, netgear]
---

* 参考
  * [coolshine - arm384梅林改版固件 - R6300v2重获新生！](https://koolshare.cn/thread-182286-1-1.html)
  * [R6300v2 386测试固件，V大版，无无软件中心](https://koolshare.cn/thread-190950-22-1.html)
  * [求解R7000和R6300V2组mesh问题](https://koolshare.cn/forum.php?mod=viewthread&tid=192754&highlight=r6300v2)
  * []()
  * []()
  * **固件下载**
  * [KoolShare 固件列表](http://firmware.koolshare.cn/)
  * [KoolShare 固件下载服务器 - Koolshare_RMerl_New_Gen_384 - NETGEAR R6300v2](https://firmware.koolshare.cn/Koolshare_RMerl_New_Gen_384/NETGEAR/R6300v2/)
  * [KoolShare 固件下载服务器 - Koolshare_RMerl_New_Gen_386 - NETGEAR R6300v2](https://firmware.koolshare.cn/Koolshare_RMerl_New_Gen_386/Netgear/R6300v2/)
  * []()


R6300v2从arm380升级到arm384固件会失去什么
1. WAN口变LAN 4口，LAN4口变WAN口，依次类推；
1. 除非刷回官方CFE否则无法刷任何官方固件或者380梅林/Tomato/DD固件，也不能直接刷AC68U固件；
1. 基本上拥有其它armv7l机型的所有功能，也失去了它们升级到384时失去的所有功能；
1. arm384固件的首页没有温度、网速等信息的状态显示；
1. arm384固件的内存占用率将会比arm380系列高得多；



1. 下载所需要的所有文件
    包括mtd-write，cfe_r6300v2_qin.bin，CFEEdit.exe，RT-AC6300V2_384.17_0-20200522.trx，R6300V2_380.70_0-X7.9-koolshare.trx，等所需文件，如果当前R6300v2已经是380梅林固件则无需再下载R6300V2_380.70_0-X7.9-koolshare.trx

1. 开启ssh
    在【系统管理】-【系统设置】内，开启ssh，设置LAN only即可，此时R6300v2请断开除了刷机电脑之外的任何网络连接，包括WAN口，同时，建议将R6300v2的LAN口网段设置为192.168.1.1，以避免不必要的麻烦（尤其是刷了CFE之后重启时）

1. 使用路由器mac地址修改cfe
    打开Windows电脑，使用CFEEdit.exe修改mac地址和secret_code，请根据自己路由器的mac更改，改完之后，仍然另存为cfe_r6300v2_qin.bin

    假设 R6300v3 mac地址为： `10:DA:43:D6:5D:92`
    需要将mac前3个字节改为asus的厂家地址标识，也就是： `10:BF:48:D6:5D:92`
    修改cfe文件，`et0macaddr` 和 `0:macaddr` 等于 mac地址，`1:macaddr` = `0:macaddr` + 4
    也就是：
    ~~~
    et0macaddr=10:BF:48:D6:5D:92
    0:macaddr=10:BF:48:D6:5D:92
    1:macaddr=10:BF:48:D6:5D:96
    ~~~



1. Windows用户使用winscp将mtd-write，cfe_r6300v2_qin.bin上传至路由器，假设放在了/tmp/home/root目录
1. sh登录380梅林固件系统，软件windows下推荐使用putty，mac或者linux下不推荐想必板油也知道，执行以下命令(一定要执行nvram erase!一定要执行nvram erase!一定要执行nvram erase!)，有能力的板油可以备份自己的CFE，不备份也没事，反正刷CFE要么挂了得找硬件维修，不挂的话原版cfe似乎也没啥吸引力了吧...
    ~~~
    nvram erase
    cd /tmp/home/root
    chmod +x mtd-write
    ./mtd-write -i cfe_r6300v2_qin.bin -d boot
    ~~~
1. 刷CFE完成后，手动断电路由器，然后开机启动时按住WPS后打开电源，并按住WPS 10秒钟 ，这个时候应该可以看到电源灯闪烁，然后断开电源，如果没有外接TTL，那么按住WPS看到电源灯闪烁是刷CFE成功的重要标志；
1. 用有线将电脑通过网线连接至R6300v2路由器的LAN2或者LAN3口，手动设置网卡的地址为192.168.1.100
1. 按住 Reset按钮并上电，按住Reset按钮不松开，观察ping的命令行，如果看到有返回并且ttl=100，那么就此时CFE就处在tftp server模式下了，此时需要通过自带的tftp工具将384改版固件刷到路由器，注意这里是用系统自带的tftp工具刷384改版固件！用系统自带的tftp工具刷384改版固件！用系统自带的tftp工具刷384改版固件！这个时候由于CFE已经刷好了，实际上R6300v2就已经被认为是RT-AC66U_B1了！
1. Windows系统需要先打开自带的tftp工具然后打开powershell或者cmd通过命令刷入，然后按照如下指令（假设固件放在Downloads文件夹下）：
    ~~~
    cd Downloads
    tftp -i 192.168.1.1 PUT RT-AC6300V2_384.17_0-20200522.trx
    # 这里也要等待一段时间，比较长，要有耐心，此时如果打开资源管理器可以看到正在上传，只是tftp速度很慢(2Mbps大约）
    # 然后会等到成功的通知
    Transfer successful: 37122048 bytes in 160 second(s), 232012 bytes/s
    ~~~
    Mac电脑由于自带tftp软件，所以用起来很简单的，用如下命令就能刷入：
    ~~~
    $ tftp
    tftp> connect 192.168.1.1
    tftp> binary
    tftp> rexmt 1
    # 下面这一步会需要比较长的时间，请耐心等待，直到后面的"Sent 37126144 bytes in 169.5 seconds"出现然后再退出
    tftp> put RT-AC6300V2_384.17_0-20200522.trx
    Sent 37126144 bytes in 169.5 seconds
    tftp> q
    $
    ~~~
1. 通过tftp的方式刷完机之后，略微等待30秒钟，如果没发现R6300v2在重启（表现为logo灯亮然后灭），那么手动断电并重新上电，然后继续等待，此时会重启大约3次，花费1分钟到3分钟时间不等；
1. 清空浏览器缓存，将电脑的网卡设置为自动获取IP，然后等待R6300v2哦不是RT-AC6300v2 :-P（对楼主就是这么调皮） 启动！如果浏览器中输入192.168.1.1能打开网页，看到 `Welcome to RT-AC66U B1`，那么恭喜你，你成功了！
1. 




























