---
layout: post
title: 2021-10-28-远程访问manjaro（ssh、远程桌面）
categories: [cm, linux]
tags: [rdp, remmina, remote-desktop]
---

* 参考： 
    * [archlinux - xrdp](https://wiki.archlinux.org/title/xrdp)
    * 针对CentOS [How to Setup Xrdp over Xorg in Linux with Multi Sessions](https://linuxways.net/centos/how-to-setup-xrdp-over-xorg-in-linux-with-multi-sessions/)
    * []()
    * []()


## SSH to Manjaro

* 参考
  * [How to Enable SSH Service in Manjaro Linux](https://tuxfixer.com/configure-ssh-service-in-manjaro-linux/)
  * []()

~~~
sudo pacman -S openssh

sudo systemctl status sshd.service
sudo systemctl enable sshd.service
sudo systemctl start sshd.service
~~~



## Remote Desktop to Manjaro

* 参考： 
    * [archlinux - xrdp](https://wiki.archlinux.org/title/xrdp)
    * []()



~~~
yay -S xrdp
~~~

如果报错：`Error: Cannot find the strip binary required for object file stripping`
安装下编译工具： `pacman -Sy base-devel`


~~~
rdesktop -r sound:local -P 192.168.1.199
~~~
连接报错： 
~~~
Clipboard(error): xclip_handle_SelectionNotify(), unable to find a textual target to satisfy RDP clipboard text request
disconnect: Unknown reason.
~~~

`sudo tail -f /var/log/xrdp-sesman.log` xrdp 服务器log

~~~
[20211029-01:18:31] [INFO ] Socket 8: AF_INET6 connection received from ::1 port 58224
[20211029-01:18:31] [INFO ] Terminal Server Users group is disabled, allowing authentication
[20211029-01:18:31] [INFO ] ++ created session (access granted): username wi, ip ::ffff:192.168.1.188:38410 - socket: 12
[20211029-01:18:31] [INFO ] starting Xorg session...
[20211029-01:18:31] [INFO ] Starting session: session_pid 906, display :10.0, width 1024, height 768, bpp 24, client ip ::ffff:192.168.1.188:38410 - socket: 12, user name wi
[20211029-01:18:31] [INFO ] [session start] (display 10): calling auth_start_session from pid 906
[20211029-01:18:31] [ERROR] sesman_data_in: scp_process_msg failed
[20211029-01:18:31] [ERROR] sesman_main_loop: trans_check_wait_objs failed, removing trans
[20211029-01:18:31] [INFO ] Starting X server on display 10: /usr/lib/Xorg :10 -auth .Xauthority -config xrdp/xorg.conf -noreset -nolisten tcp -logfile .xorgxrdp.%s.log  
[20211029-01:18:32] [INFO ] Found X server running at /tmp/.X11-unix/X10
[20211029-01:18:32] [INFO ] Found X server running at /tmp/.X11-unix/X10
[20211029-01:18:32] [INFO ] Session started successfully for user wi on display 10
[20211029-01:18:32] [INFO ] Found X server running at /tmp/.X11-unix/X10
[20211029-01:18:32] [INFO ] Starting the xrdp channel server for display 10
[20211029-01:18:32] [INFO ] Session in progress on display 10, waiting until the window manager (pid 907) exits to end the session
[20211029-01:18:32] [INFO ] Starting the default window manager on display 10: /etc/xrdp/startwm.sh
[20211029-01:18:32] [WARN ] Window manager (pid 907, display 10) exited quickly (0 secs). This could indicate a window manager config problem
[20211029-01:18:32] [INFO ] Calling auth_stop_session and auth_end from pid 906
[20211029-01:18:32] [INFO ] Terminating X server (pid 908) on display 10
[20211029-01:18:32] [INFO ] Terminating the xrdp channel server (pid 912) on display 10
[20211029-01:18:32] [INFO ] X server on display 10 (pid 908) returned exit code 0 and signal number 0
[20211029-01:18:32] [INFO ] xrdp channel server for display 10 (pid 912) exit code 0 and signal number 0
[20211029-01:18:32] [INFO ] cleanup_sockets:
[20211029-01:18:32] [INFO ] ++ terminated session:  username wi, display :10.0, session_pid 906, ip ::ffff:192.168.1.188:38410 - socket: 12
~~~



















































































