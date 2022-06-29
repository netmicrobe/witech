---
layout: post
title: 在linux上使用meld作为git-diff-tool，关联 ruby, xlsx
categories: [cm, git]
tags: []
---

* 参考： 
  * [how to set meld as git difftool](https://www.codegrepper.com/code-examples/shell/how+to+set+meld+as+git+difftool)
  * [Using meld with git diff](https://blog.deadlypenguin.com/2011/05/03/using-meld-with-git-diff/)
  * [Configure meld as git diff and merge tool](https://gist.github.com/laszlomiklosik/3874904)
  * [Do git diff and merge with meld](https://qiita.com/take5249/items/64d76f1a1acb7a190b6c)
  * [How do I set up and use Meld as my git difftool?](https://stackoverflow.com/a/34119867)
  * []()
  * []()



1. 安装 meld
    ~~~sh
    sudo pacman -S meld
    ~~~
1. 设置
    ~~~sh
    git config --global diff.tool meld
    git config --global difftool.prompt false
    ~~~
1. 比较
    ~~~sh
    git difftool your-file-path
    ~~~


## 修改meld 颜色风格

meld 菜单 》 preferences 》 Editor 标签页 》 Syntxt highlighting color scheme









































