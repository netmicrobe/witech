---
layout: post
title: Git和Gerrit使用帮助
categories: [cm, git]
tags: [cm, git, gerrit]
---

## 使用Git

### 设置commit message的编辑器

使用notepad++，设置notepad++的默认编码是 UTF8 without BOM

先创建一个脚本，包装notepad++.exe

```
 #!/bin/sh
/cygdrive/e/noinstall/notepad_plusplus/notepad++.exe -multiInst -noPlugin -nosession $ 
```

在指向这个脚本

```
git config --global core.editor /cygdrive/e/noinstall/notepad_plusplus/npp.sh
```

如果在notepad++中写的commit message，包含中文，将encoding改为“Utf8 without BOM”

方法：菜单 Encoding 》 converting to UTF8 without BOM

如果想将默认encoding改为"UTF8-WITHOUT-BOM"：

菜单 Preferences... > New Document/Default Directory > Encoding > UTF-8 without BOM




### 设置diff tool

下载安装winmerge（开源）

创建一个包装脚本，git_diff.sh，设置模式为可执行

```
 #!/bin/sh
LEFT=`cygpath -d ${1}`
RIGHT=`cygpath -d ${2}`
echo Launching WinMergeU.exe: $LEFT $RIGHT
/cygdrive/e/Program/WinMerge/WinMergeU.exe -e -ub "$LEFT" "$RIGHT" 
```

告诉git用这个脚本来调用difftool

```
git config --global diff.tool ~/git_diff.sh
```



## 开始使用gerrit

### 访问并登录

http://192.168.251.72:8000/gerrit/

### 配置ssh公钥

使用ssh-keygen生产公钥-密钥对。
将公钥文件中的内容添加到 Settings > SSH Public Keys

### 使用commit message模板

创建一个模板文件

例如：git_commit_template.txt

```
# [BUGFIX|TASK #???] [ Subject: One line only short meaningful description for logs ]===|
# refs: #??? 
```

设置下模板，下次提交就可以用了

```
git config --global commit.template ～/git_commit_template.txt
```




## 开始项目之前

### 设置commit hooks

将commit-msg下载，放到当前项目的.git/hooks目录下





## 开发

### 提交修改到项目

```
push origin HEAD:refs/for/master
或者
push origin HEAD:refs/for/target-branch
```


