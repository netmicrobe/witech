---
layout: post
title: ls命令color设置
categories: [cm, linux]
tags: [linux, color, ls, dircolors]
---



* 参考
    * <http://ubuntuforums.org/showthread.php?t=41538>
    * <http://linux.die.net/man/5/dir_colors>
    * [Configuring LS_COLORS](http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors)

## 查看当前ls命令输出颜色设置

```
echo $LS_COLORS
```



## 方法一： 利用 `$LS_COLORS` 变量设置ls输出颜色

1. 命令行执行 `echo $LS_COLORS` 了解当前颜色设置
1. 在命令行中修改 `$LS_COLORS` 变量进行颜色调试
    `export LS_COLORS=$LS_COLORS:"ow=34;41"` , 修改的是other-writable目录的颜色设置
1. 调试成功后，将设置写入 `.bashrc`





## 方法二： 利用 `.dircolors` 文件设置ls输出颜色

```
dircolors color-scheme-file
```

### 自定义ls输出颜色

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


## 设置定义

~~~
d = (BLOCK, BLK)   Block device (buffered) special file
cd = (CHAR, CHR)    Character device (unbuffered) special file
di = (DIR)  Directory
do = (DOOR) [Door][1]
ex = (EXEC) Executable file (ie. has 'x' set in permissions)
fi = (FILE) Normal file
ln = (SYMLINK, LINK, LNK)   Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
mi = (MISSING)  Non-existent file pointed to by a symbolic link (visible when you type ls -l)
no = (NORMAL, NORM) Normal (non-filename) text. Global default, although everything should be something
or = (ORPHAN)   Symbolic link pointing to an orphaned non-existent file
ow = (OTHER_WRITABLE)   Directory that is other-writable (o+w) and not sticky
pi = (FIFO, PIPE)   Named pipe (fifo file)
sg = (SETGID)   File that is setgid (g+s)
so = (SOCK) Socket file
st = (STICKY)   Directory with the sticky bit set (+t) and not other-writable
su = (SETUID)   File that is setuid (u+s)
tw = (STICKY_OTHER_WRITABLE)    Directory that is sticky and other-writable (+t,o+w)
*.extension =   Every file using this extension e.g. *.rpm = files with the ending .rpm
~~~



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

~~~
0   = default colour
1   = bold
4   = underlined
5   = flashing text
7   = reverse field
31  = red
32  = green
33  = orange
34  = blue
35  = purple
36  = cyan
37  = grey
40  = black background
41  = red background
42  = green background
43  = orange background
44  = blue background
45  = purple background
46  = cyan background
47  = grey background
90  = dark grey
91  = light red
92  = light green
93  = yellow
94  = light blue
95  = light purple
96  = turquoise
100 = dark grey background
101 = light red background
102 = light green background
103 = yellow background
104 = light blue background
105 = light purple background
106 = turquoise background
~~~

































