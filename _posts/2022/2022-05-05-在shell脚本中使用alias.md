---
layout: post
title: 在shell脚本中使用alias，关联 bash, shopt, shebang, script，脚本
categories: [cm, linux]
tags: []
---

* 参考
  * [在shell脚本中使用alias](https://www.cnblogs.com/fnlingnzb-learner/p/10649971.html)
  * []()


默认shell脚本无法调用alias，应为alias功能未开启。

开启方法：

第一种：脚本中执行 `shopt -s  expand_aliases `

第二种，脚本第一行（shebang）加 login 参数： `#!/bin/bash --login` 或 `#!/bin/bash -i`













































































