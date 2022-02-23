---
layout: post
title: linux-配置变量，扩展-PATH变量
categories: [cm, linux]
tags: [mint, debian, ubuntu]
---

* 参考： 
  * [help.ubuntu.com - EnvironmentVariables](https://help.ubuntu.com/community/EnvironmentVariables)
  * []()
  * []()
  * []()


## Ubuntu 系

### 影响所有用户 / System-wide environment variables：

* `/etc/profile.d/*.sh`
  每启动一个login shell，就会执行下这些shell script。
  例如，创建一个自定义的变量文件 `/etc/profile.d/myenvvars.sh`：
  ~~~bash
  export JAVA_HOME=/usr/lib/jvm/jdk1.7.0
  export PATH=$PATH:$JAVA_HOME/bin
  ~~~

* `/etc/profile`
  一般不直接修改，还是推荐在 `/etc/profile.d/` 创建shell script。
* `/etc/default/locale`
  特别为 locale 环境变量设置的文件，给 Language Support 程序用的，一般不要手动修改。
* `/etc/bash.bashrc`
  对命令行程序起效果，可能对GUI程序没效果。


* `/etc/environment`
  不是一个脚本文件，一行一个变量，无法对已设置的变量，进行扩展。
  ~~~
  FOO=bar
  ~~~


### 影响当前用户 / Session-wide environment variables：

* `~/.profile`
  ~~~bash
  export FOO=bar
  export PATH="$PATH:$HOME/MyPrograms"
  ~~~


* `~/.bashrc` , `~/.bash_profile`, `~/.bash_login`
  和 `~/.profile` 差不多，但是在这些文件设置的变量，可能对GUI程序没效果。


* `~/.pam_environment`
  不是一个脚本文件，就是为了设置变量的，一行一个变量，修改PATH变量，和脚本语法也不一样。
  有些变量，像 HOME，在 `~/.pam_environment` 解析的时候，还没设置。。。
  这个文件，一般用来设置语言、时间格式之类GUI配置，而且会被GUI设置程序给覆盖掉。
  还是使用 `~/.profile` 方便些。
  ~~~
  FOO=bar
  PATH DEFAULT=${PATH}:/home/@{PAM_USER}/MyPrograms
  ~~~


### sudo

默认变量无法带入 sudo 之后的命令，应为 `/etc/sudoers` 中定义了重置环境变量策略、设置secure path。

可以修改 `/etc/sudoers` 来保留部分变量，不被reset

1. `sudo visudo`
1. 添加到文件末尾
    ~~~
    Defaults env_keep += "http_proxy SOMEOTHERVARIABLES ANOTHERVARIABLE ETC"
    ~~~



### 给GUI程序添加变量

修改GUI程序对应的`.desktop` 文件，在 Exec 配置的地方设置，例如，下面就加了个 APPMENU_DISPLAY_BOTH 变量。

~~~
Exec=env APPMENU_DISPLAY_BOTH=1 digikam -caption "%c" %i
~~~

















