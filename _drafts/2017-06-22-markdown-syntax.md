---
layout: post
title: markdown 语法基础
categories: [dev, markdown]
tags: 
  - markdown
  - document
---

参考：
  * <https://about.gitlab.com/2016/07/19/markdown-kramdown-tips-and-tricks/>


### 字体格式

#### 粗体

&lt;b&gt;html粗体标记&lt;/b&gt;   <mark>效果：</mark> <b>html粗体标记</b>.

<span markdown="0">**bold text**</span>   <mark>效果：</mark>  **bold text**


#### 斜体

&lt;i&gt;html斜体标记&lt;/i&gt;    <mark>效果：</mark> <i>html斜体标记</i>.

<span markdown="0">*italic text*</span>    <mark>效果：</mark> *italic text*

<span markdown="0">_斜体_</span>    <mark>效果：</mark> _斜体_


#### 下划线

&lt;u&gt;Underlining content&lt;/u&gt;    <mark>效果：</mark> <u>Underlining content</u>



#### &lt;sub&gt;

This text <sub>lays low</sub> and chills a bit.


#### &lt;sup&gt;

This text <sup>gets high</sup> above the clouds.


#### &lt;mark&gt;

Let's <mark>mark this hint</mark> to give you a clue.








### 排版

#### 列表

##### &lt;ol&gt; 有序列表

~~~
1. Ordered List
2. Second List Item
3. Third List Item
    4. Second Level First Item
    4. Second Level Second Item
    4. Second Level Third Item
        5. And a third level First Item
        5. And a third level Second Item
        5. And a third level Third Item
4. Fourth List Item
5. Fifth List Item
~~~

<mark>效果：</mark>

1. Ordered List
2. Second List Item
3. Third List Item
    4. Second Level First Item
    4. Second Level Second Item
    4. Second Level Third Item
        5. And a third level First Item
        5. And a third level Second Item
        5. And a third level Third Item
4. Fourth List Item
5. Fifth List Item

###### 跨段落的有序列表

* 参考： <http://idratherbewriting.com/documentation-theme-jekyll/mydoc_lists.html#key-principle-to-remember-with-lists>

关键是要用“空格”对其，序号是1-9的时候，用2个空格，序号到10及以上的时候，用一个空格。如下例。

注意，这个只对 kramdown-flavored Markdown ，其他 markdown 风格不一定有用。

![](liningup.png)

##### &lt;ul&gt; 无序列表

~~~
- Unordered List
- Second List Item
- Third List Item
    + Second Level First Item
    + Second Level Second Item
    + Second Level Third Item
        * And a third level First Item
        * And a third level Second Item
        * And a third level Third Item
- Fourth List Item
- Fifth List Item
~~~

<mark>效果：</mark>

- Unordered List
- Second List Item
- Third List Item
    + Second Level First Item
    + Second Level Second Item
    + Second Level Third Item
        * And a third level First Item
        * And a third level Second Item
        * And a third level Third Item
- Fourth List Item
- Fifth List Item





#### 脚注

创建一个页面内跳转的连接，点击跳转到脚注说明的地方。

例如：

~~~
If you need footnotes for your posts, articles and entries, the Kramdown-Parser [^1] got you covered. How to use footnotes? Read this footnote. [^2]

... ...

[^1]: Find out more about Kramdown on <http://kramdown.gettalong.org/>
[^2]: Kramdown has an excellent documentation of all its features. Check out, on how to [footnotes](http://kramdown.gettalong.org/syntax.html#footnotes).
~~~


#### &lt;dl&gt; Definition Lists

~~~
Definition List
:   Bacon ipsum dolor sit amet spare ribs brisket ribeye, andouille sirloin bresaola frankfurter corned beef capicola bacon. Salami beef ribs sirloin, short loin hamburger shoulder t-bone.

Beef ribs jowl swine porchetta
:   Sirloin tenderloin swine frankfurter pork loin pork capicola ham hock strip steak ribeye beef ribs. Hamburger t-bone ribeye ham prosciutto bresaola.
~~~

<mark>效果：</mark>

Definition List
:   Bacon ipsum dolor sit amet spare ribs brisket ribeye, andouille sirloin bresaola frankfurter corned beef capicola bacon. Salami beef ribs sirloin, short loin hamburger shoulder t-bone.

Beef ribs jowl swine porchetta
:   Sirloin tenderloin swine frankfurter pork loin pork capicola ham hock strip steak ribeye beef ribs. Hamburger t-bone ribeye ham prosciutto bresaola.




#### &lt;blockquote&gt; Quotation

~~~
<blockquote>Everything happens for a reason. (Britney Spears)</blockquote>
~~~

<mark>效果：</mark>

<blockquote>Everything happens for a reason. (Britney Spears)</blockquote>


#### &lt;blockquote&gt; and &lt;cite&gt;  together

~~~
> Age is an issue of mind over matter. If you don't mind, it doesn't matter.
<cite>Mark Twain</cite>
~~~

<mark>效果：</mark>

> Age is an issue of mind over matter. If you don't mind, it doesn't matter.
<cite>Mark Twain</cite>



### 突出显示


#### &lt;dfn&gt;

The &lt;dfn&gt; tag is a phrase tag. It defines a <dfn>definition term</dfn>.




#### &lt;abbr&gt;

The <abbr title="World Health Organization">WHO</abbr> was founded in 1948.



#### &lt;kbd&gt;

Copycats enjoy pressing <kbd>CMD</kbd> + <kbd>c</kbd> and <kbd>CMD</kbd> + <kbd>v</kbd>.






### 代码高亮

#### &lt;code&gt;


~~~
Some <code>code: lucida console</code> displayed.
~~~

<mark>效果：</mark>

Some <code>code: lucida console</code> displayed.



#### 尖角符号 \`

键盘上数字1左边的键，ESC下面的那个键

~~~
Some `code: lucida console` displayed.
~~~

<mark>效果：</mark>

Some `code: lucida console` displayed.


#### 波浪号 \~

整段代码用3个波浪号括起来

{% highlight markdown %}
~~~
<html>
    <head>
        <title>Code Blocks</title>
    </head>
    <body></body>
</html>
~~~
{% endhighlight %}

<mark>效果：</mark>

~~~
<html>
    <head>
        <title>Code Blocks</title>
    </head>
    <body></body>
</html>
~~~




### 表格

直接使用html语法






### 添加css class、ID及其他html属性

#### 示例：添加css class、ID

~~~markdown
#### A blue heading
{: .blue #blue-h}
~~~

生成

~~~html
<h4 class="blue" id="blue-h">A blue heading</h4>
~~~


#### 添加任意属性

~~~
#### A simple example
{: #custom-id style="margin-top:0"}
~~~

~~~
[CLICK ME][identifier]{: #custom-id onclick="myJsFunc();"}
~~~




### 使用 kramdown 的 markdown 语法生成目录

* 参考：
  * <https://about.gitlab.com/2016/07/19/markdown-kramdown-tips-and-tricks/#table-of-contents-toc>
  * <http://www.seanbuscay.com/blog/jekyll-toc-markdown/>
  * <https://github.com/gettalong/kramdown>
  * <https://www.zfanw.com/blog/jekyll-table-of-content.html>

~~~
无序列表的目录

* TOC
{:toc}

有序列表的目录

1. TOC
{:toc}

带样式的目录

<div class="panel radius" markdown="1">
**Table of Contents**
{: #toc }
*  TOC
{:toc}
</div>
~~~
