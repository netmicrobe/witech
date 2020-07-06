---
layout: post
title: 在RVM的Ruby指定版本运行 thin
categories: [cm, ruby]
tags: [ruby, thin, rvm]
---

* 参考
  * [mapopa/thin_init.sh](https://gist.github.com/mapopa/3944992)
  * [RVM - official site](https://rvm.io/)

## 说明

需要运行thin在RVM指定的ruby版本，而不是default ruby版本。

## 已有的运行环境

thin 启动/关闭/重启

```
/etc/init.d/thin start/stop/restart
```

thin自启动设置

```
shell> chkconfig --list thin
thin            0:关闭    1:关闭    2:启用    3:启用    4:启用    5:启用    6:关闭
```

## 修改方法

修改 /etc/init.d/thin 

```
#!/bin/sh
### BEGIN INIT INFO
# Provides:          thin
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      S 0 1 6
# Short-Description: thin initscript
# Description:       thin
### END INIT INFO

# Original author: Forrest Robertson

# Do NOT "set -e"

DAEMON=/usr/local/rvm/gems/ruby-1.9.3-p551/bin/thin
SCRIPT_NAME=/etc/rc.d/thin
CONFIG_PATH=/etc/thin
ENVIR=/usr/local/rvm/environments/ruby-1.9.3-p551

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

case "$1" in
  start)
        # before : $DAEMON start --all $CONFIG_PATH
        # change to
        source $ENVIR ; $DAEMON start --all $CONFIG_PATH
        ;;
  stop)
        # before : $DAEMON stop --all $CONFIG_PATH
        # change to
        $source $ENVIR ; $DAEMON stop --all $CONFIG_PATH
        ;;
  restart)
        # before : $DAEMON restart --all $CONFIG_PATH
        # change to
        $source $ENVIR ; $DAEMON restart --all $CONFIG_PATH
        ;;
  *)
        echo "Usage: $SCRIPT_NAME {start|stop|restart}" >&2
        exit 3
        ;;
esac

:
```












