---
layout: post
title: linux上chrome无法启动telegram
categories: [cm, linux]
tags: []
---

* 参考： 
    * <https://www.reddit.com/r/ManjaroLinux/comments/k76cph/telegram_not_launching_from_the_browser_xdgopen/ghqt796?utm_source=share&utm_medium=web2x&context=3>
    * <https://www.reddit.com/r/ManjaroLinux/comments/k76cph/telegram_not_launching_from_the_browser_xdgopen/ghxryq0?utm_source=share&utm_medium=web2x&context=3>
    * []()

* 问题现象
        
    manjaro 下 chrome 中点击 telegram 连接，无法启动app，提示：

    ~~~
    Unable to create io-slave. klauncher said: Unknown protocol 'tg'.
    ~~~

* 解决方法一：**删除**用户空间中残次的 desktop 文件

    ~~~
    rm -i $(grep -l telegram ~/.local/share/applications/*.desktop)
    ~~~

    真正的正常的telegram的desktop文件是：`/usr/share/applications/telegramdesktop.desktop`


* 解决办法二： **修正**用户空间中残次的 desktop 文件

    1. 进入目录：`~/.local/share/applications`
    1. `grep -l telegram ~/.local/share/applications/*.desktop` 来发现用户空间中残次的 desktop 文件, 例如： `userapp-Telegram Desktop-FXJ6T0.desktop`
    1. 在desktop文件末尾添加： `MimeType=application/x-xdg-protocol-tg;x-scheme-handler/tg;`
    1. 重启浏览器




