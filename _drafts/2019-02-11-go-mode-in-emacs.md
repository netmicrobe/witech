---
layout: post
title: Emacs 中使用Go语言支持（go-mode）
categories: [cm, emacs]
tags: [golang]
---

* 参考： 
  * [Dominik Honnef - Writing Go in Emacs](http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/)
  * [github - dominikh/go-mode.el](https://github.com/dominikh/go-mode.el)
  * []()
  * []()


## 安装

在菜单栏 Options -- Manage Emacs Packages 中找到 `go-mode` 并安装



## 使用 go-mode

### 格式化代码 gofmt

1. 手动格式化当前buffer：`M-x gofmt`
2. 保存文件前，自动调用hook： `(add-hook 'before-save-hook 'gofmt-before-save)`


### 管理 imports

The new `go-mode` has three functions for working with imports:
* go-import-add
* go-remove-unused-imports 
* go-goto-imports.


#### go-import-add

* `go-import-add`, bound to `C-c C-a` by default
  * will prompt you for an import path(again supporting tab completion) and insert it in the import block, creating it if necessary.

* If an import already existed but was commented, it will be uncommented.

* If prefixed with C-u, it will ask you for an alias


#### go-remove-unused-imports

* go-mode will detect all unused imports and delete them (or comment them) once you run `go-remove-unused-imports`.
* 默认 __没有__ 绑定快捷键
  * 可以自己设置，go-mode作者绑定到 `C-c C-r`
    ~~~
    (add-hook 'go-mode-hook (lambda ()
         (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))`
    ~~~


#### go-goto-imports

* `go-goto-imports` 自动跳转到 imports 代码的地方
* 默认 __没有__ 绑定快捷键
  * 可以自己设置
    ~~~
    (add-hook 'go-mode-hook (lambda ()
                              (local-set-key (kbd "C-c i") 'go-goto-imports)))
    ~~~



### Navigating code

* 支持 beginning-of-defun (C-M-a) 
* 支持 end-of-defun (C-M-e)
* godef-describe is bound to `C-c C-d`
* godef-jump is bound to `C-c C-j`







## 安装goimports，gocode等有用工具

### goimports

goimports命令能自动格式化代码，自动添加、移除imports，而且与Emacs集成良好。可以替代官方gofmt命令。

安装命令: `go get -u golang.org/x/tools/cmd/goimports`

### gocode

gocode命令能为代码自动补全提供后台支持，是Emacs下Go代码补全必不可少的backend。

安装命令: `go get -u github.com/nsf/gocode`

### godef

godef命令能在Go源码变量、函数定义间跳转，是查看变量、函数、文件定义的好助手。

安装命令： `go get github.com/rogpeppe/godef`























