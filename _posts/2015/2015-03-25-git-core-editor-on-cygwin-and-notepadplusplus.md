---
layout: post
title: 在Cygwin上的Git配置notepad++ 启动
categories: [cm, git]
tags: [cm, git, cygwin, notepad++]
---


先创建一个脚本 ，脚本必须是unix换行风格，才能在Cygwin中正确执行，windows换行风格可就要报目录找不到了！！

```
#!/bin/sh 
/cygdrive/e/noinstall/notepad_plusplus/notepad++.exe -multiInst -noPlugin -nosession "$(cygpath -w "$*")"
```

再指向这个脚本 

```
git config --global core.editor /cygdrive/e/noinstall/notepad_plusplus/npp.sh 
```

如果在 notepad++ 中写的 commit message，包含中文，将encoding改为“Utf8 without BOM” 

方法：菜单 Encoding 》 converting to UTF8 without BOM 

如果想将 默认encoding改为"UTF8-WITHOUT-BOM"： 

菜单 Preferences... > New Document/Default Directory > Encoding > UTF-8 without BOM 

* 参考： 
  * <http://stackoverflow.com/questions/1634161/how-do-i-use-notepad-or-other-with-msysgit>
  * <http://stackoverflow.com/questions/10209660/using-notepad-for-git-inside-cygwin>
  * <http://stackoverflow.com/questions/4513387/git-problem-with-interactive-rebase>
  * <http://stackoverflow.com/questions/10209660/using-notepad-for-git-inside-cygwin>


