---
layout: post
title: Jekyll 将上使用 Liquid
categories: [dev, jekyll]
tags: [jekyll, liquid]
---

* 参考
  * <http://jekyllrb.com/docs/templates/>
  * <http://www.howtobuildsoftware.com/index.php/how-do/blKV/jekyll-jekyll-display-collection-by-category>
  * <https://shopify.github.io/liquid/>


## 根据属性过滤 page

{% raw %}
~~~ liquid
{% assign newcars = site.my_collection | where: "category", "new" %}
~~~
{% endraw %}



## 根据属性排序 page

{% raw %}
~~~ liquid
{% assign allcarssorted = site.my_collection | sort: "category" %}
~~~
{% endraw %}


## 依据属性对 page 分组

{% raw %}
~~~ liquid
{% assign groups = site.my_collection | group_by: "category" | sort: "name" %}

{% for group in groups %}
    {{ group.name }}
    {% for item in group.items %}
        {{item.abbrev}}
    {%endfor%}
{%endfor%}
~~~
{% endraw %}


## 遍历所有 collection

{% raw %}
~~~ liquid
{% for coll in site.collections %}

label : {{ coll.label }} <br/>
output : {{ coll.output }} <br/>

  {% for doc in coll.docs %}

  &nbsp;&nbsp; - doc.title : {{ doc.title }}<br/>
  &nbsp;&nbsp; - doc.url : {{ doc.url }}<br/>
  &nbsp;&nbsp; - doc.path : {{ doc.path }}<br/>
  &nbsp;&nbsp; - doc.date : {{ doc.date }}<br/>

  {% endfor %}
<br/><br/>
{% endfor %}
~~~
{% endraw %}


