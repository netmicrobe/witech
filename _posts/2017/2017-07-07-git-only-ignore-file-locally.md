---
layout: post
title: git ： 只在本地库忽略文件，而不加入到 .gitignore
categories: [cm, git]
tags: [git, gitignore]
---

* 参考
  * <https://coderwall.com/p/n1d-na/excluding-files-from-git-locally>
  * <https://stackoverflow.com/a/1753078>




## 如何本地库忽略文件

在 ".git/info/exclude" 文件中添加行就好啦

如果已经有改动被侦测出来，执行：

~~~shell
git update-index --assume-unchanged [<file>...]
~~~

## 便捷alias

~~~
# .gitconfig 的 [alias] 中设置
exclude = !sh -c 'echo "$1" >> .git/info/exclude' -

# 然后可执行
git exclude SOME_FILE
~~~






