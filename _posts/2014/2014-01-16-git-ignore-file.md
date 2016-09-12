---
layout: post
title: git ignore file
categories: [cm, git]
tags: [cm, git]
---


.gitignore file 只对该file创建之后，再创建的file起过滤作用；以前入库的file不受影响。

* ignore file demo
  * <https://help.github.com/articles/ignoring-files>
  * <https://github.com/github/gitignore>


### 设置全局的ignore file

```
git config --global core.execludesfile ~/.gitignore_globa
```

### ignore入库的文件

先从staging index中删除该文件：

```
git rm --cached wanna-ignore-file
```

然后将文件加入到.gitignore


### git默认忽略空文件夹，空文件夹将不会被入库。

空文件夹如果想入库，在其中创建一个占位的文件，例如，.gitkeep 或者 .gitignore，即可commit入库了。










