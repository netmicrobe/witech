---
layout: post
title: git： list or clean untracked files，清理未入库的文件
categories: [cm, git]
tags: [cm, git]
---



### List git-ignored files

```
git ls-files . --ignored --exclude-standard --others 
```


### List untracked files 

```
git ls-files . --exclude-standard --others
```



### Clean all untrack files

```
git clean -d -f
```