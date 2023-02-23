---
layout: post
title: httpcanary-抓包，关联 
categories: [ ]
tags: []
---

* 参考
  * [Android11小黄鸟安装CA证书以及解决抓包没网问题](https://blog.csdn.net/qq_42923605/article/details/123687798)
  * []()
  * []()
  * []()
  * []()
  * []()


## 安装CA证书

环境： lineageOS 19 / Android 12
httpcanary: 3.3.5

1. 没有CA证书，会看到 设置》httpCanary根证书 》显示：未安装，无法抓取SSL/TLS加密数据包
1. root shell 中操作拷贝下证书文件
    ~~~sh
    adb root
    adb shell
    cd  /data/data/com.guoshi.httpcanary/cache/ 
    cp HttpCanary.pem HttpCanary.jks
    ~~~
1. 重启httpcanary ，设置》httpCanary根证书，就会发现证书已经安装了
1. 设置》httpCanary根证书 》导出HttpCanary根证书 》选择到处类型 System Trusted(.0) 》导出的证书拷贝到系统证书的目录：
    ~~~sh
    cd /sdcard/HttpCanary/certs
    mount -o remount,rw /
    cp 87bc3517.0 /etc/security/cacerts/
    ~~~
1. **未完待续**
    https 的数据包还是无法抓包，提示：
    ~~~
    异常信息
    Read error: ssl=0x7c8ff0fa98: Failure in SSL library, usually a protocol error
    error: 10000416:SSL routines: OPENSSL_internal:SSLV3_ALERT_CERTIFICATE_UNKNOWN(external/boringssl/src/ssl/tls_record.cc:594 0x7caff09098:0x00000001)

    异常原因
    目标App使用了固定证书，无法直接抓包

    解决方案
    使用Xposed模块JustTrustMe解除证书固定
    ~~~
    1. 
1. 
1. 
1. 















