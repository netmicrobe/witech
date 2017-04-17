---
layout: post
title: CentOS 上设置 path 环境变量
categories: [cm, linux]
tags: [centos, path]
---

* 参考
  * <http://unix.stackexchange.com/a/94496>

## 添加 path 到全局 $PATH

在 /etc/profile.d 下创建 custom.sh，添加 export PATH=your-path:$PATH

例如：

```
export PATH=/usr/local/share/bin:$PATH
```

### 如何对 cron 生效

cron 默认使用的shell 是 /bin/sh ，所以要设置 SHELL=/bin/bash，还没实际操作过。。。

还可以针对cron的用户设置 BASH_ENV="$HOME/.bashrc"






