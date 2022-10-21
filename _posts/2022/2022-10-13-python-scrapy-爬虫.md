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

~~~py
import re
match_re = re.match(r".*(\d+).*", target_str)
if match_re:
    print match_re.group(1)
~~~


## 常用字符串方法

* replace(target, replacement)
* strip() 清除空格、回车等字符。
* 
* 


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


## xpath

用来在 xml 和 html 中进行定位。

* `article`   ： 选取所有 article 元素的所有子节点
* `/article`  ： 选取根元素 article
* `article/a` ： 选取所有属于 article 的子元素的 a 元素
* `//div`     ： 选取所有div 子元素（不论出现在文档任何地方）
* `article//div`  ： 选取所有属于 article 元素的后代的 div 元素，不管他在 article 之下的任何位置
* `//@class`      ： 选取所有名为 class 的属性
*  `/article/div[1]` ： 选取属于 article 子元素的第一个div 元素
*  `/article/div[last()]`  ： 选取属于 article 子元素的最后一个 div元素
*  `/article/div[last()-1]`： 选取属于 article 子元素的倒数第二个div 元素
*  `//div[@lang]`          ： 选取所有拥有lang 属性的 div元素
*  `//div[@lang='eng']`    ： 选取所有lang 属性为 eng 的 div 元素
*  `//div[contains(@class, 'icon')]` ： 选取所有 div元素，它的class属性包含 icon 属性
*  `/div/*` ： 选取属于 div 元素的所有子节点
*  `//*` ： 选取所有元素
*  `//div[@*]` ： 选取所有带属性的 div 元素
*  `/div/a | //div/p` ： 选取所有div 元素的 a 和 p 元素
*  `//span | //ul` ： 选取文档中的 span 和 url 元素
*  `article/div/p | //span` ： 选取所有属于article 元素的div 元素的 p元素，以及文档中所有的span 元素。



## CSS 选择器

* `*` ： 所有节点
* `#container` ： id 为 container 的节点
* `.container` ： class 包含 container 的节点
* `li a` ：  li 下的所有 a 节点
* `ul + p` ： ul 后面的第一个 p 元素
* `div#container > ul` ： id 为 container 的 div 的第一个 ul 子元素
* `ul ~ p` ： 与 ul 相邻的所有 p 元素
* `a[title]` ： 所有存在title 属性的 a 元素
* `a[href="http://jobbole.com"]` ： 所有 href属性为 jobbole.com 的 a元素
* `a[href*="jobbole"]` ： 所有href 属性包含 jobbole 的 a元素
* `a[href^="http"]` ： 所有href 属性值以 http开头的 a元素
* `a[href$=".jpg"]` ： 所有href 属性值以 .jpg 结尾的 a元素
* `input[type=radio]:checked` ： 所有选中状态的radio 元素
* `div:not(#container)` ： 所有id非container 的div元素
* `li:nth-child(3)` ： 第三个li 元素
* `tr:nth-child(2n)` ： 所有偶数序号的tr 元素
* `` ： 
* `` ： 



## scrapy 完成一个简单的爬虫项目

安装scrapy：

`pip install scrapy`

创建scrapy 工程：

`scrapy startproject YourSpiderProject`

创建 spider 模板： 

~~~
cd YourSpiderProject
scrapy genspider someblog www.someblog.com
~~~

* someblog.py

~~~py
import scrapy

class SomeblogSpider(scrapy.Spider):
    name = "someblog"
    allowed_domains = ["www.someblog.com"]
    start_urls = ["http://www.someblog.com"]
    
    def parse(self, response):
        re_selector = response.xpath('/*[@id="1234"]/div[1]/h1/text()')
        pass
~~~

## scrapy shell 模式

~~~sh
scrapy shell http://www.someblog.com
~~~

进入console后，可以使用 response

~~~sh
>>> title = response.xpath('/*[@id="1234"]/div[1]/h1/text()')

>>> title.extract() # 将 selector 转换为一个数组

>>> title.extract()[0]

>>> title.xpath("//*")  # 继续搜索，下面所有的节点
~~~




































