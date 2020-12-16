---
layout: post
title: spacemacs使用
categories: [cm, emacs]
tags: [editor, 编辑器, spacemacs使用, undo-tree-visualizer]
---

* 参考： 
  * []()
  * []()
  * []()
  * []()




## 安装

### Linux - Manjaro 上安装

~~~shell
sudo pacman -S emacs

cd ~
mv .emacs.d .emacs.d.bak
mv .emacs .emacs.bak

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d


# 安装字体（可选）
sudo pacman -S adobe-source-code-pro-fonts
~~~


## 使用

### 撤销 undo / 恢复 redo

* 参考
  * [cnblogs.com/pylemon - emacs undo-tree](https://www.cnblogs.com/pylemon/archive/2012/02/05/2339399.html)
  * [emacs 新手必看: undo-tree](https://linuxtoy.org/archives/emacs-undo-tree.html)

`C-x u` 变成调出 emacs undo-tree-visualizer

`undo-tree-visualizer` 的使用方法：

* `C-x u` 进入 undo-tree-visualizer-mode ,
* `p n`   上下移动，同时变化为修改记录下的内容了
* `b f`    在分支左右切换，
* `t` 显示时间戳，选定需要的状态后，
* `q` 退出。






