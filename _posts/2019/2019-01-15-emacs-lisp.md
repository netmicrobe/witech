---
layout: post
title: emacs 中使用LISP
categories: [ cm, emacs ]
tags: [lisp, elisp]
---






## Elisp 基础

* [X分钟速成elisp](https://learnxinyminutes.com/docs/zh-cn/elisp-cn/)
* [Common Lisp 里的一些基本概念](http://icodeit.org/2013/06/common-lisp-basic/)

`C-j`
: 计算当前光标到行首之间函数式结果，插入正文内容，结果内容最多只显示2行，后面用省略号，What！！
  使用 `C-0 C-j` 能把结果内容显示全。
  `eval-expression-print-level` and `eval-expression-print-length` 用来控制内容显示的长度。

`C-x C-e`
: 计算当前光标到行首之间函数式结果，显示在mini-buffer里。



Emacs Lisp 是一个函数式的语言。



### `*scratch*` buffer

* `C-x 方向键` 切换到 `*scratch*` buffer ， 可以在其中测试 elisp 语句。
* 这个buffer是 *lisp-interaction-mode*。
* 光标移动到函数式后，按下 `C-j` 或者 `C-x C-e`，就可以执行函数式计算。


### 基本写法，如何测试

~~~ lisp
(+ 3 (+ 1 2))
;;           ^ 光标放到这里
;; 按下`C-j' 就会输出 6
;; `C-j' 会在buffer中插入当前运算的结果
;; 而`C-xC-e' 则会在emacs最底部显示结果，也就是被称作"minibuffer"的区域
;; 为了避免把我们的buffer填满无用的结果，我们以后会一直用`C-x C-e'
~~~

### 变量

* `setq` 设置当前缓冲区（Buffer）中的变量值
* `setq-default` 设 置的为全局的变量的值

~~~ lisp
;; `setq' 可以将一个值赋给一个变量
(setq my-name "Bastien")
;; `C-x C-e' 输出 "Bastien" (在 mini-buffer 中显示)

;; 定义变量
(setq name "username")
(message name) ; -> "username"
~~~

~~~
;; 设置光标样式
(setq-default cursor-type 'bar)
~~~


### quote 单引号

* <https://www.gnu.org/software/emacs/manual/html_node/elisp/Quoting.html>
* <http://stackoverflow.com/questions/134887/when-to-use-quote-in-lisp>

~~~
;; 下面两行的效果完全相同的
(quote foo)
'foo
~~~

quote 的意思是不要执行后面的内容，返回它原本的内容

~~~
(print '(+ 1 1)) ;; -> (+ 1 1)
(print (+ 1 1))  ;; -> 2
~~~



### 列表

~~~
;; 我们将一些名字存到列表中：
(setq list-of-names '("Sarah" "Chloe" "Mathilde"))

;; 用 `car'来取得第一个名字：
(car list-of-names)

;; 用 `cdr'取得剩下的名字:
(cdr list-of-names)

;; 用 `push'把名字添加到列表的开头:
(push "Stephanie" list-of-names)

;; 注意: `car' 和 `cdr' 并不修改列表本身, 但是 `push' 却会对列表本身进行操作.
;; 这个区别是很重要的: 有些函数没有任何副作用（比如`car'）
;; 但还有一些却是有的 (比如 `push').
~~~



### 循环

<http://www.gnu.org/software/emacs/manual/html_mono/cl.html#Loop-Facility>

`loop for ... in` 来自 cl 即 Common Lisp 扩展。

~~~
;; cl - Common Lisp Extension
(require 'cl)
~~~

for , in, collect 均为 cl-loop 中的 保留关键字。下面是一些简单的 cl-loop 的使用示例：

~~~
;; 遍历每一个缓冲区（Buffer）
(cl-loop for buf in (buffer-list)
  collect (buffer-file-name buf))

;; 寻找 729 的平方根（设置最大为 100 为了防止无限循环）
(cl-loop for x from 1 to 100
  for y = (* x x)
  until (>= y 729)
  finally return (list x (= y 729)))
~~~




### mapcar

~~~
;; 我们来对`list-of-names'列表中的每一个元素都使用hello函数:
(mapcar 'hello list-of-names)

;; 将 `greeting' 改进，使的我们能够对`list-of-names'中的所有名字执行:
(defun greeting ()
    (switch-to-buffer-other-window "*test*")
    (erase-buffer)
    (mapcar 'hello list-of-names)
    (other-window 1))

(greeting)
~~~

### while 循环

~~~
(defun replace-hello-by-bonjour ()
    (switch-to-buffer-other-window "*test*")
    (goto-char (point-min))
    (while (search-forward "Hello")
      (replace-match "Bonjour"))
    (other-window 1))

;; (goto-char (point-min)) 将光标移到buffer的开始
;; (search-forward "Hello") 查找字符串"Hello"
;; (while x y) 当x返回某个值时执行y这个s式
;; 当x返回`nil' (空), 退出循环


(replace-hello-by-bonjour)

;; 你会看到所有在*test* buffer中出现的"Hello"字样都被换成了"Bonjour"

;; 你也会得到以下错误提示: "Search failed: Hello".
;;
;; 如果要避免这个错误, 你需要告诉 `search-forward' 这个命令是否在
;; buffer的某个地方停止查找, 并且在什么都没找到时是否应该不给出错误提示

;; (search-forward "Hello" nil t) 可以达到这个要求:

;; `nil' 参数的意思是 : 查找并不限于某个范围内
;; `t' 参数的意思是: 当什么都没找到时，不给出错误提示

~~~



### defun

~~~
;; 你可以把s式嵌入函数中
(defun hello () (insert "Hello, I am " my-name))
;; `C-xC-e' 输出 hello

;; 现在执行这个函数
(hello)
;; `C-xC-e' 输出 Hello, I am Bastien

;; 带参数的函数定义
(defun hello (name) (insert "Hello " name))
;; `C-xC-e' 输出 hello
(hello "you")
;; `C-xC-e' 输出 "Hello you"
~~~


### progn

~~~
;; 你可以用 `progn'命令将s式结合起来:
(progn
  (switch-to-buffer-other-window "*test*")
  (hello "you"))
;; `C-xC-e' 此时屏幕分为两个窗口，并且在*test* buffer中显示"Hello you"
~~~


### let

~~~
;; 你可以用 `let' 将一个值和一个局部变量绑定:
(let ((local-name "you"))
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello local-name)
  (other-window 1))

;; 我们再用`let'新建另一个函数:
(defun greeting (name)
  (let ((your-name "Bastien"))
    (insert (format "Hello %s!\n\nI am %s."
                    name       ; the argument of the function
                    your-name  ; the let-bound variable "Bastien"
                    ))))

;; 之后执行:
(greeting "you")
~~~


### 交互命令 read-from-minibuffer

~~~
;; 有些函数可以和用户交互:
(read-from-minibuffer "Enter your name: ")

;; 这个函数会返回在执行时用户输入的信息

;; 现在我们让`greeting'函数显示你的名字:
(defun greeting (from-name)
  (let ((your-name (read-from-minibuffer "Enter your name: ")))
    (insert (format "Hello!\n\nI am %s and you are %s."
                    from-name ; the argument of the function
                    your-name ; the let-bound var, entered at prompt
                    ))))

(greeting "Bastien")
~~~



### lisp 操作 emacs

#### switch-to-buffer-other-window

~~~
;; 下面我们在新的窗口中新建一个名为 "*test*" 的buffer:

(switch-to-buffer-other-window "*test*")
;; `C-xC-e' 这时屏幕上会显示两个窗口，而光标此时位于*test* buffer内

;; 用鼠标单击上面的buffer就会使光标移回。
;; 或者你可以使用 `C-xo' 使得光标跳到另一个窗口中
~~~

#### (goto-char (point-min)) 将光标移到buffer的开始

#### (search-forward "Hello") 查找字符串"Hello"

#### global-set-key 设置快捷键

~~~
;; 设置快捷键
(global-set-key (kbd "<f1>") 'func-name)
~~~


### 其他lisp语法

#### insert

~~~
;; `insert' 会在光标处插入字符串:
(insert "Hello!")
;; `C-xC-e' 输出 "Hello!"

(insert "Hello" " world!")
;; `C-xC-e' 输出 "Hello world!"

;; 你也可以用变量名来代替字符串
(insert "Hello, I am " my-name)
;; `C-xC-e' 输出 "Hello, I am Bastien"
~~~

#### format

~~~
;; 格式化字符串的方法：
(format "Hello %s!\n" "visitor")

(defun hello (name)
  (insert (format "Hello %s!\n" name)))
~~~

