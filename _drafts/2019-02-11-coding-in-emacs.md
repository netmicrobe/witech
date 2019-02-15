---
layout: post
title: 使用 emacs 开发
categories: [ cm, emacs ]
tags: [editor]
---

* 参考
  * <https://emacs-doctor.com/>
  * <https://ccrma.stanford.edu/guides/package/emacs/emacs.html>
  * <https://blog.csdn.net/sparknow/article/details/39780683>
  * [Emacs China](https://emacs-china.org)
  * [Book - Emacs China](http://book.emacs-china.org/)
  * [Emacs中文网](http://emacser.com/torture-emacs.htm)
  * [编码无悔 - Emacs on Windows初步实践](https://www.codelast.com/%e5%8e%9f%e5%88%9b-emacs-on-windows%e5%88%9d%e6%ad%a5%e5%ae%9e%e8%b7%b5/)



## 缩进 intentation

* [EmacsWiki - IndentationBasics](https://www.emacswiki.org/emacs/IndentationBasics)
* [EmacsWiki - AutoIndentMode](https://www.emacswiki.org/emacs/AutoIndentMode)
* [Emacs: Tabs, Space, Indentation Setup](http://ergoemacs.org/emacs/emacs_tabs_space_indentation_setup.html)
* [EmacsWiki - SmartTabs](https://www.emacswiki.org/emacs/SmartTabs)
* [The Ultimate Guide To Indentation in Emacs (Tabs and Spaces)](https://dougie.io/emacs/indentation/)
* [Nice Emacs go-mode indenting and autoformat](https://coderwall.com/p/kpp6ta/nice-emacs-go-mode-indenting-and-autoformat)
* [Gnu Emacs - Automatic Indentation of code](https://www.gnu.org/software/emacs/manual/html_node/elisp/Auto_002dIndentation.html)


### 快速设置

~~~ lisp
;; -------- 缩进设置 ----------------------

;; 显示空格、tab、回车等控制字符
(global-whitespace-mode 1)

;; 一个TAB等于多少空格
(setq custom-tab-width 2)

;; 用TAB键时都用空格键space填充
;; 回车，自动缩进，`M-\` 删除缩进
(setq indent-tabs-mode nil)
(setq tab-width custom-tab-width)
;; (setq-default default-tab-width 'tab-width)


;; 设置Golang
(add-hook 'go-mode-hook
    (lambda ()
      (setq tab-width custom-tab-width)
      (setq indent-tabs-mode nil)))


~~~


### 如何大段缩进代码

* [How to Indent a Selection in Emacs](https://dougie.io/emacs/indent-selection/)


1. emacs 26 默认有一个大段缩进的功能

    `Control + x TAB` 然后，

    * 方向键左右，控制移动以“空格”为单位。
    * 方向键左右 + SHIFT ，控制移动以“缩进”为单位。


2. 也可以自定义

    ~~~
    (global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
    (global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)
    ~~~

    然后，
    * Use `Control + >` to indent right
    * Use `Control + <` to indent left






### Basic Intentation

* `indent-tabs-mode` 变量决定 `TAB键` 是否用来缩进。
  * 默认值为 True
  * .emacs 中设置为 false : `(setq-default indent-tabs-mode nil)`
  * 命令设置： `M-x set-variable indent-tabs-mode 回车`
  * 查看帮助： `C-h v indent-tabs-mode 回车`


* `c-basic-offset`: The basic indentation offset in CC Mode, default is 2.
  * For Perl, it is controlled by `cperl-indent-level`.
* `tab-width`: How wide a tab is, default is 8.


统一缩进

~~~
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
~~~



### SmartTabs

<https://www.emacswiki.org/emacs/SmartTabs>

* 安装
  * 菜单栏 Options -- Manage Emacs Packages 中安装 MELPA package `smart-tabs-mode`

* 配置
  * to enable smart-tabs-mode automatically for C and Javascript
    ~~~
    (smart-tabs-insinuate 'c 'javascript)
    ~~~

* 手动开启
  * enable the minor mode with `M-x smart-tabs-mode`

* 检查SmartTab支持哪些语言
  * `M-x describe-variable 回车 smart-tabs-insinuate-alist 回车`

* 整个文件 retab  ： `C-x h C-M-\`

* Adding Language Support
  * 使用 `smart-tabs-add-language-support` 宏
    ~~~
    (smart-tabs-add-language-support c++ c++-mode-hook
      ((c-indent-line . c-basic-offset)
       (c-indent-region . c-basic-offset)))
    ~~~



### 设置实例


#### 方便显示空格、TAB、回车等字符

* 设置显示样式
  * 默认的mapping，可通过 `C-h v whitespace-display-mappings` 查看
    ~~~
    (setq whitespace-display-mappings
      '((space-mark 32 [183] [46]) ; 32 SPACE 「 」, 183 U+00B7 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (space-mark 160 [164] [95])
        (newline-mark 10 [36 10]) ; 10 LINE FEED, 36 U+0024 “$”
        (tab-mark 9 [187 9] [92 9]) ; 9 TAB , 187 U+00BB “»”
      ))
    ~~~

  * 参考：<https://stackoverflow.com/q/15946178/3316529> 的例子
    这个样式用到的字符导致中文环境下emacs卡顿！！
    ~~~
    (setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. ⁖ (insert-char 182 1)
      '(
        (space-mark 32 [183] [46]) ; 32 SPACE 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))
    ~~~

* Turn off whitespace-mode highlighting
  * <https://emacs.stackexchange.com/a/34891>
  
  ~~~
  ;; Remove spaces to disable highlighting and remove space-mark to disable marking spaces with the dot.
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark)))
  ~~~




#### How to set indentation to always use space?

~~~
(progn
  ;; make indentation commands use space only (never tab character)
  (setq-default indent-tabs-mode nil)
  ;; emacs 23.1 to 26, default to t
  ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
  )
~~~


#### 如何配置Emacs，使得输入TAB时，用空格替代

默认情况下，在Emacs中按一下TAB，就是输入TAB，如果我们想让它输入的是空格（并且可以指定按一下TAB输入几个空格），可以在.emacs中这样配置：

~~~
;; 按TAB输入2个空格，只对shell脚本生效！
(add-hook 'sh-mode-hook
  '(lambda () (setq sh-basic-offset 2)))
~~~


#### 关闭：回车换行时，自动删除行末空格

* [phils' answer](https://emacs.stackexchange.com/a/21887)
  This is a feature of `electric-indent-mode` (which is on by default in recent versions of Emacs). The behaviour is hard-coded in `electric-indent-post-self-insert-function`.

* [GDP2 的 hack方案](https://emacs.stackexchange.com/a/21913)

* 其他参考
  * <https://stackoverflow.com/questions/31135835/prevent-emacs-from-deleting-trailing-whitespace-when-return-key-is-pressed>
  * <https://www.gnu.org/software/emacs/manual/html_node/emacs/Indent-Convenience.html>

* Electric Indent mode
  * `electric-indent-mode` 是一个全局minor模式，默认打开，决定了每次“回车”后的 indent 行为。
  * To toggle this minor mode, type `M-x electric-indent-mode`.
  * To toggle the mode in a single buffer, use `M-x electric-indent-local-mode`.






















## White Space model

* [Gnu manual - 14.16 Useless Whitespace](https://www.gnu.org/software/emacs/manual/html_node/emacs/Useless-Whitespace.html)
* [EmacsWiki - WhiteSpace](https://www.emacswiki.org/emacs/WhiteSpace)


`(global-whitespace-mode 1)`
: 默认打开 white space mode














## 编程语言支持

### PHP语法

Emacs默认是没有PHP语法高亮的，可通过加载扩展来实现。

1. 下载Emacs扩展 <http://sourceforge.net/projects/php-mode/>
2. 将压缩包中的 php-mode.el 放到你的.emacs配置文件同一目录下，重命名为 .php-mode.el。
3. 在.emacs配置文件中，添加一句： `(load-file "~/.php-mode.el")
4. 再重新用Emacs打开一个PHP文件，就会发现已经有语法高亮了。


### Go 语法

在菜单栏 Options -- Manage Emacs Packages 中找到 `go-mode` 并安装









## 其他技巧

`C-Q TAB键` 或者 `C-q C-i`
: 输入 TAB 字符


`M-x whitespace-mode`
: 用`·`显示空格，用`$`显示换行（当前buffer），参考 [Emacs: Make Whitespaces Visible](http://ergoemacs.org/emacs/whitespace-mode.html)

`M-x global-whitespace-mode`
: 用`·`显示空格，用`$`显示换行（所有buffer）






















