---
layout: post
title: 2022-10-13-python-scrapy-爬虫，关联 
categories: [ dev, python ]
tags: []
---

* 参考
  * [《聚焦Python分布式爬虫必学框架Scrapy 打造搜索引擎》-作者的博客](http://projectsedu.com)
  * [django 4.1 官方文档](https://docs.djangoproject.com/zh-hans/4.1/)
  * []()



## scrapy vs requests + beautifulsoup

* requests + beautifulsoup 都是库， scrapy 是框架
* 使用scrapy 框架同时，也能使用 requests、beautifulsoup。
* scrapy 基于 twisted， 异步能力好，性能有优势
* scrapy 可以扩展，提供很多内置功能，内置 css 和 xpath selector 方便，beautifulsoup用python写的，比较慢。



## 正则表达式

* 贪婪匹配
    * 非贪婪匹配`.*` ，从字符串最后面开始，最小满足的匹配；
    * 贪婪匹配 `.*?`
    
    比如，str = "XXX出生于2011年"
    `.*(\d+)年` ： 匹配出 1年
    `.*?(\d+)年` ： 匹配出 2011年
    
* `\s` 空格等空白字符
* `\S` 与 `\s` 相反
* `\w` 即 `[A-Za-z0-9]`
* `\W` 与 `\w` 相反
* `[\u4E00-\u9FA5]` 中文字符


## 深度优先和广度优先

遍历网站的算法。

深度优先，一般使用递归方法。

~~~py
def depth_tree(tree_node):
    if tree_node is not None:
      print(tree_note._data)
      if tree_node._left is not None:
         return depth_tree(tree_node._left)
      if tree_node.right is not None:
         return depth_tree(tree_node._right)
~~~

广度优先，使用队列的方法。

~~~py
def level_queue(root);
    """利用队列实现树的广度优先遍历"""
    if root is None:
      return
    my_queue = []
    node = root
    my_queue.append(node)
    while my_queue:
        node = my_queue.pop(0)
        print(node.elem)
    if node.lchild is not None:
        my_queue.append(node.lchild)
    if node.rchild is not None:
        my_queue.append(node.rchild)
~~~


## url 去重的方法

* url 保存到数据库中
* url 保存到set 中
    缺点： 太占内存
* url 经过 md5 等方法哈希后保存到set 中
    优点： 节省内存；scrapy 用的方法
* 用 bitmap 方法，将url通过hash函数映射到某一位。
* 
* 














































