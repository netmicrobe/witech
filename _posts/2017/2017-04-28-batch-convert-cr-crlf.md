---
layout: post
title: CR CRLF 文件格式相互批量转化
categories: [cm, linux]
tags: [cr, crlf]
---





## CR CRLF 文件格式相互转化的命令

```shell
sed -i 's/\r$//g' your-file    # DOS to Unix
sed -i 's/$/\r/g' your-file    # Unix to DOS
```

### 清除 git status 中应为 CR/CRLF 不同而被任务是改动的文件

```shell
# 文件从 linux 拷贝到 Windows ，文件行结尾字符不同导致被git认为是改动
# 如下命令清除这样的影响
git status | grep '修改' | awk '{print $2}' | xargs sed -i 's/$/\r/g'
```
