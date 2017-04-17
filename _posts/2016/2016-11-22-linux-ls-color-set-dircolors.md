---
layout: post
title: ls命令color设置
categories: [cm, linux]
tags: [linux, color, ls, dircolors]
---

## 查看当前ls命令输出颜色设置

```
echo $LS_COLORS
```

## 利用文件设置ls输出颜色

```
dircolors color-scheme-file
```

## 自定义ls输出颜色

```
dircolors -p > .dircolors
```

将当前颜色设置打印到.dirycolors文件。

修改.dircolors

在.bashrc 中执行dircolors ~/.dircolors，一般.bashrc都已经包含了如下设置：

```
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
```




## 颜色定义


ISO 6429 color sequences are composed of sequences of numbers separated by semicolons. The most common codes are:

```
 0     to restore default color
 1     for brighter colors
 4     for underlined text
 5     for flashing text
30     for black foreground
31     for red foreground
32     for green foreground
33     for yellow (or brown) foreground
34     for blue foreground
35     for purple foreground
36     for cyan foreground
37     for white (or gray) foreground
40     for black background
41     for red background
42     for green background
43     for yellow (or brown) background
44     for blue background
45     for purple background
46     for cyan background
47     for white (or gray) background
```




## 参考

<http://ubuntuforums.org/showthread.php?t=41538>
<http://linux.die.net/man/5/dir_colors>
































