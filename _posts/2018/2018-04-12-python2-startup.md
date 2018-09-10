---
layout: post
title: Python2 编程入门
categories: [ dev, python ]
tags: [ python ]
---

* 参考
  * <https://docs.python.org/2/tutorial/index.html>
  * <>
  * <>

[dict]: https://docs.python.org/2/library/stdtypes.html#typesmapping


## Python Interpreter

* 参考
  * [Command line and environment](https://docs.python.org/2/using/cmdline.html#using-on-general)
  * [Interactive Mode](https://docs.python.org/2/tutorial/appendix.html#tut-interac)

### 调用解释器

* 进入
  * `python` 进入 python console
  * `python -c command [arg] ...`
    * usually advised to quote command in its entirety with single quotes.
  * Some Python modules as scripts: `python -m module [arg] ...`
* 退出
  * Typing an end-of-file character (Control-D on Unix, Control-Z on Windows)
  * exit()
  * quit()

### 命令行参数

脚本名称和参数都放在 `sys` module 的 `argv` 变量。

* The length of the list is at least one; when no script and no arguments are given, sys.argv[0] is an empty string. 
* When the script name is given as '-' (meaning standard input), sys.argv[0] is set to '-'.
* When -c command is used, sys.argv[0] is set to '-c'.
* When -m module is used, sys.argv[0] is set to the full name of the located module.


## 源代码编码

默认 Python2 源代码文件使用 `ASCII` 编码。

在源文件第一行使用如下格式，指定编码。

~~~ python
# -*- coding: encoding -*-
~~~

* 例子：使用 Windows-1252 编码
  ~~~ python
  # -*- coding: cp-1252 -*-
  ~~~
  
  或者，让位 UNIX “shebang” line
  
  ~~~ python
  #!/usr/bin/env python
  # -*- coding: cp-1252 -*-
  ~~~



## 注释

`#` 单行注释，影响范围到行末

~~~ python
# this is the first comment
spam = 1  # and this is the second comment
          # ... and now a third!
text = "# This is not a comment because it's inside quotes."
~~~


## 数值计算


### 操作符

`**` 2个星号代表乘方，5 ** 2 == 25

其他加减乘除和其他语言一样。



## String

单引号，双引号都可以界定字符串字面值。

### 转义操作符

`\` 为转义操作符。在字符串之前加`r`关闭转义效果，转义操作符变成普通字符。

~~~ python
>>> 'doesn\'t'  # use \' to escape the single quote...
"doesn't"
>>> "doesn't"  # ...or use double quotes instead
"doesn't"
>>> print '"Isn\'t," she said.'
"Isn't," she said.
~~~

~~~ python
>>> print 'C:\some\name'  # here \n means newline!
C:\some
ame
>>> print r'C:\some\name'  # note the r before the quote
C:\some\name
~~~

### 三引号 """...""" or '''...''' 用来界定多行字符串文本。

~~~ python
# 换行字符会自动被当成第一个字符，使用反斜杠 \ 能避免。
print """\
Usage: thingy [OPTIONS]
     -h                        Display this usage message
     -H hostname               Hostname to connect to
"""
~~~

### `+` 连接字符串； `*` 重复字符串。

~~~ python
>>> # 3 times 'un', followed by 'ium'
>>> 3 * 'un' + 'ium'
'unununium'
~~~

### 2 个相邻字符串字面量，自动连接。

注意，是字面量，不是变量，变量使用 `+` 来与字面量连接。

~~~ python
>>> 'Py' 'thon'
'Python'

>>> text = ('Put several strings within parentheses '
...         'to have them joined together.')
>>> text
'Put several strings within parentheses to have them joined together.'
~~~


### 字符串长度 ，使用 built-in function len() 获取

~~~ python
>>> s = 'supercalifragilisticexpialidocious'
>>> len(s)
34
~~~




### 字符串是字符数组

从 0 开始编号。

注意，python 没有 char / 字符这种数据类型，一个 char 就是一个包含但字符的String。

~~~ python
>>> word = 'Python'
>>> word[0]  # character in position 0
'P'
>>> word[5]  # character in position 5
'n'

# 序号可以为负数，从末尾开始计数。negative indices start from -1.
>>> word[-1]  # last character
'n'
>>> word[-2]  # second-last character
'o'
>>> word[-6]
'P'
~~~

### 提取字符串

~~~
 +---+---+---+---+---+---+
 | P | y | t | h | o | n |
 +---+---+---+---+---+---+
 0   1   2   3   4   5   6
-6  -5  -4  -3  -2  -1
~~~

~~~ python
>>> word = 'Python'
>>> word[0:2]  # characters from position 0 (included) to 2 (excluded)
'Py'
>>> word[2:5]  # characters from position 2 (included) to 5 (excluded)
'tho'

>>> word[:2]   # character from the beginning to position 2 (excluded)
'Py'
>>> word[4:]   # characters from position 4 (included) to the end
'on'
>>> word[-2:]  # characters from the second-last (included) to the end
'on'
~~~


### Python strings cannot be changed — they are **immutable**.

~~~ python
>>> word[0] = 'J'
  ...
TypeError: 'str' object does not support item assignments
~~~













## Unicode Strings

[unicode]: http://www.unicode.org/

从 Python 2.0 开始 除了个新的 Unicode object 来存储和处理 [unicode] 数据。 

Creating Unicode strings in Python

~~~ python
>>> u'Hello World !'
u'Hello World !'

>>> u'Hello\u0020World !'
u'Hello World !'

# raw mode, quote with ‘ur’

>>> ur'Hello\u0020World !'
u'Hello World !'
>>> ur'Hello\\u0020World !'
u'Hello\\\\u0020World !'
~~~

### 编码转换

The built-in function unicode() provides access to all registered Unicode codecs (COders and DECoders)，例如Latin-1, ASCII, UTF-8, and UTF-16。 默认是 ASCII。

When a Unicode string is printed, written to a file, or converted with str(), conversion takes place using this default encoding.

~~~ python
>>> u"abc"
u'abc'
>>> str(u"abc")
'abc'
>>> u"äöü"
u'\xe4\xf6\xfc'
>>> str(u"äöü")
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
UnicodeEncodeError: 'ascii' codec can't encode characters in position 0-2: ordinal not in range(128)
~~~

To convert a Unicode string into an 8-bit string.

~~~ python
>>> u"äöü".encode('utf-8')
'\xc3\xa4\xc3\xb6\xc3\xbc'
~~~

从 utf-8 字节流生成 unicode 字符串。

~~~ python
>>> unicode('\xc3\xa4\xc3\xb6\xc3\xbc', 'utf-8')
u'\xe4\xf6\xfc'
~~~


## Control Flow 语法 

### if


~~~ python
>>> x = int(raw_input("Please enter an integer: "))
Please enter an integer: 42
>>> if x < 0:
...     x = 0
...     print 'Negative changed to zero'
... elif x == 0:
...     print 'Zero'
... elif x == 1:
...     print 'Single'
... else:
...     print 'More'
...
More
~~~



### for

Python’s for statement iterates over the items of any sequence

~~~ python
>>> # Measure some strings:
... words = ['cat', 'window', 'defenestrate']
>>> for w in words:
...     print w, len(w)
...
cat 3
window 6
defenestrate 12
~~~

If you need to modify the sequence you are iterating over while inside the loop (for example to duplicate selected items), it is recommended that you first make a copy.

~~~ python
>>> for w in words[:]:  # Loop over a slice copy of the entire list.
...     if len(w) > 6:
...         words.insert(0, w)
...
>>> words
['defenestrate', 'cat', 'window', 'defenestrate']
~~~


~~~ python
# the position index and corresponding value can be retrieved at the same time using the enumerate() function.
>>> for i, v in enumerate(['tic', 'tac', 'toe']):
...     print i, v
...
0 tic
1 tac
2 toe
~~~

~~~ python
# To loop over two or more sequences at the same time, the entries can be paired with the zip() function.
>>> questions = ['name', 'quest', 'favorite color']
>>> answers = ['lancelot', 'the holy grail', 'blue']
>>> for q, a in zip(questions, answers):
...     print 'What is your {0}?  It is {1}.'.format(q, a)
...
What is your name?  It is lancelot.
What is your quest?  It is the holy grail.
What is your favorite color?  It is blue.
~~~


~~~ python
# To loop over a sequence in reverse, first specify the sequence in a forward direction and then call the reversed() function.
>>> for i in reversed(xrange(1,10,2)):
...     print i
...
9
7
5
3
1
~~~

~~~ python
# To loop over a sequence in sorted order, use the sorted() function which returns a new sorted list while leaving the source unaltered.
>>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
>>> for f in sorted(set(basket)):
...     print f
...
apple
banana
orange
pear
~~~

~~~ python
# When looping through dictionaries, the key and corresponding value can be retrieved at the same time using the iteritems() method.
>>> knights = {'gallahad': 'the pure', 'robin': 'the brave'}
>>> for k, v in knights.iteritems():
...     print k, v
...
gallahad the pure
robin the brave
~~~



### The range() Function

~~~ python
>>> range(10)
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# 第三个参数表示步长，默认步长为1
>>> range(5, 10)
[5, 6, 7, 8, 9]
>>> range(0, 10, 3)
[0, 3, 6, 9]
>>> range(-10, -100, -30)
[-10, -40, -70]
~~~

~~~ python
>>> a = ['Mary', 'had', 'a', 'little', 'lamb']
>>> for i in range(len(a)):
...     print i, a[i]
...
0 Mary
1 had
2 a
3 little
4 lamb
~~~


### break、else

The `break` statement, like in C, breaks out of the innermost enclosing for or while loop.

`else` clause; it is executed when the loop terminates through exhaustion of the list (with for) or when the condition becomes false (with while), but not when the loop is terminated by a break statement. 


~~~ python
>>> for n in range(2, 10):
...     for x in range(2, n):
...         if n % x == 0:
...             print n, 'equals', x, '*', n/x
...             break
...     else:
...         # loop fell through without finding a factor
...         print n, 'is a prime number'
...
2 is a prime number
3 is a prime number
4 equals 2 * 2
5 is a prime number
6 equals 2 * 3
7 is a prime number
8 equals 2 * 4
9 equals 3 * 3
~~~

### continue

~~~ python
>>> for num in range(2, 10):
...     if num % 2 == 0:
...         print "Found an even number", num
...         continue
...     print "Found a number", num
Found an even number 2
Found a number 3
Found an even number 4
Found a number 5
Found an even number 6
Found a number 7
Found an even number 8
Found a number 9
~~~


### pass

The pass statement does nothing. It can be used when a statement is required syntactically but the program requires no action. For example:

~~~ python
>>> while True:
...     pass  # Busy-wait for keyboard interrupt (Ctrl+C)
...
~~~

~~~ python
# This is commonly used for creating minimal classes:

>>> class MyEmptyClass:
...     pass
...
~~~


### 条件操作符

* The comparison operators `in` and `not in` check whether a value occurs (does not occur) in a sequence. 
* The operators `is` and `is not` compare whether two objects are really the same object;
* Comparisons may be combined using the Boolean operators `and` and `or`
* the outcome of a comparison (or of any other Boolean expression) may be negated with `not`.

~~~ python
>>> string1, string2, string3 = '', 'Trondheim', 'Hammer Dance'
>>> non_null = string1 or string2 or string3
>>> non_null
'Trondheim'
~~~





## List

列表中的项可以是各种类型数据，但一般都是同一种类型。

~~~ python
>>> squares = [1, 4, 9, 16, 25]
>>> squares
[1, 4, 9, 16, 25]
~~~

从 0 开始索引。

~~~ python
>>> squares[0]  # indexing returns the item
1
>>> squares[-1]
25
>>> squares[-3:]  # slicing returns a new list
[9, 16, 25]
~~~

拷贝 List

~~~ python
>>> squares[:]
[1, 4, 9, 16, 25]
~~~


### 长度

~~~ python
>>> letters = ['a', 'b', 'c', 'd']
>>> len(letters)
4
~~~


### `+` 连接 list

~~~ python
>>> squares + [36, 49, 64, 81, 100]
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
~~~


### list 中元素可以修改

~~~ python
>>> cubes = [1, 8, 27, 65, 125]  # something's wrong here
>>> cubes[3] = 64  # replace the wrong value
>>> cubes
[1, 8, 27, 64, 125]
~~~

### 追加

~~~ python
>>> cubes.append(216)  # add the cube of 6
>>> cubes.append(7 ** 3)  # and the cube of 7
>>> cubes
[1, 8, 27, 64, 125, 216, 343]
~~~


### 批量修改元素

~~~ python
>>> letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
>>> # replace some values
>>> letters[2:5] = ['C', 'D', 'E']
>>> letters
['a', 'b', 'C', 'D', 'E', 'f', 'g']
>>> # now remove them
>>> letters[2:5] = []
>>> letters
['a', 'b', 'f', 'g']
>>> # clear the list by replacing all the elements with an empty list
>>> letters[:] = []
>>> letters
[]
~~~


### 多元列表

~~~ python
>>> a = ['a', 'b', 'c']
>>> n = [1, 2, 3]
>>> x = [a, n]
>>> x
[['a', 'b', 'c'], [1, 2, 3]]
>>> x[0]
['a', 'b', 'c']
>>> x[0][1]
'b'
~~~


### List Comprehensions

~~~ python
>>> squares = []
>>> for x in range(10):
...     squares.append(x**2)
...
>>> squares
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]


# 等价于
squares = [x**2 for x in range(10)]  # List Comprehensions

# 等价于
squares = map(lambda x: x**2, range(10))
~~~

更多例子如下：

~~~ python
>>> [(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
[(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
~~~

~~~ python
>>> vec = [-4, -2, 0, 2, 4]
>>> # create a new list with the values doubled
>>> [x*2 for x in vec]
[-8, -4, 0, 4, 8]
>>> # filter the list to exclude negative numbers
>>> [x for x in vec if x >= 0]
[0, 2, 4]
>>> # apply a function to all the elements
>>> [abs(x) for x in vec]
[4, 2, 0, 2, 4]
>>> # call a method on each element
>>> freshfruit = ['  banana', '  loganberry ', 'passion fruit  ']
>>> [weapon.strip() for weapon in freshfruit]
['banana', 'loganberry', 'passion fruit']
>>> # create a list of 2-tuples like (number, square)
>>> [(x, x**2) for x in range(6)]
[(0, 0), (1, 1), (2, 4), (3, 9), (4, 16), (5, 25)]
>>> # flatten a list using a listcomp with two 'for'
>>> vec = [[1,2,3], [4,5,6], [7,8,9]]
>>> [num for elem in vec for num in elem]
[1, 2, 3, 4, 5, 6, 7, 8, 9]
~~~

~~~ python
# List comprehensions can contain complex expressions and nested functions:

>>> from math import pi
>>> [str(round(pi, i)) for i in range(1, 6)]
['3.1', '3.14', '3.142', '3.1416', '3.14159']
~~~


#### Nested List Comprehensions

~~~ python
>>> matrix = [
...     [1, 2, 3, 4],
...     [5, 6, 7, 8],
...     [9, 10, 11, 12],
... ]

>>> [[row[i] for row in matrix] for i in range(4)]
[[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]

# 等价于
>>> transposed = []
>>> for i in range(4):
...     transposed.append([row[i] for row in matrix])
...
>>> transposed
[[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]


# 等价于
# 使用python built-in function ： zip
>>> zip(*matrix)
[(1, 5, 9), (2, 6, 10), (3, 7, 11), (4, 8, 12)]
~~~



###  The del statement

The del statement can also be used to remove slices from a list or clear the entire list

~~~ python
>>> a = [-1, 1, 66.25, 333, 333, 1234.5]
>>> del a[0]
>>> a
[1, 66.25, 333, 333, 1234.5]
>>> del a[2:4]
>>> a
[1, 66.25, 1234.5]
>>> del a[:]
>>> a
[]

# del can also be used to delete entire variables:
>>> del a
~~~

## Set

A set is an unordered collection with no duplicate elements.

* Curly braces or the set() function can be used to create sets.
* to create an empty set you have to use set()
* support mathematical operations like union, intersection, difference, and symmetric difference.
* Basic uses include membership testing and eliminating duplicate entries.

~~~ python
>>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
>>> fruit = set(basket)               # create a set without duplicates
>>> fruit
set(['orange', 'pear', 'apple', 'banana'])
>>> 'orange' in fruit                 # fast membership testing
True
>>> 'crabgrass' in fruit
False
~~~


## Dictionaries

* dictionaries are indexed by keys, which can be any immutable type;
* think of a dictionary as an unordered set of key: value pairs, with the requirement that the keys are unique
* A pair of braces creates an empty dictionary: `{}`.
* keys() method of a dictionary object returns a list of all the keys used in the dictionary, in arbitrary order (if you want it sorted, just apply the sorted() function to it).
* To check whether a single key is in the dictionary, use the `in` keyword. 

~~~ python
>>> tel = {'jack': 4098, 'sape': 4139}
>>> tel['guido'] = 4127
>>> tel
{'sape': 4139, 'guido': 4127, 'jack': 4098}
>>> tel['jack']
4098
>>> del tel['sape']
>>> tel['irv'] = 4127
>>> tel
{'guido': 4127, 'irv': 4127, 'jack': 4098}
>>> tel.keys()
['guido', 'irv', 'jack']
>>> 'guido' in tel
True
~~~

###  dict() constructor 

~~~ python
# directly from sequences of key-value pairs:
>>> dict([('sape', 4139), ('guido', 4127), ('jack', 4098)])
{'sape': 4139, 'jack': 4098, 'guido': 4127}

# specify pairs using keyword arguments
>>> dict(sape=4139, guido=4127, jack=4098)
{'sape': 4139, 'jack': 4098, 'guido': 4127}
~~~


### dict comprehensions

~~~ python
>>> {x: x**2 for x in (2, 4, 6)}
{2: 4, 4: 16, 6: 36}
~~~






## Functions

### 函数定义

The first statement of the function body can optionally be a string literal; this string literal is the function’s documentation string, or docstring.

~~~ python
>>> def fib(n):    # write Fibonacci series up to n
...     """Print a Fibonacci series up to n."""
...     a, b = 0, 1
...     while a < n:
...         print a,
...         a, b = b, a+b
...
>>> # Now call the function we just defined:
... fib(2000)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597
~~~


#### 函数说明文档

Here is an example of a multi-line docstring:

~~~ python
>>> def my_function():
...     """Do nothing, but document it.
...
...     No, really, it doesn't do anything.
...     """
...     pass
...

>>> print my_function.__doc__
Do nothing, but document it.

    No, really, it doesn't do anything.

~~~


### 参数

在函数体中，默认使用参数的引用。

### 参数缺省值

Python 支持默认参数值，在定义函数时指定，之后不可更改。

~~~ python
def ask_ok(prompt, retries=4, complaint='Yes or no, please!'):
    while True:
        ok = raw_input(prompt)
        if ok in ('y', 'ye', 'yes'):
            return True
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise IOError('refusenik user')
        print complaint
~~~

This function can be called in several ways:

* giving only the mandatory argument: ask_ok('Do you really want to quit?')
* giving one of the optional arguments: ask_ok('OK to overwrite the file?', 2)
* or even giving all arguments: ask_ok('OK to overwrite the file?', 2, 'Come on, only yes or no!')

~~~ python
i = 5

def f(arg=i):
    print arg

i = 6
f()         # will print 5. The default value is evaluated only once. 
~~~

~~~ python
# This makes a difference when the default is a mutable object such as a list, dictionary, or instances of most classes.

def f(a, L=[]):
    L.append(a)
    return L

print f(1)
print f(2)
print f(3)

~~~

This will print

~~~
[1]
[1, 2]
[1, 2, 3]
~~~

If you don’t want the default to be shared between subsequent calls, you can write the function like this instead:

~~~ python
def f(a, L=None):
    if L is None:
        L = []
    L.append(a)
    return L
~~~


### 使用 参数名（Keyword Arguments） 调用函数

* 参数表类似 hash table。
* 使用参数名调用函数时，基于位置的参数传入要放在前面。

~~~ python
def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    print "-- This parrot wouldn't", action,
    print "if you put", voltage, "volts through it."
    print "-- Lovely plumage, the", type
    print "-- It's", state, "!"

parrot(1000)                                          # 1 positional argument
parrot(voltage=1000)                                  # 1 keyword argument
parrot(voltage=1000000, action='VOOOOOM')             # 2 keyword arguments
parrot(action='VOOOOOM', voltage=1000000)             # 2 keyword arguments
parrot('a million', 'bereft of life', 'jump')         # 3 positional arguments
parrot('a thousand', state='pushing up the daisies')  # 1 positional, 1 keyword


~~~


### `*name` 收拢基于位置的参数，`**name` 基于名字的参数

* `*name` must occur before `**name`

~~~ python
def cheeseshop(kind, *arguments, **keywords):
    print "-- Do you have any", kind, "?"
    print "-- I'm sorry, we're all out of", kind
    for arg in arguments:
        print arg
    print "-" * 40
    keys = sorted(keywords.keys())
    for kw in keys:
        print kw, ":", keywords[kw]
~~~

It could be called like this:

~~~ python
cheeseshop("Limburger", "It's very runny, sir.",
           "It's really very, VERY runny, sir.",
           shopkeeper='Michael Palin',
           client="John Cleese",
           sketch="Cheese Shop Sketch")
~~~

it would print:

~~~
-- Do you have any Limburger ?
-- I'm sorry, we're all out of Limburger
It's very runny, sir.
It's really very, VERY runny, sir.
----------------------------------------
client : John Cleese
shopkeeper : Michael Palin
sketch : Cheese Shop Sketch
~~~



### 以 list 或 [dict] 方式传参 ， Unpacking Argument Lists

~~~ python
# write the function call with the *-operator to unpack the arguments out of a list or tuple:
>>> range(3, 6)             # normal call with separate arguments
[3, 4, 5]
>>> args = [3, 6]
>>> range(*args)            # call with arguments unpacked from a list
[3, 4, 5]
~~~

~~~ python
# 同样，dictionaries can deliver keyword arguments with the **-operator
>>> def parrot(voltage, state='a stiff', action='voom'):
...     print "-- This parrot wouldn't", action,
...     print "if you put", voltage, "volts through it.",
...     print "E's", state, "!"
...
>>> d = {"voltage": "four million", "state": "bleedin' demised", "action": "VOOM"}
>>> parrot(**d)
-- This parrot wouldn't VOOM if you put four million volts through it. E's bleedin' demised !
~~~


### Lambda Expressions

* Small anonymous functions can be created with the lambda keyword. 
* Lambda functions can be used wherever function objects are required.

~~~ python
>>> def make_incrementor(n):
...     return lambda x: x + n
...
>>> f = make_incrementor(42)
>>> f(0)
42
>>> f(1)
43
~~~

Another use is to pass a small function as an argument:

~~~ python
>>> pairs = [(1, 'one'), (2, 'two'), (3, 'three'), (4, 'four')]
>>> pairs.sort(key=lambda pair: pair[1])
>>> pairs
[(4, 'four'), (1, 'one'), (3, 'three'), (2, 'two')]
~~~


### 作用域、全局变量访问



### 引用函数、函数变量

~~~ python
>>> fib
<function fib at 10042ed0>
>>> f = fib
>>> f(100)
0 1 1 2 3 5 8 13 21 34 55 89
~~~



### 返回值

没有 return 的函数，默认返回 'None' （built-in name）

~~~ python
>>> fib(0)
>>> print fib(0)
None
~~~



## built-in functions

### filter(function, sequence)

~~~ python
>>> def f(x): return x % 3 == 0 or x % 5 == 0
...
>>> filter(f, range(2, 25))
[3, 5, 6, 9, 10, 12, 15, 18, 20, 21, 24]
~~~

### map(function, sequence)

~~~ python
>>> def cube(x): return x*x*x
...
>>> map(cube, range(1, 11))
[1, 8, 27, 64, 125, 216, 343, 512, 729, 1000]
~~~

More than one sequence may be passed;

~~~ python
>>> seq = range(8)
>>> def add(x, y): return x+y
...
>>> map(add, seq, seq)
[0, 2, 4, 6, 8, 10, 12, 14]
~~~


### reduce(function, sequence)

* returns a single value constructed by calling the binary function function on the first two items of the sequence, then on the result and the next item, and so on.
* If there’s only one item in the sequence

~~~ python
>>> def add(x,y): return x+y
...
>>> reduce(add, range(1, 11)) # 1+2+3+4+5+6+7+8+9+10 = 55
55
~~~


* its value is returned; if the sequence is empty, an exception is raised.
  * A third argument can be passed to indicate the starting value. 
    ~~~ python
    >>> def sum(seq):
    ...     def add(x,y): return x+y
    ...     return reduce(add, seq, 0)
    ...
    >>> sum(range(1, 11))
    55
    >>> sum([])
    0
    ~~~




## Module

* A module is a file containing Python definitions and statements.
* The file name is the module name with the suffix .py appended.
* Within a module, the module’s name (as a string) is available as the value of the global variable __name__.

### 简单例子 / import some-module

~~~ python
# fibo.py
# Fibonacci numbers module

def fib(n):    # write Fibonacci series up to n
    a, b = 0, 1
    while b < n:
        print b,
        a, b = b, a+b

def fib2(n):   # return Fibonacci series up to n
    result = []
    a, b = 0, 1
    while b < n:
        result.append(b)
        a, b = b, a+b
    return result
~~~

~~~ python
>>> import fibo
>>> fibo.fib(1000)
1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
>>> fibo.fib2(100)
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
>>> fibo.__name__
'fibo'

# If you intend to use a function often you can assign it to a local name:
>>> fib = fibo.fib
>>> fib(500)
1 1 2 3 5 8 13 21 34 55 89 144 233 377
~~~

### import some-module as the-alias

~~~ python
>>> import fibo as fib
>>> fib.fib(500)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377
~~~


### from some-module import functions

~~~ python
#  in the example, fibo is not defined
>>> from fibo import fib, fib2
>>> fib(500)
1 1 2 3 5 8 13 21 34 55 89 144 233 377

# import all names that a module defines:
# imports all names except those beginning with an underscore (_).
>>> from fibo import *
>>> fib(500)
1 1 2 3 5 8 13 21 34 55 89 144 233 377
~~~

~~~ python
>>> from fibo import fib as fibonacci
>>> fibonacci(500)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377
~~~

### `__name__`

* `import the-module-name` 方式引入时， `__name__` = the-module-name
* `python the-module-name.py <arguments>` 作为脚本执行时， `__name__ == "__main__"`
~~~ python
# If the module is imported, the code is not run
if __name__ == "__main__":
    import sys
    fib(int(sys.argv[1]))
~~~

~~~ shell
$ python fibo.py 50
1 1 2 3 5 8 13 21 34
~~~



### The Module Search Path

* `import spam` 的搜索过程：

1. first searches for a built-in module with that name. 
2. 如果没有，在 `sys.path` 下搜索 spam.py 文件。
   `sys.path` is initialized from these locations:
      * the directory containing the input script (or the current directory).
      * `PYTHONPATH` (a list of directory names, with the same syntax as the shell variable PATH).
      * the installation-dependent default.
    程序初始化后，`sys.path` 还是可以改的。






## Packages

For example, the module name A.B designates a submodule named B in a package named A.

* 类似java中的package、DotNet的命名空间，python中用来组织 module，避免名字冲突。
* When importing the package, Python searches through the directories on sys.path looking for the package subdirectory.

* 例子：sound 包的目录结构
  ~~~
  sound/                          Top-level package
      __init__.py               Initialize the sound package
      formats/                  Subpackage for file format conversions
          __init__.py
          wavread.py
          wavwrite.py
          aiffread.py
          aiffwrite.py
          auread.py
          auwrite.py
          ...
      effects/                  Subpackage for sound effects
          __init__.py
          echo.py
          surround.py
          reverse.py
          ...
      filters/                  Subpackage for filters
          __init__.py
          equalizer.py
          vocoder.py
          karaoke.py
          ...
  ~~~
  
  * 引用方法
    ~~~ python
    import sound.effects.echo
    
    # or
    sound.effects.echo.echofilter(input, output, delay=0.7, atten=4)
    
    # or
    from sound.effects import echo
    ~~~

### Importing * From a Package

* python 不支持自动从包中搜索所有module并导入，这样很费时；要求包的作者，在 `__init__.py` 中定义 `__all__` 来说明 `from package import *` 需要导入那些name。

For example, the file sound/effects/__init__.py could contain the following code:

~~~ python
__all__ = ["echo", "surround", "reverse"]
~~~


* If `__all__` is not defined, the statement `from sound.effects import *` **does not** import all submodules from the package sound.effects into the current namespace; it only ensures that the package sound.effects has been imported (possibly running any initialization code in __init__.py) and then imports whatever names are defined in the package. This includes any names defined (and submodules explicitly loaded) by __init__.py. 














## DEBUG

### dir()

The built-in function dir() is used to find out which names a module defines. 

~~~ python
>>> import fibo, sys
>>> dir(fibo)
['__name__', 'fib', 'fib2']
>>> dir(sys)  
['__displayhook__', '__doc__', '__excepthook__', '__name__', '__package__',
 '__stderr__', '__stdin__', '__stdout__', '_clear_type_cache',
 '_current_frames', '_getframe', '_mercurial', 'api_version', 'argv',
 'builtin_module_names', 'byteorder', 'call_tracing', 'callstats',
 'copyright', 'displayhook', 'dont_write_bytecode', 'exc_clear', 'exc_info',
 'exc_traceback', 'exc_type', 'exc_value', 'excepthook', 'exec_prefix',
 'executable', 'exit', 'flags', 'float_info', 'float_repr_style',
 'getcheckinterval', 'getdefaultencoding', 'getdlopenflags',
 'getfilesystemencoding', 'getobjects', 'getprofile', 'getrecursionlimit',
 'getrefcount', 'getsizeof', 'gettotalrefcount', 'gettrace', 'hexversion',
 'long_info', 'maxint', 'maxsize', 'maxunicode', 'meta_path', 'modules',
 'path', 'path_hooks', 'path_importer_cache', 'platform', 'prefix', 'ps1',
 'py3kwarning', 'setcheckinterval', 'setdlopenflags', 'setprofile',
 'setrecursionlimit', 'settrace', 'stderr', 'stdin', 'stdout', 'subversion',
 'version', 'version_info', 'warnoptions']
~~~

### 打印 print, format

* print
  * by default it adds spaces between its arguments.
* format

~~~ python
>>> for x in range(1, 11):
...     print repr(x).rjust(2), repr(x*x).rjust(3),
...     # Note trailing comma on previous line
...     print repr(x*x*x).rjust(4)

>>> for x in range(1,11):
...     print '{0:2d} {1:3d} {2:4d}'.format(x, x*x, x*x*x)
...
~~~

#### padding space / zero

[str.rjust]: https://docs.python.org/2/library/stdtypes.html#str.rjust
[str.ljust]: https://docs.python.org/2/library/stdtypes.html#str.ljust
[str.center]: https://docs.python.org/2/library/stdtypes.html#str.center
[str.zfill]: https://docs.python.org/2/library/stdtypes.html#str.zfill

* [str.rjust]、[str.ljust]、[str.center]
  * the `str.rjust()` method of string objects, which right-justifies a string in a field of a given width by padding it with spaces on the left. 

* [str.zfill]
  * str.zfill(), which pads a numeric string on the left with zeros.

~~~ python
>>> print '[' + '3'.ljust(5) + ']'
[3    ]
>>> print '[' + '3'.rjust(5) + ']'
[    3]
>>> print '[' + '3'.center(5) + ']'
[  3  ]

>>> '12'.zfill(5)
'00012'
>>> '-3.14'.zfill(7)
'-003.14'
>>> '3.14159265359'.zfill(5)
'3.14159265359'
~~~



#### [str.format()]

[str.format()]: https://docs.python.org/2/library/stdtypes.html#str.format

~~~ python
>>> print 'We are the {} who say "{}!"'.format('knights', 'Ni')
We are the knights who say "Ni!"

>>> print '{0} and {1}'.format('spam', 'eggs')
spam and eggs
>>> print '{1} and {0}'.format('spam', 'eggs')
eggs and spam

>>> print 'This {food} is {adjective}.'.format(
...       food='spam', adjective='absolutely horrible')
This spam is absolutely horrible.
~~~

'!s' (apply str()) and '!r' (apply repr()) can be used to convert the value before it is formatted.

~~~ python
>>> import math
>>> print 'The value of PI is approximately {}.'.format(math.pi)
The value of PI is approximately 3.14159265359.
>>> print 'The value of PI is approximately {!r}.'.format(math.pi)
The value of PI is approximately 3.141592653589793.
~~~

An optional ':' and format specifier can follow the field name.

~~~ python
>>> import math
>>> print 'The value of PI is approximately {0:.3f}.'.format(math.pi)
The value of PI is approximately 3.142.
~~~

Passing an integer after the ':' will cause that field to be a minimum number of characters wide. This is useful for making tables pretty.

~~~ python
>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 7678}
>>> for name, phone in table.items():
...     print '{0:10} ==> {1:10d}'.format(name, phone)
...
Jack       ==>       4098
Dcab       ==>       7678
Sjoerd     ==>       4127
~~~

simply passing the dict and using square brackets '[]' to access the keys

~~~ python
>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
>>> print ('Jack: {0[Jack]:d}; Sjoerd: {0[Sjoerd]:d}; '
...        'Dcab: {0[Dcab]:d}'.format(table))
Jack: 4098; Sjoerd: 4127; Dcab: 8637678

# This could also be done by passing the table as keyword arguments with the ‘**’ notation.

>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
>>> print 'Jack: {Jack:d}; Sjoerd: {Sjoerd:d}; Dcab: {Dcab:d}'.format(**table)
Jack: 4098; Sjoerd: 4127; Dcab: 8637678
~~~





#### vars(), which returns a dictionary containing all local variables. 

[vars()]: https://docs.python.org/2/library/functions.html#vars

[vars()], which returns a dictionary containing all local variables.



#### 字符编码、字符实际值

[ord()]: https://docs.python.org/2/library/functions.html#ord

* [ord()] would get the int value of the char.
* chr() 反过来，将数值转换为字符。
* unichr()
* hex(数值) 将数值转换为十六进制字符串：0xXX

~~~ python
>>> ord('a')
97
>>> chr(97)
'a'
>>> chr(ord('a') + 3)
'd'
>>>
~~~







## Reading and Writing Files

### open()

[open()]: https://docs.python.org/2/library/functions.html#open

[open()] returns a file object, and is most commonly used with two arguments: `open(filename, mode)`.

~~~ python
>>> f = open('workfile', 'w')
>>> print f
<open file 'workfile', mode 'w' at 80a0960>
~~~


#### mode

缺省mode为 'r'

* 'r' when the file will only be read
* 'w' for only writing (an existing file with the same name will be erased)
* 'a' opens the file for appending;
* 'r+' opens the file for both reading and writing.
* 'b' appended to the mode opens the file in binary mode, so there are also modes like 'rb', 'wb', and 'r+b'. 'b' 在 Windows 上有效，为兼容Windows，如果遇到二进制文件，都加上 'b'。

### close()

When you’re done with a file, call `f.close()` to close it and free up any system resources taken up by the open file. After calling `f.close()`, attempts to use the file object will automatically fail.


#### with keyword

[with keyword]: https://docs.python.org/2/reference/compound_stmts.html#with

It is good practice to use the [with keyword] when dealing with file objects.

This has the advantage that the file is properly closed after its suite finishes, even if an exception is raised on the way. 

等价于 try-finally blocks，但是更简洁。

~~~ python
>>> with open('workfile', 'r') as f:
...     read_data = f.read()
>>> f.closed
True
~~~


### read(size)

To read a file’s contents, call f.read(size), which reads some quantity of data and returns it as a string. size is an optional numeric argument. When size is omitted or negative, the entire contents of the file will be read and returned; it’s your problem if the file is twice as large as your machine’s memory. Otherwise, at most size bytes are read and returned. If the end of the file has been reached, f.read() will return an empty string ("").

~~~ python
>>> f.read()
'This is the entire file.\n'
>>> f.read()
''
~~~

### f.readline() 

f.readline() reads a single line from the file; a newline character (`\n`) is left at the end of the string, and is only omitted on the last line of the file if the file doesn’t end in a newline. This makes the return value unambiguous; if f.readline() returns an empty string, the end of the file has been reached, while a blank line is represented by '`\n`', a string containing only a single newline.

~~~ python
>>> f.readline()
'This is the first line of the file.\n'
>>> f.readline()
'Second line of the file\n'
>>> f.readline()
''
~~~


###  for-loop over the file object

For reading lines from a file, you can loop over the file object. This is memory efficient, fast, and leads to simple code:

~~~ python
>>> for line in f:
        print line,

This is the first line of the file.
Second line of the file
~~~


### write(string) 

`f.write(string)` writes the contents of string to the file, returning None.

~~~ python
>>> f.write('This is a test\n')

To write something other than a string, it needs to be converted to a string first:

>>> value = ('the answer', 42)
>>> s = str(value)
>>> f.write(s)
~~~


### 文件指针位置

* `f.tell()` returns an integer giving the file object’s current position in the file, measured in bytes from the beginning of the file.

* To change the file object’s position, use `f.seek(offset, from_what)`. 
  * `from_what` value of 
    * 缺省为 0 measures from the beginning of the file
    * 1 uses the current file position
    * 2 uses the end of the file as the reference point.

~~~ python
>>> f = open('workfile', 'r+')
>>> f.write('0123456789abcdef')
>>> f.seek(5)      # Go to the 6th byte in the file
>>> f.read(1)
'5'
>>> f.seek(-3, 2)  # Go to the 3rd byte before the end
>>> f.read(1)
'd'
~~~




## json module

[module-json]: https://docs.python.org/2/library/json.html#module-json
[json.dumps()]: https://docs.python.org/2/library/json.html#json.dumps
[json.dump()]: https://docs.python.org/2/library/json.html#json.dump

The standard module called [json][module-json] can take Python data hierarchies, and convert them to string representations; this process is called __serializing__. 

Reconstructing the data from the string representation is called __deserializing__.

[json.dumps()] : object -> json string

~~~ python
# object -> json string
>>> import json
>>> json.dumps([1, 'simple', 'list'])
'[1, "simple", "list"]'
~~~


### save / load json object

~~~ python
# This simple serialization technique can handle lists and dictionaries, but serializing arbitrary class instances in JSON requires a bit of extra effort. 

json.dump(x, f)

# To decode the object again
x = json.load(f)
~~~




## Errors and Exceptions

[Built-in Exceptions]: https://docs.python.org/2/library/exceptions.html#bltin-exceptions


There are (at least) two distinguishable kinds of errors: __syntax errors__ and __exceptions__.

* __syntax errors__ 顾名思义，代码写错了。根据提示修改就好。

* Exceptions

  ~~~ python
  >>> 10 * (1/0)
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ZeroDivisionError: integer division or modulo by zero
  >>> 4 + spam*3
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  NameError: name 'spam' is not defined
  >>> '2' + 2
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  TypeError: cannot concatenate 'str' and 'int' objects
  ~~~

自带的Exception参见： [Built-in Exceptions]



### handle exeception, try...except...

~~~ python
>>> while True:
...     try:
...         x = int(raw_input("Please enter a number: "))
...         break
...     except ValueError:
...         print "Oops!  That was no valid number.  Try again..."
...     except (RuntimeError, TypeError, NameError):
...         pass
~~~

#### 引用exception

~~~ python
except ValueError as e:

# or

except ValueError, e:
~~~

~~~ python
>>> try:
...     raise Exception('spam', 'eggs')
... except Exception as inst:
...     print type(inst)     # the exception instance
...     print inst.args      # arguments stored in .args
...     print inst           # __str__ allows args to be printed directly
...     x, y = inst.args
...     print 'x =', x
...     print 'y =', y
...
<type 'exceptions.Exception'>
('spam', 'eggs')
('spam', 'eggs')
x = spam
y = eggs
~~~



#### raise 关键字： 重新抛出exception

[raise-keyword]: https://docs.python.org/2/reference/simple_stmts.html#raise

The [raise][raise-keyword] statement allows the programmer to force a specified exception to occur. 

~~~ python
import sys

try:
    f = open('myfile.txt')
    s = f.readline()
    i = int(s.strip())
except IOError as e:
    print "I/O error({0}): {1}".format(e.errno, e.strerror)
except ValueError:
    print "Could not convert data to an integer."
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise
~~~

~~~ python
>>> raise NameError('HiThere')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: HiThere
~~~

If you need to determine whether an exception was raised but don’t intend to handle it, a simpler form of the raise statement allows you to **re-raise** the exception:

~~~ python
>>> try:
...     raise NameError('HiThere')
... except NameError:
...     print 'An exception flew by!'
...     raise
...
An exception flew by!
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
NameError: HiThere
~~~



#### try...except...else

an optional `else` clause, which, when present, must follow all `except` clauses.

如果 try block 中没有抛出exception，就执行 `else` block中的代码。

~~~ python
for arg in sys.argv[1:]:
    try:
        f = open(arg, 'r')
    except IOError:
        print 'cannot open', arg
    else:
        print arg, 'has', len(f.readlines()), 'lines'
        f.close()
~~~


### User-defined Exceptions

* 从 Exception 类继承

~~~ python
>>> class MyError(Exception):
...     def __init__(self, value):
...         self.value = value
...     def __str__(self):
...         return repr(self.value)
...
>>> try:
...     raise MyError(2*2)
... except MyError as e:
...     print 'My exception occurred, value:', e.value
...
My exception occurred, value: 4
>>> raise MyError('oops!')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
__main__.MyError: 'oops!'
~~~

~~~ python
class Error(Exception):
    """Base class for exceptions in this module."""
    pass

class InputError(Error):
    """Exception raised for errors in the input.

    Attributes:
        expr -- input expression in which the error occurred
        msg  -- explanation of the error
    """

    def __init__(self, expr, msg):
        self.expr = expr
        self.msg = msg

class TransitionError(Error):
    """Raised when an operation attempts a state transition that's not
    allowed.

    Attributes:
        prev -- state at beginning of transition
        next -- attempted new state
        msg  -- explanation of why the specific transition is not allowed
    """

    def __init__(self, prev, next, msg):
        self.prev = prev
        self.next = next
        self.msg = msg
~~~




### Defining Clean-up Actions: `finally`

In real world applications, the finally clause is useful for releasing external resources (such as files or network connections), regardless of whether the use of the resource was successful.

~~~ python
>>> try:
...     raise KeyboardInterrupt
... finally:
...     print 'Goodbye, world!'
...
Goodbye, world!
KeyboardInterrupt
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
~~~

~~~ python
>>> def divide(x, y):
...     try:
...         result = x / y
...     except ZeroDivisionError:
...         print "division by zero!"
...     else:
...         print "result is", result
...     finally:
...         print "executing finally clause"
...
>>> divide(2, 1)
result is 2
executing finally clause
>>> divide(2, 0)
division by zero!
executing finally clause
>>> divide("2", "1")
executing finally clause
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in divide
TypeError: unsupported operand type(s) for /: 'str' and 'str'
~~~

### Predefined Clean-up Actions: `with`

Some objects define standard clean-up actions.

~~~ python
with open("myfile.txt") as f:
    for line in f:
        print line,
~~~



## OOP

* the class inheritance mechanism allows multiple base classes,
* a derived class can override any methods of its base class or classes, 
* a method can call the method of a base class with the same name. 
* classes are created at runtime, and can be modified further after creation.

### Namespace

* __The namespace containing the built-in names__ is created when the Python interpreter starts up, and is never deleted.
* __The global namespace for a module__ is created when the module definition is read in; normally, module namespaces also last until the interpreter quits. 


At any time during execution, there are at least three nested scopes whose namespaces are directly accessible:

* the innermost scope, which is searched first, contains the local names
* the scopes of any enclosing functions, which are searched starting with the nearest enclosing scope, contains non-local, but also non-global names
* the next-to-last scope contains the current module’s global names
* the outermost scope (searched last) is the namespace containing built-in names

### 定义类

~~~ python
class ClassName:
    <statement-1>
    .
    .
    .
    <statement-N>
~~~

* When a class definition is left normally (via the end), a class object is created. 


### Class Objects

* Class objects support two kinds of operations: attribute references and instantiation.
* 类的方法第一个参数必须是 `self`

~~~ python
class MyClass:
    """A simple example class"""
    i = 12345

    def f(self):
        return 'hello world'
~~~

* attribute `MyClass.__doc__` , returning the docstring belonging to the class: "A simple example class".
* attribute `MyClass.i` , an integer 
* attribute `MyClass.f` , a function object


### Class instantiation 实例化 & 构造函数

~~~ python
# The instantiation operation creates an empty object. 
# assigns this object to the local variable x.
x = MyClass()
~~~

构造函数名为 `__init__()` , class instantiation automatically invokes __init__() for the newly-created class instance. 

1. 构造函数，简单例子
    ~~~ python
    def __init__(self):
        self.data = []
    ~~~

2. 构造函数，带参数的例子
    ~~~ python
    >>> class Complex:
    ...     def __init__(self, realpart, imagpart):
    ...         self.r = realpart
    ...         self.i = imagpart
    ...
    >>> x = Complex(3.0, -4.5)
    >>> x.r, x.i
    (3.0, -4.5)
    ~~~



### Instance Objects

* The only operations understood by instance objects are attribute references
* There are two kinds of valid attribute names, __data attributes__ and __methods__.


### Method Objects






































## Python 编码规范

[PEP 8]: https://www.python.org/dev/peps/pep-0008

For Python, [PEP 8] has emerged as the style guide that most projects adhere to;

* Use 4-space indentation, and no tabs.
* Wrap lines so that they don’t exceed 79 characters.
* Use blank lines to separate functions and classes, and larger blocks of code inside functions.
* When possible, put comments on a line of their own.
* Use docstrings.
* Use spaces around operators and after commas, but not directly inside bracketing constructs: `a = f(1, 2) + g(3, 4)`.
* use `CamelCase` for classes and `ower_case_with_underscores` for functions and methods.
* 
* 








































