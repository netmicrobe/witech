---
layout: post
title: emacs 安装
categories: [ cm, emacs ]
tags: [editor]
---

* 参考
  * [emacs-plus Project Home Page](https://github.com/d12frosted/homebrew-emacs-plus)
  * [Spacemacs Install](https://github.com/syl20bnr/spacemacs#install)
  * [Gnu Emacs Official Site - Download & installation]https://www.gnu.org/software/emacs/download.html#macos()
  * []()



## Mac OS 上安装 Emacs

mac OS 上有2个版本的Emacs app

* [Emacs for Mac OS X]https://emacsformacosx.com/()
* [Emacs Plus](https://github.com/d12frosted/homebrew-emacs-plus)

还有个美化的前端，[Spacemacs](https://github.com/syl20bnr/spacemacs)，倾向于支持Emacs Plus。

### 安装 Emacs Plus

~~~
$ brew tap d12frosted/emacs-plus
$ brew install emacs-plus
==> emacs-plus
Emacs.app was installed to:
  /usr/local/opt/emacs-plus

To link the application to default Homebrew App location:
  brew linkapps
or:
  ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications

--natural-title-bar option was removed from this formula, in order to
  duplicate its effect add following line to your init.el file
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
or:
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . light))

If you are using macOS Mojave, please note that most of the experimental
options are forbidden on Mojave. This is temporary decision.


To have launchd start d12frosted/emacs-plus/emacs-plus now and restart at login:
  brew services start d12frosted/emacs-plus/emacs-plus
Or, if you don't want/need a background service you can just run:
  emacs


$ ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications
~~~

### 安装 Emacs For Mac OS X

~~~
brew cask install emacs
~~~



### 安装 Spacemacs

参照 <https://github.com/syl20bnr/spacemacs>

目前还没有试验过。









