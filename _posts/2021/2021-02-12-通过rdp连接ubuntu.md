---
layout: post
title: 通过rdp连接ubuntu
categories: [cm, linux]
tags: [rdp, remmina, remote-desktop]
---

* 参考： 
    * [如何在Ubuntu 20.04 上安装 Xrdp 服务器（远程桌面）](https://yq.aliyun.com/articles/762186)
    * []()
    * []()
    * []()
    * []()

1. 安装配置xrdp
    ~~~
    sudo apt install xrdp 

    # 一旦安装完成，Xrdp 服务将会自动启动。
    sudo systemctl status xrdp

    # 默认情况下，Xrdp 使用/etc/ssl/private/ssl-cert-snakeoil.key,它仅仅对“ssl-cert” 用户组成语可读。运行下面的命令，将xrdp用户添加到这个用户组：
    sudo adduser your-account ssl-cert  

    # 重启 Xrdp 服务，使得修改生效：
    sudo systemctl restart xrdp
    ~~~

1. 使用Remmina登录目标ubuntu



### 登录VMWare上的Ubuntu

~~~
remmina_file_save) - We have a password and disablepasswordstoring=0
(remmina_file_save) - Profile saved
(rco_on_connect) - Trying to present the window
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
(remmina_rdp_event_on_clipboard) - owner-change event received
(remmina_rdp_event_on_clipboard) -      new owner is different than me: new=(nil) me=0x559f7d914640. Sending local clipboard format list to server.
(remmina_rdp_cliprdr_get_client_format_list) - Sending to server the following local clipboard content formats
(remmina_rdp_cliprdr_get_client_format_list) -      local clipboard format UTF8_STRING will be sent to remote as 13
(remmina_rdp_cliprdr_get_client_format_list) -      local clipboard format TEXT will be sent to remote as 1
(remmina_rdp_cliprdr_get_client_format_list) -      local clipboard format text/plain;charset=utf-8 will be sent to remote as 13
(remmina_rdp_cliprdr_get_client_format_list) -      local clipboard format text/plain will be sent to remote as 1
(rmnews_periodic_check) - remmina_pref.periodic_news_permitted is 0
~~~
