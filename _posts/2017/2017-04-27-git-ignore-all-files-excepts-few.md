---
layout: post
title: 如何编辑 .gitignore 忽略所有文件，除了个别文件和文件夹
categories: [cm, git]
tags: [gitignore, git]
---


* 参考
  * <https://gist.github.com/ncimino/3905536>
  * <http://stackoverflow.com/questions/1248570/how-do-i-tell-git-to-ignore-everything-except-a-subdirectory>


## 例子，tomcat 部署服务器，跟踪 web app 文件变化

### tomcat 的目录结构

```
bin
CHANGELOGS.txt
conf
lib
LICENSE
logs
NOTICE
README.txt
RELEASE-NOTES
RUNNING.txt
temp
webapps
  -- your-app-folder
work
```

### .gitignore 的错误写法

错误的 .gitignore 范例，忽略所有文件，除了个别文件和文件夹

```
*
!/webapps/your-app-folder
```

### .gitignore 正确的写法

```
*
!.gitignore
!/webapps
/webapps/*
!/webapps/your-app-folder
```

## github 的例子，Git Ignore All Except 

[ncimino/.gitignore](https://gist.github.com/ncimino/3905536)

```
*
!/a
/a/*
!/a/b
/a/b/*
!/a/b/c
/a/b/c/*
!/a/b/c/foo

# don't forget this one
!.gitignore
```

