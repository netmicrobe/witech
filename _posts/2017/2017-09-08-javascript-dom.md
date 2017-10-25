---
layout: post
title: JavaScript DOM, Document Object Model
categories: [dev, web]
tags: [JavaScript, oop, object-oriented, dom]
---

* 参考
  * 《 Object-Oriented JavaScript 》.2nd - Stoyan.Stefanov
  * [Document Object Model (DOM) Level 1 Specification - Version 1.0 - W3C Recommendation 1 October, 1998](https://www.w3.org/TR/DOM-Level-1/)

DOM 是以树型的数据结构，用来操作XML & HTML 文档的API。API 是 language-independent ，除了 javascript，其他语言也能实现。

<!-- more -->

## 如何查看 DOM 对象的类型

1. 浏览器
2. <kbd>F12</kbd>
3. 控制台 》 Elements 》 Properties

![](如何查看DOM对象的类型.png)


## Core DOM & HTML DOM

DOM 是以树型的数据结构，用来操作XML & HTML 文档的API。HTML 是 XML 的子集，有些对象，例如，`HTMLDocument` 在 XML 的 DOM（即 Core DOM）是没有的，Core DOM 只有 `Document`。

## 访问 DOM Node

* 样例 html document

    ~~~ html
    <!DOCTYPE html>
    <html>
    <head>
    <title>My page</title>
    </head>
    <body>
    <p class="opener">first paragraph</p>
    <p><em>second</em> paragraph</p>
    <p id="closer">final</p>
    <!-- and that's about it -->
    </body>
    </html>
    ~~~

### document

document gives you access to the current document. 

~~~ javascript
> document.nodeType;
9
> document.nodeName;
"#document"
> document.nodeValue;
null
~~~

#### document.write()

document.write() allows you to insert HTML into the page while the
page is being loaded.

If you try it after page load, it will replace the content of the whole page.


~~~ html
<p>It is now
<script>
document.write("<em>" + new Date() + "</em>");
</script>
</p>
~~~

结果：

~~~ html
<p>It is now
<em>Fri Apr 26 2013 16:55:16 GMT-0700 (PDT)</em>
</p>
~~~



#### document.cookie

`document.cookie` is a property that contains a string. This string is the content of the
cookies exchanged between the server and the client. When the server sends a page
to the browser, it may include the `Set-Cookie` HTTP header. When the client sends
a request to the server, it sends the cookie information back with the Cookie header.

~~~ javascript
> document.cookie;
"mbox=check#true#1356053765|session#1356053704195-121286#1356055565;...
~~~


#### document.title

`document.title` allows you to change the title of the page displayed in the browser window. 

~~~ javascript
> document.title = 'My title';
"My title"
~~~

#### document.referrer

`document.referrer` tells you **the URL of the previously-visited page** . 

This is the same value the browser sends in the `Referer` HTTP header when requesting the page. 


#### document.domain 

`document.domain` gives you access to the domain name of the currently loaded page. 




#### document.documentElement

For HTML documents, the root is the <html> tag.

~~~ javascript
> document.documentElement;
<html>...</html>
> document.documentElement.nodeType; // 1 = Element，2 = attributes， 3 = text
1

> document.documentElement.nodeName;
"HTML"
> document.documentElement.tagName;
"HTML"
~~~


### Child nodes : hasChildNodes(), childNodes, parentNode

~~~ javascript
> document.documentElement.hasChildNodes();
true

// The HTML element has three children, the head and the body elements and the
// whitespace between them (whitespace is counted in most, but not all browsers). 

> document.documentElement.childNodes.length;
3
> document.documentElement.childNodes[0];
<head>...</head>
> document.documentElement.childNodes[1];
#text
> document.documentElement.childNodes[2];
<body>...</body>

> document.documentElement.childNodes[1].parentNode;
<html>...</html>

~~~

* childNodes 数目计算的例子

    ~~~ html
    <body>
    <p class="opener">first paragraph</p>
    <p><em>second</em> paragraph</p>
    <p id="closer">final</p>
    <!-- and that's about it -->
    </body>
    ~~~

    ~~~ javascript
    // assign a reference to body
    > var bd = document.documentElement.childNodes[2];
    > bd.childNodes.length;
    9

    // 9 = 3 个 <p> + 1 个注释 + 5 个标签之间的空白字符 text node
    ~~~


### Attributes : hasAttributes(), attributes, getAttribute()

~~~ javascript
> var bd = document.documentElement.childNodes[2];
> bd.childNodes[1]; // childNodes[0] 是个空白字符（换行）的text node
<p class="opener">first paragraph</p>

> bd.childNodes[1].hasAttributes();
true

> bd.childNodes[1].attributes.length;
1

// 可以通过3中方式获取属性： 1. 数字索引；2. 属性名称；3. getAttribute
> bd.childNodes[1].attributes[0].nodeName;
"class"
> bd.childNodes[1].attributes[0].nodeValue;
"opener"
> bd.childNodes[1].attributes['class'].nodeValue;
"opener"
> bd.childNodes[1].getAttribute('class');
"opener"

~~~




### 访问 tag 中的内容, textContent, innerHTML



#### textContent

~~~ javascript
> bd.childNodes[1].nodeName;
"P"
> bd.childNodes[1].textContent;
"first paragraph"
~~~

>> TIP:
>
> `textContent` 不被 older IEs 支持，使用 `innerText` 效果一样。



#### innerHTML

~~~ javascript
> bd.childNodes[1].innerHTML;
"first paragraph"

// 第2段: <p><em>second</em> paragraph</p>

> bd.childNodes[3].innerHTML;
"<em>second</em> paragraph"

> bd.childNodes[3].textContent;
"second paragraph"

~~~



### 直接快速访问元素， getElementsByTagName(), getElementsByName(), getElementById()

#### getElementsByTagName()

~~~ javascript
> document.getElementsByTagName('p').length;
3

// [] 和 item() 都可以访问到其中元素
// 不推荐 item(). [] 使得语法更一致。

> document.getElementsByTagName('p')[0];
<p class="opener">first paragraph</p>
> document.getElementsByTagName('p').item(0);
<p class="opener">first paragraph</p>

> document.getElementsByTagName('p')[0].innerHTML;
"first paragraph"

> document.getElementsByTagName('p')[2];
<p id="closer">final</p>

// getElementsByTagName('*') 能获得所有元素
// IE7 之前不支持这个用法，用 document.all 替代

> document.getElementsByTagName('*').length;
8
~~~

#### getElementById()

~~~ javascript
> document.getElementById('closer');
<p id="closer">final</p>

~~~


#### getElementByClassName()

This method finds elements using their class attribute


#### querySelector()

This method finds an element using a CSS selector string


#### querySelectorAll()

This method is the same as the previous one but returns all matching elements not just the first




### Siblings ，兄弟姐妹啊

~~~ javascript
> var para = document.getElementById('closer');
> para.nextSibling;
#text
> para.previousSibling;
#text
> para.previousSibling.previousSibling;
<p>...</p>
> para.previousSibling.previousSibling.previousSibling;
#text
> para.previousSibling.previousSibling.nextSibling.nextSibling;
<p id="closer">final</p>
~~~


### body

The body element is used so often that it has its own shortcut

~~~ javascript
> document.body;
<body>...</body>
> document.body.nextSibling;
null
> document.body.previousSibling.previousSibling;
<head>...</head>
~~~



### firstChild , lastChild

~~~ javascript
// firstChild is the same as childNodes[0] and lastChild is the same as childNodes[childNodes.length - 1]:
> document.body.firstChild;
#text
> document.body.lastChild;
#text
> document.body.lastChild.previousSibling;
<!-- and that's about it -->
> document.body.lastChild.previousSibling.nodeValue;
" and that's about it "
~~~


### 遍历DOM的简单函数

~~~ javascript
function walkDOM(n) {
  do {
    console.log(n);
    if (n.hasChildNodes()) {
      walkDOM(n.firstChild);
    }
  } while (n = n.nextSibling);
}

> walkDOM(document.documentElement);
> walkDOM(document.body);

~~~



## 修改节点内容

### innerHTML= , nodeValue=

~~~ javascript
> var my = document.getElementById('closer');
> my.innerHTML = 'final!!!';
"final!!!"
> my.innerHTML = '<em>my</em> final';
"<em>my</em> final"
> my.firstChild;
<em>my</em>
> my.firstChild.firstChild;
"my"

// Another way to change text is to get the actual text node and change its nodeValue

> my.firstChild.firstChild.nodeValue = 'your';
"your"

~~~

### 修改样式

~~~ javascript
> my.style.border = "1px solid red";
"1px solid red"
> my.style.fontWeight = 'bold';
"bold"

> my.style.cssText;
"border: 1px solid red; font-weight: bold;"

> my.style.cssText += " border-style: dashed;"
"border: 1px dashed red; font-weight: bold; border-style: dashed;"
~~~


### 操作表单节点

~~~ javascript
> var input = document.querySelector('input[type=text]');
> input.name;
"q"

// 文本框内容修改
> input.value = 'my query';
"my query"

~~~


## 创建节点

### 创建节点，  createElement() , createTextNode()

~~~ javascript
> var myp = document.createElement('p');
> myp.innerHTML = 'yet another';
"yet another"
~~~




### 插入节点， appendChild() (or insertBefore(), or replaceChild()


~~~ javascript
> document.body.appendChild(myp);
<p style="border: 2px dotted blue;">yet another</p>
~~~

~~~ javascript
// creates another text node and adds it as the first child of the body
document.body.insertBefore(
  document.createTextNode('first boo!'),
  document.body.firstChild
);
~~~



### cloneNode()

The method cloneNode() does this and accepts a boolean parameter (true = deep copy with all
the children, false = shallow copy, only this node). 

~~~ javascript
> var el = document.getElementsByTagName('p')[1];
<p><em>second</em> paragraph</p>

// shallow copy，只拷贝父节点，不拷贝内容
> document.body.appendChild(el.cloneNode(false));
// 等价于
> document.body.appendChild(document.createElement('p'));

// 全部拷贝这一段
> document.body.appendChild(el.cloneNode(true));
~~~



## 删除节点

### removeChild(), replaceChild()

~~~ javascript
> var myp = document.getElementsByTagName('p')[1];
> var removed = document.body.removeChild(myp);

// 返回值
> removed;
<p>...</p>
> removed.firstChild;
<em>second</em>

// replaceChild
> var p = document.getElementsByTagName('p')[1];
> p;
<p id="closer">final</p>

> var replaced = document.body.replaceChild(removed, p);
> replaced;
<p id="closer">final</p>
~~~

Now, the body looks like the following:

~~~ html
<body>
<p class="opener">first paragraph</p>
<p><em>second</em> paragraph</p>
<!-- and that's about it -->
</body>
~~~


### removeAll()

~~~ javascript
// delete all BODY children and leave the page with an empty <body></body> 
> removeAll(document.body);
~~~



































































































