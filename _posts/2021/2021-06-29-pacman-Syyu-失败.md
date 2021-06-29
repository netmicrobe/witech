---
layout: post
title: pacman-Syyu-失败
categories: [ cm, linux ]
tags: [ manjaro ]
---

* 参考
  * []()
  * []()
  * []()
  * []()
---


### 报错： breaks dependency 'libcanberra=0.30+2+gc0620e4-3' required by libcanberra-gstreamer

~~~shell
$ sudo pacman -Syyu

:: Synchronizing package databases...
 core                       169.2 KiB  41.7 KiB/s 00:04 [##############################] 100%
 extra                     1925.2 KiB   349 KiB/s 00:06 [##############################] 100%
 community                    6.6 MiB   296 KiB/s 00:23 [##############################] 100%
 multilib                   178.2 KiB   180 KiB/s 00:01 [##############################] 100%
:: Starting full system upgrade...
:: Replace lib32-libcanberra-pulse with multilib/lib32-libcanberra? [Y/n] 
:: Replace libcanberra-pulse with extra/libcanberra? [Y/n] 
:: Replace qca with extra/qca-qt5? [Y/n] 
resolving dependencies...
looking for conflicting packages...
error: failed to prepare transaction (could not satisfy dependencies)
:: installing libcanberra (0.30+2+gc0620e4-4) breaks dependency 'libcanberra=0.30+2+gc0620e4-3' required by libcanberra-gstreamer
~~~

* **解决方法**

`libcanberra-gstreamer` 被从库里面移除了，所以报错。

把 `libcanberra-gstreamer` 卸载就可解决。

~~~shell
sudo pacman -Rs libcanberra-gstreamer
~~~

* 参考：
    * [reddit 2021-06-07 - Update is failing](https://www.reddit.com/r/archlinux/comments/nu2m3v/update_is_failing/)








































































