---
layout: post
title: CSS flexbox 布局
categories: [ dev, css ]
tags: [flex, css]
---


---

* REFER TO
  * [CSS : The Missing Manual 4th Edition 代码](https://github.com/sawmac/css_mm_4e)
  * [W3C - CSS Flexible Box Layout Module Level 1](https://drafts.csswg.org/css-flexbox/)

---

**Flexbox**, short for _flexible box_, adds another layout mode called _flex layout_.

* 支持
  * Internet Explorer 11 and up
  * Chrome, Safari, Opera, and Firefox
* 支持，但是要加 vendor prefix
  * Safari


## Flexbox Basics

On the surface, flexbox is pretty simple. There are only two components you need
to make it work:

1. The Flex container.
    Any HTML element can be a flex container, but usually you’ll use a <div> or some
    other structural HTML tag. The tag you use for the flex container will contain
    children and other tags that make up the second part of the flexbox model.

2. Flex items.
    * Every direct child of the container element is automatically turned into a _flex item_.
    * the child tags 可以是任务tag，也可以不是同一种类型的 type.
    * 只有children tags 可以成为 flex items，grandchildren tags 不行。


### 例子

~~~ html
<div class="container">
<div>A flex item</div>
<div>Another flex item</div>
<div>A third flex item</div>
</div>
~~~

Unfortunately, at the time of this writing, Safari requires a vendor prefix for this
property, so to make the above CSS work in all current browsers including Safari,
you would write:

~~~ css
.container {
  display: -webkit-flex;
  display: flex;
}
~~~


{% iframe basic_sample %}
<html>
<head>
  <style>
  .flex-basic-container {
    display: -webkit-flex;
    display: flex;
  }
  .flex-basic-container div {
    border: 1px solid red;
    background-color: lightgray;
  }
  </style>
</head>
<body>
  <div class="flex-basic-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
</body>
</html>
{% endiframe %}



~~~ css
/* make the divs inside the container the same width and fill up the
container by simply giving those divs a flex property with a value of 1
*/
.container div {
  -webkit-flex: 1;
  flex: 1;
}
~~~


{% iframe basic_sample_same_width %}
<html>
<head>
  <style>
  .flex-basic-container {
    display: -webkit-flex;
    display: flex;
  }
  .flex-basic-container div {
    border: 1px solid red;
    background-color: lightgray;
    flex: 1;
    -webkit-flex: 1;
  }
  </style>
</head>
<body>
  <div class="flex-basic-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
</body>
</html>
{% endiframe %}


~~~ css
/* This nth-of-type selector simply selects every div starting at the second
one
1n+2 表示从第二个开始，除1余数为0
*/
.container div:nth-of-type(1n+2) {
  margin-left: 20px;
}
~~~



{% iframe basic_sample_nth_from_2 %}
<html>
<head>
  <style>
  .flex-basic-container {
    display: -webkit-flex;
    display: flex;
  }
  .flex-basic-container div {
    border: 1px solid red;
    background-color: lightgray;
    flex: 1;
    -webkit-flex: 1;
  }
  .flex-basic-container div:nth-of-type(1n+2) {
    margin-left: 20px;
  }
  </style>
</head>
<body>
  <div class="flex-basic-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
</body>
</html>
{% endiframe %}





## Flex Container Properties

### display 属性值 flex

~~~ css
display: -webkit-flex
display: flex;
~~~

### Flex-Flow

Flex items 缺省情况下，水平排列，且一直不换行。

flex-flow property 控制 flex items 垂直或者水平排序，是否可以换行。

* Flex-flow requires two values, separated by a space. 
  * The first is the direction, there are four possible settings:
    *  **row** is the normal setting. It displays flex items side by side, with the first item in the HTML source code being the left-most item, and the last item in the HTML source on the right.
    * **row-reverse** also displays the flex items side by side, but reverses their order on screen. In other words, the last item to appear in the HTML source appears on the leftmost side of the container, and the first item in the HTML source appears at the right side of the container.
    * **column** displays the flex items as stacked blocks one on top of the other. 和div标签的默认效果一样。在respective 布局的时候，比较方便，手机屏幕使用column方式，电脑屏幕使用row方式。
    * **column-reverse** 和 **column** 类似，除了 flex items 堆叠的方向是从下而上的。


  * the second is whether the item can wrap. There are three possible values:
    * **nowrap** 默认行为，就是不换行，不管窗口有多小，就是全部挤到里面。
    * **wrap** lets items that don’t fit inside the container’s width drop down to a new
    row (or over to a new column) as pictured in the top image in Figure 17-4. In
    order for flex items to wrap onto new rows (or columns), you’ll also need to set
    some values on the flex items.
    * **wrap-reverse** is like the wrap option, but wraps items in a reverse order.


#### flex-direction , flex-wrap

~~~ css
flex-flow: row wrap;

/* 等价于 */

flex-direction: row;
flex-wrap: wrap;
~~~



### Justify-content

* The `justify-content` property determines where a browser should place the flex items within the row. 
* This property only works if the flex items have set widths and if the total width of the items is less than the flex container. 
* If you’re using `flex widths` for flex items, the justify-content property has no effect at all. 

There are five possible values for this property:

* `flex-start` aligns items to the left of the row. Confusingly, if you choose the `row-reverse` direction, the flex-start option aligns all items to the left.
* `flex-end` aligns items to the right side of the row, unless of course you set the `row-reverse` direction, in which case it aligns items to the left.
* `center` centers the flex items in the middle of the container
* `space-between` evenly spaces out the flex items, dividing the space between them equally while aligning the leftmost item to the left and the rightmost item to the right. This is a great option for displaying a series of buttons that fill the entire width of a container.
* `space-around` evenly distributes the leftover space within the container around all the items adding space to the left- and rightmost items as well

参见如下示例，示例代码演示的是第五行 `space-around` 

~~~ css
.container {
  display: -webkit-flex;
  display: flex;
  -webkit-justify-content: space-around;
  justify-content: space-around;
}
.container div {
  width: 200px;
}
~~~

{% iframe justify-content-example %}
<html>
<head>
  <style>
  .flex-basic-container {
    display: -webkit-flex;
    display: flex;
    width: 800px;
    border: 2px solid #666666;
    background-color: #dddddd;
  }
  .flex-basic-container div {
    width: 200px;
    color: #fff;
    border: 1px solid red;
    background-color: #999999;
  }
  .flex-start-container {
    justify-content: flex-start;
    -webkit-flex-justify-content: flex-start;
  }
  .flex-end-container {
    justify-content: flex-end;
    -webkit-flex-justify-content: flex-end;
  }
  .center-container {
    justify-content: center;
    -webkit-flex-justify-content: center;
  }
  .space-between-container {
    justify-content: space-between;
    -webkit-flex-justify-content: space-between;
  }
  .space-around-container {
    justify-content: space-around;
    -webkit-flex-justify-content: space-around;
  }
  </style>
</head>
<body><div>
  <div>justify-content: flex-start</div>
  <div class="flex-basic-container flex-start-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
  
  <div>justify-content: flex-end</div>
  <div class="flex-basic-container flex-end-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
  
  <div>justify-content: center</div>
  <div class="flex-basic-container center-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
  
  <div>justify-content: space-between</div>
  <div class="flex-basic-container space-between-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
  
  <div>justify-content: space-around</div>
  <div class="flex-basic-container space-around-container">
    <div>A flex item</div>
    <div>Another flex item</div>
    <div>A third flex item</div>
  </div>
</div>
</body>
</html>
{% endiframe %}



### Align-items

* The `lign-items` property determines how flex items of different heights are vertically placed within a flex container.
* By default, flex items stretch to fit the container, so are all equal heights

* 可能的值：
  * `flex-start` aligns the tops of all flex items to the top of the container 
  * `flex-end` aligns the bottoms of all flex items to the bottom of the container
  * `center` aligns the vertical centers of all flex items to the vertical center of the container
  * `baseline` aligns the baseline of the first element within each flex
  * `stretch` is the normal behavior of flex items. It stretches each item in the con-
tainer to the same height 

* 代码示例
  ~~~ css
  .container {
    display: -webkit-flex;
    display: flex;
    -webkit-align-items: flex-end;
    align-items: flex-end;
  }
  ~~~

{% iframe justify-align-items-example %}
<html>
<head>
  <style>
  .flex-basic-container {
    display: -webkit-flex;
    display: flex;
    width: 800px;
    border: 2px solid #666666;
    background-color: #dddddd;
  }
  .flex-basic-container div {
    width: 200px;
    color: #fff;
    border: 1px solid red;
    background-color: #999999;
  }
  .flex-start-container {
    align-items: flex-start;
    -webkit-flex-align-items: flex-start;
  }
  .flex-end-container {
    align-items: flex-end;
    -webkit-flex-align-items: flex-end;
  }
  .center-container {
    align-items: center;
    -webkit-flex-align-items: center;
  }
  .baseline-container {
    align-items: baseline;
    -webkit-flex-align-items: baseline;
  }
  .stretch-container {
    align-items: stretch;
    -webkit-flex-align-items: stretch;
  }
  </style>
</head>
<body><div>
  <div>align-items: flex-start</div>
  <div class="flex-basic-container flex-start-container">
    <div>立项
      <p>新产品或老产品大改版必须经过立项流程</p>
    </div>
    <div>上线
      <p>当产品开发阶段基本结束、具备上线试运营条件后，安排上线事宜。</p>
    </div>
    <div>上线后评估
      <p>产品正式上线后，为评估上线产品是否达到立项文件中设定的预期目标，须按时开展产品上线后评估工作</p>
    </div>
  </div>
  
  <div>align-items: flex-end</div>
  <div class="flex-basic-container flex-end-container">
    <div>立项
      <p>新产品或老产品大改版必须经过立项流程</p>
    </div>
    <div>上线
      <p>当产品开发阶段基本结束、具备上线试运营条件后，安排上线事宜。</p>
    </div>
    <div>上线后评估
      <p>产品正式上线后，为评估上线产品是否达到立项文件中设定的预期目标，须按时开展产品上线后评估工作</p>
    </div>
  </div>
  
  <div>align-items: center</div>
  <div class="flex-basic-container center-container">
    <div>立项
      <p>新产品或老产品大改版必须经过立项流程</p>
    </div>
    <div>上线
      <p>当产品开发阶段基本结束、具备上线试运营条件后，安排上线事宜。</p>
    </div>
    <div>上线后评估
      <p>产品正式上线后，为评估上线产品是否达到立项文件中设定的预期目标，须按时开展产品上线后评估工作</p>
    </div>
  </div>
  
  <div>align-items: baseline</div>
  <div class="flex-basic-container baseline-container">
    <div>立项
      <p>新产品或老产品大改版必须经过立项流程</p>
    </div>
    <div>上线
      <p>当产品开发阶段基本结束、具备上线试运营条件后，安排上线事宜。</p>
    </div>
    <div>上线后评估
      <p>产品正式上线后，为评估上线产品是否达到立项文件中设定的预期目标，须按时开展产品上线后评估工作</p>
    </div>
  </div>
  
  <div>align-items: stretch</div>
  <div class="flex-basic-container stretch-container">
    <div>立项
      <p>新产品或老产品大改版必须经过立项流程</p>
    </div>
    <div>上线
      <p>当产品开发阶段基本结束、具备上线试运营条件后，安排上线事宜。</p>
    </div>
    <div>上线后评估
      <p>产品正式上线后，为评估上线产品是否达到立项文件中设定的预期目标，须按时开展产品上线后评估工作</p>
    </div>
  </div>
</div>
</body>
</html>
{% endiframe %}


* baseline 的补充说明，对齐的是第一行的baseline，如下图
  * ![](align-items-baseline.png)




### Align-content

* The `align-content` property dictates how a browser places flex items that span over multiple lines.
* 2 个条件满足时，这个属性才有效：
  1. the flex container must have wrap turned on
  2. the flex container must be taller than the rows of flex items

* 可能的值：
  * `flex-start` places the rows of flex items at the top of the flex container
  * `flex-end` places the flex item rows at the bottom of the container
  * `center` aligns the vertical center of all rows to the vertical center of the container
  * `space-between` evenly distributes extra vertical space between the rows, placing the top row at the top of the container and the bottom row at the bottom of the container
  * `space-around` evenly distributes space on the top and bottom of all rows. This adds space above the top row and below the bottom row
  * `stretch` is the normal behavior of rows of flex items. It stretches each item within a row to match the height of the other items in the row. 


* 代码示例，make sure that the flex-flow property  includes the wrap option
  ~~~ css
  .container {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row wrap;
    flex-flow: row wrap;
    -webkit-align-content: space-between;
    align-content: space-between;
    height: 600px;
  }
  ~~~


## Flex Item Properties

### The Order Property

* The order property lets you assign a numeric value to a flex item which dictates where within the row (or column) this item should appear. 


* 示例代码
  ~~~ css
    .order-1 {
      order: 1;
      -webkit-order: 1;
    }
    .order-2 {
      order: 2;
      -webkit-order: 2;
    }
    .order-3 {
      order: 3;
      -webkit-order: 3;
    }
    .order-4 {
      order: 4;
      -webkit-order: 4;
    }
  ~~~

  ~~~ html
    <div>使用order属性变换顺序</div>
    <div class="flex-basic-container">
      <div class="order-4">1</div>
      <div class="order-3">2</div>
      <div class="order-1">3</div>
      <div class="order-2">4</div>
    </div>
  ~~~


{% iframe order-example %}
<html>
<head>
  <style>
  .flex-basic-container {
    display: -webkit-flex;
    display: flex;
    justify-content: space-around;
    -webkit-flex-justify-content: space-around;
    width: 800px;
    border: 2px solid #666666;
    background-color: #dddddd;
  }
  .flex-basic-container div {
    width: 120px;
    height: 120px;
    color: #fff;
    border: 1px solid red;
    background-color: #999999;
    font-size: 40px;
  }
  .order-1 {
    order: 1;
    -webkit-order: 1;
  }
  .order-2 {
    order: 2;
    -webkit-order: 2;
  }
  .order-3 {
    order: 3;
    -webkit-order: 3;
  }
  .order-4 {
    order: 4;
    -webkit-order: 4;
  }
  </style>
</head>
<body><div>
  <div>正常</div>
  <div class="flex-basic-container">
    <div>1</div>
    <div>2</div>
    <div>3</div>
    <div>4</div>
  </div>
  
  <div>使用order属性变换顺序</div>
  <div class="flex-basic-container">
    <div class="order-4">1</div>
    <div class="order-3">2</div>
    <div class="order-1">3</div>
    <div class="order-2">4</div>
  </div>
</div>
</body>
</html>
{% endiframe %}


#### `order: -1;`

However, sometimes you might want to just move one column to the far left or far
right of a row. In that case, you can simply set the order on that particular item, but
not on any others

Using `-1` moves the item to the left side of the flex container, before all of the other
rows. Conversely, you could move that same sidebar to the far right by setting its
order number to `1`, while leaving the other elements’ order properties unset.


~~~ css
.sidebar1 {
  -webkit-order: -1;
  order: -1;
}
~~~



### Align-self

* The align-self property works just like the align-items property used for flex
containers. 不同的是，`align-self` applies to just the individual flex item.
* You apply the property to an item (not the container) and it overrides any value for the align-items property.
* You apply the property to an item (not the container) and it overrides any value for the align-items property.

![](align-self.png)



### Flex 属性

This property is the key to controlling the width of flex items; it lets you easily create columns that “flex,” or change width to match the size of their container, even when the size is unknown or dynamic.

*  it’s really a shorthand property that combines three other flex properties.
  1. `flex-grow` , 是个数字， indicates the relative width of that flex item. 表明item在container中所占宽或长的**比重**。
  2. `flex-shrink`, 2nd value， 也是个数字. 
        * 这个属性起作用要满足2个条件：
          * 当容器总宽小于items宽的总和的时候，
          * 且容器的`flex-flow`属性包含`nowrap`的时候，
        * 与 `flex-grow` 相反，数值越大，压缩越大，item越小。
  3. `flex-basis` property, which sets a base width for a flex item.
        * You can use an absolute value like 100px or 5em, or a percentage value like 50%. 
        * a kind of minimum width for a flex item.
        * The real value of the flex-basis property comes into play when you set a flex container to allow wrapping



~~~ css
flex: 1 1 400px;

/* 等价于 */
flex-grow: 1;
flex-shrink: 1;
flex-basis: 400px;
~~~

#### flex 属性默认值

If you don’t set the flex property on flex items within a flex container, browsers provide a default setting, which is the equivalent of: `flex: 0 1 auto;`

With this setting, the width of each flex item is automatically determined by the content inside it. A flex item with a lot of text and pictures will be a lot wider than an item with just two words.

When you leave out the `flex-shrink` and `flex-basis` values—for example, `flex: 1;`—the browser assigns a default value of 1 to `flex-shrink`, but sets the default value of `flex-basis` to 0%.

By setting the `flex-basis` to 0%, the width of each flex item is completely dictated by the `flex-grow property`: In other words, the amount of content inside each flex item has no effect on how wide the various items are.


~~~ css
flex: 1; 

/* is the equivalent of */

flex-grow: 1;
flex-shrink: 1;
flex-basis: 0%;
~~~











































































