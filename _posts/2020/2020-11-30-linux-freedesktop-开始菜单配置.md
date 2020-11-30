---
layout: post
title: 2020-11-30-linux-freedesktop-开始菜单配置
categories: [cm, linux]
tags: [desktop, GUI]
---

* 参考： 
  * [freedesktop.org - Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html)
  * [freedesktop.org - Icon Theme Specification](https://freedesktop.org/wiki/Specifications/icon-theme-spec/)
  * [gnome.org - Desktop files: putting your application in the desktop menus](https://developer.gnome.org/integration-guide/stable/desktop-files.html.en)
  * [gnome.org - Desktop Entry Specification](https://developer.gnome.org/desktop-entry-spec/)
  * []()


## Desktop Entry

### Desktop Entry 示例

~~~
$ cat /usr/share/applications/xmind.desktop
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=xmind8
Comment=mindmap tool
Icon=/opt/xmind/xmind.256.png
Exec=/opt/xmind/xmind-8-update8-linux/XMind_amd64/XMind %F
Path=/opt/xmind/xmind-8-update8-linux/XMind_amd64
Terminal=false
Categories=Office;Productivity;Development;X-XFCE;X-Xfce-Toplevel;
MimeType=application/vnd.xmind.workbook;
~~~




## Icon

icon 可能的位置：

* `$HOME/.icons`
* `/usr/share/icons`
* `$XDG_DATA_DIRS`
* `/usr/share/pixmaps`


