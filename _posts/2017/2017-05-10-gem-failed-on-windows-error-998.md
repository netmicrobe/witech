---
layout: post
title: 执行 bundle / gem install 失败，提示 Win32 error 998
categories: [cm, ruby]
tags: [ruby, gem, bundle, windows]
---


* 现象

```
gem install rdiscount -v '2.1.8'

Building native extensions.  This could take a while...
ERROR:  Error installing rdiscount:
        ERROR: Failed to build gem native extension.
ruby.exe extconf.rb
checking for random()... no
checking for srandom()... no
checking for rand()... yes
checking for srand()... yes
checking size of unsigned long... 4
checking size of unsigned int... 4
creating Makefile

make "DESTDIR=" clean

make "DESTDIR="
generating rdiscount-x64-mingw32.def
      0 [main] sh 9760 fork_copy: linked dll data/bss pass 0 failed, 0x108000..0x108AD8, done 0, windows pid 6784, Win32 error 998
/bin/sh: fork: Resource temporarily unavailable
make: *** [rdiscount-x64-mingw32.def] Error 128

make failed, exit code 2

Gem files will remain installed in 
```

* 解决

以管理员权限启动 windows cmd，再执行 gem install
