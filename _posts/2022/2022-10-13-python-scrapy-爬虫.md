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
























































