---
layout: post
title: 设置命令行提示符的颜色和标题 prompt color PS1 title
categories: [cm, linux]
tags: [linux, PS1, prompt, centos]
---

## 设置命令行提示符的颜色 

在.bashrc中设置PS1的变量值即可。 

### 例子1，红色提示符

```
export PS1="\[\e[31;1m\][ \u@\H: \w ] \\$ \[\e[m\]"
```

* 说明，\H 要优于 \h，在 hostname 为 IP 时， 例如，192.168.10.100， \h 只能显示 192 （到 . 就结束）；而 \H 显示全部IP地址。

效果：

<div class="highlight">
<font color="red">[ username@localhost: /etc ] $ </font>
</div>


### 例子2，浅绿色提示符

```
export PS1="\[\e[32;1m\]\u@\H: \w \\$ \[\e[m\]"
```

效果：

<div class="highlight">
<font color="lightgreen">username@localhost: /etc $ </font>
</div>


```
\[\e[32;1m\]中间的文字是浅绿色，适合深色背景的console\[\e[m\]
\u    user name 
\h    host name 
\w   Current absolute path. Use \W for current relative path. 
\$ - The prompt character (eg. '#' for root, '$' for regular users).
```

## 如何在 CentOS6 修改全局提示符PS1

在 /etc/profile.d 中创建文件 custom.sh

```
if [ "$PS1" ]; then
  PS1="\[\e[32;1m\]\u@\h: \w \\$ \[\e[m\]"
fi
```

## 设置命令行窗口标题

在上述 $PS1 内容前，还可以加上 

```
\e]0;Title\a
或
\[\e]0;Title\a\]\n
```

来设置命令行窗口的标题。

* 例如

```
# 标题只显示固定文字
export PS1="\e]0;Title\a\[\e[31;1m\][ \u@\h: \w ] \\$ \[\e[m\]"
或者，标题显示用户，hostname，目录
export PS1="\[\e]0;\u@\H\a\]\n\[\e[31;1m\][ \u@\H: \w ] \\$ \[\e[m\]"
```

## 如何设置命令行提示符显示正确IP，而不是127.0.0.1

* 参考： <https://superuser.com/questions/668174/how-can-you-display-host-ip-address-in-bash-prompt>

例子

```shell
# Terminal Prompt style
THEIP=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
export PS1="\[\e]0;\u@"$THEIP"\a\]\n\[\e[31;1m\][ \u@"$THEIP": \w ] \$ \[\e[m\]"

```

## 参考： 

* <https://wiki.archlinux.org/index.php/Color_Bash_Prompt >
* <https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html>

### 颜色表

```
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

```

### Bash Prompt Escape Sequences

```
When  executing  interactively,  bash displays the primary
prompt PS1 when it is ready to read  a  command,  and  the
secondary  prompt PS2 when it needs more input to complete
a command.  Bash allows these prompt strings  to  be  cus­
tomized by inserting a number of backslash-escaped special
characters that are decoded as follows:
      \a     an ASCII bell character (07)
      \d     the date  in  "Weekday  Month  Date"  format
             (e.g., "Tue May 26")
      \e     an ASCII escape character (033)
      \h     the hostname up to the first `.'
      \H     the hostname
      \j     the  number of jobs currently managed by the
             shell
      \l     the basename of the shell's terminal  device
             name
      \n     newline
      \r     carriage return
      \s     the  name  of  the shell, the basename of $0
             (the portion following the final slash)
      \t     the current time in 24-hour HH:MM:SS format
      \T     the current time in 12-hour HH:MM:SS format
      \@     the current time in 12-hour am/pm format
      \u     the username of the current user
      \v     the version of bash (e.g., 2.00)
      \V     the release of bash,  version  +  patchlevel
             (e.g., 2.00.0)
      \w     the current working directory
      \W     the  basename  of the current working direc­
             tory
      \!     the history number of this command
      \#     the command number of this command
      \$     if the effective UID is 0, a #, otherwise  a
             $
      \nnn   the  character  corresponding  to  the octal
             number nnn
      \\     a backslash
      \[     begin a sequence of non-printing characters,
             which could be used to embed a terminal con­
             trol sequence into the prompt
      \]     end a sequence of non-printing characters
```