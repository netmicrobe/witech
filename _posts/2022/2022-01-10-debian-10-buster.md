---
layout: post
title: debian 10 / buster 使用
categories: [cm, linux]
tags: []
---

* 参考： 
    * [Debian官网](https://www.debian.org/)
    * []()
    * []()
    * []()
    * []()
    * []()


## Debian 10 下载

* [Debian CDs/DVDs archive](https://cdimage.debian.org/cdimage/archive/)
* [Debian 10.11.0](https://cdimage.debian.org/cdimage/archive/10.11.0-live/amd64/iso-hybrid/)
* [debian-live-10.11.0-amd64-xfce.iso 2.3G](https://cdimage.debian.org/cdimage/archive/10.11.0-live/amd64/iso-hybrid/debian-live-10.11.0-amd64-xfce.iso)
* []()






## Debian 9 上使用 FTP / vsftpd

* 参考
    * [How to Setup FTP Server with VSFTPD on Debian 9](https://linuxize.com/post/how-to-setup-ftp-server-with-vsftpd-on-debian-9/)
    * []()


1. 安装 vsftpd
    ~~~
    sudo apt update
    sudo apt install vsftpd

    # 查看是否已经启动
    sudo systemctl status vsftpd
    ~~~

1. 配置 `vsftpd.conf`
    `vi /etc/vsftpd.conf`
    ~~~
    listen=NO
    listen_ipv6=YES
    anonymous_enable=NO
    local_enable=YES
    write_enable=YES
    dirmessage_enable=YES
    use_localtime=YES
    xferlog_enable=YES
    connect_from_port_20=YES
    chroot_local_user=YES
    secure_chroot_dir=/var/run/vsftpd/empty
    pam_service_name=vsftpd
    
    # 不使用ssl
    #rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
    #rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
    ssl_enable=NO
    
    data_connection_timeout=12000
    user_sub_token=$USER
    local_root=/home/$USER/ftp
    pasv_min_port=30000
    pasv_max_port=31000
    userlist_enable=YES
    userlist_deny=NO
    userlist_file=/etc/vsftpd.user_list
    ~~~
1. 修改配置文件后，重启vsftpd ： `sudo systemctl restart vsftpd`
1. 配置防火墙
    ~~~
    sudo ufw allow 20:21/tcp
    sudo ufw allow 30000:31000/tcp

    # 开ssh的22端口
    sudo ufw allow OpenSSH

    # Reload the UFW rules
    sudo ufw disable
    sudo ufw enable
    ~~~
1. 创建FTP用户
    ~~~
    # 创建 /bin/ftponly 作为FTP用户的shell，禁止ftp用户使用shell
    echo -e '#!/bin/sh\necho "This account is limited to FTP access only."' | sudo tee -a  /bin/ftponly
    sudo chmod a+x /bin/ftponly

    # Append the new shell to the list of valid shells
    echo "/bin/ftponly" | sudo tee -a /etc/shells

    # 创建 FTP用户的HOME
    sudo mkdir -p /home/newftpuser/ftp/upload

    # 创建 FTP用户
    sudo useradd newftpuser -d /home/newftpuser  -s /bin/ftponly
    # 设置密码
    passwd newftpuser

    # 允许 FTP用户使用 vsftpd
    echo "newftpuser" | sudo tee -a /etc/vsftpd.user_list

    # 配置 FTP的目录
    sudo chown -R newftpuser: /home/newftpuser/ftp
    sudo chmod 550 /home/newftpuser/ftp
    sudo chmod 750 /home/newftpuser/ftp/upload
    ~~~
1. FTP客户端登录测试
    ~~~
    sudo apt install ftp
    ftp localhost
    # 按提示输入帐号并登录，如果能登录，说明安装设置正确
    ~~~
1. FTP客户端使用非加密登录
    1. 启动Filezilla \> New Site
    1. Host: your-ftp-server-ip
    1. Encryption: Only use plain FTP(insecure)
    1. 输入 User/Password 后点击连接







## Fix “sudo command not found”

* [Ubuntu/Debian — Fix “sudo command not found”](https://futurestud.io/tutorials/ubuntu-debian-fix-sudo-command-not-found)
* [debian中默认不存在sudo命令解决方法](https://blog.csdn.net/nierunjie/article/details/52435022)
* []()

~~~
su
apt-get install sudo
vim /etc/sudoers
# 添加 "your-username" ALL=(ALL) ALL
~~~


































