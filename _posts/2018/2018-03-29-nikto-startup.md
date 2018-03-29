---
layout: post
title: nikto 进行web安全扫描
categories: [ security, web ]
tags: [ nikto ]
---

* 参考
  * [Nikto v2.1.5 - The Manual](https://cirt.net/nikto2-docs/)
  * [Github - Nikto](https://github.com/sullo/nikto)
  * <https://yq.aliyun.com/articles/132354>
  * <https://blog.csdn.net/fly_heart_yuan/article/details/6799043>
  * <https://blog.csdn.net/heimian/article/details/6954462>
  * <https://blog.csdn.net/kali3426/article/details/78883159>

## 安装 nikto

### 安装 perl

centos 6.8 默认的 Perl 5.10 不行，报错 ERROR: Required module not found: Time::HiRes
安装了最新的 Perl 5.26 可以运行

### 安装 libwhisker

~~~
wget https://10gbps-io.dl.sourceforge.net/project/whisker/libwhisker/2.5/libwhisker2-2.5.tar.gz
tar xzf libwhisker2-2.5.tar.gz
mkdir /usr/local/share/perl5
cd libwhisker2-2.5
perl Makefile.pl install
~~~

### 下载nikto

~~~
git clone https://github.com/sullo/nikto.git
~~~


## 执行 nikto

~~~
cd nikto
perl program/nikto.pl -h 192.168.1.100 -p 8080
~~~

* 执行结果示例：

~~~
root@vbcent68x32: /opt/nikto/program # perl nikto.pl -h 192.168.1.100 -p 8080
- ***** SSL support not available (see docs for SSL install) *****
- Nikto v2.1.6
---------------------------------------------------------------------------
+ Target IP:          192.168.1.100
+ Target Hostname:    192.168.1.100
+ Target Port:        8080
---------------------------------------------------------------------------
+ SSL Info:        Subject:
                   Ciphers:
                   Issuer:
+ Start Time:         2018-03-28 16:08:56 (GMT8)
---------------------------------------------------------------------------
+ Server: nginx/1.12.2 + Phusion Passenger 5.2.0
+ Cookie _redmine_session created without the secure flag
+ Retrieved x-powered-by header: Phusion Passenger 5.2.0
+ Uncommon header 'x-runtime' found, with contents: 0.032617
+ Uncommon header 'x-request-id' found, with contents: 5d492c2c-93fa-4aa1-8073-1cc8f360014a
+ The site uses SSL and the Strict-Transport-Security HTTP header is not defined.
+ No CGI Directories found (use '-C all' to force check all possible dirs)
+ Entry '/issues/gantt/' in robots.txt returned a non-forbidden or redirect HTTP code (200)
+ Entry '/issues/calendar/' in robots.txt returned a non-forbidden or redirect HTTP code (200)
+ Entry '/activity/' in robots.txt returned a non-forbidden or redirect HTTP code (200)
+ Entry '/search/' in robots.txt returned a non-forbidden or redirect HTTP code (200)
+ "robots.txt" contains 4 entries which should be manually viewed.
+ Server banner has changed from 'nginx/1.12.2 + Phusion Passenger 5.2.0' to 'nginx/1.12.2' which may suggest a WAF, load balancer or proxy is in place
+ Hostname '192.168.56.99' does not match certificate's names:
+ OSVDB-112004: /login.cgi: Site appears vulnerable to the 'shellshock' vulnerability (http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-6278).
+ OSVDB-112004: /login.php: Site appears vulnerable to the 'shellshock' vulnerability (http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-6278).
+ OSVDB-112004: /login.pl: Site appears vulnerable to the 'shellshock' vulnerability (http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-6278).
+ OSVDB-3092: /login/: This might be interesting...
+ OSVDB-3092: /news: This might be interesting...
+ OSVDB-3093: /login.php3?reason=chpass2%20: This might be interesting... has been seen in web logs from an unknown scanner.
+ /login.asp: Admin login page/section found.
+ /login.html: Admin login page/section found.
+ /login.php: Admin login page/section found.
+ 7831 requests: 0 error(s) and 20 item(s) reported on remote host
+ End Time:           2018-03-28 16:10:27 (GMT8) (91 seconds)
---------------------------------------------------------------------------
+ 1 host(s) tested

~~~


### 生成 html 报告

~~~
perl nikto.pl -h xxxx -o result.html -F html
~~~

### 扫描过程信息查看

扫描过程中
* 摁`v`显示详细扫描信息
* 摁`d`显示更加详细的扫描信息
* 摁`e`显示错误信息
* 摁`p`显示进度
