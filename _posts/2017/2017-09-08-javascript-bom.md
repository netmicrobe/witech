---
layout: post
title: JavaScript BOM, Browser Object Model
categories: [dev, web]
tags: [JavaScript, oop, object-oriented, bom, browser]
---

* 参考
  * 《 Object-Oriented JavaScript 》.2nd - Stoyan.Stefanov


BOM 是一系列对象，通过这些对象可以访问浏览器和电脑。这些对象，通过 `window` 访问。



## BOM, Browser Object Model




### window.document

window.document is a BOM object that refers to the currently loaded document (page).

详见 DOM相关文章。



### window.navigator

`navigator` 对象包含浏览器信息，有点像浏览器的“关于”

> 在console中直接查看navigator对象的内容：
>> ![](view-navigator-obj-in-console.png)


#### window.navigator.userAgent

~~~
> window.navigator.userAgent;
"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/536.28.10 (KHTML, like
Gecko) Version/6.0.3 Safari/536.28.10"
~~~

~~~ javascript
if (navigator.userAgent.indexOf('MSIE') !== -1) {
  // this is IE
} else {
  // not IE
}
~~~





### window.location

`location`对象包含url的信息。

Imagine you're on a page with a URL 
>~~~
>http://search.phpied.com:8080/search?q=python&what=script#results
>~~~

~~~ javascript
for (var i in location) {
  if (typeof location[i] === "string") {
    console.log(i + ' = "' + location[i] + '"');
  }
}

执行结果：
href = "http://search.phpied.com:8080/search?q=python&what=script#results"
hash = "#results"
host = "search.phpied.com:8080"
hostname = "search.phpied.com"
pathname = "/search"
port = «8080»
protocol = «http:»
search = "?q=python&what=script"
~~~

#### 跳转到新的地址

~~~ javascript
window.location.href = 'http://www.packtpub.com';
location.href = 'http://www.packtpub.com';
location = 'http://www.packtpub.com';
location.assign('http://www.packtpub.com');
~~~



#### replace

和 `assign` 效果一样，但不会在 history 中留下记录。

~~~
> location.replace('http://www.yahoo.com');
~~~



#### reload 刷新页面

~~~
> location.reload();
~~~





### window.history

window.history allows limited access to the previously visited pages in the same
browser session. 

~~~ javascript
// For example, you can see how many pages the user has visited
// before coming to your page as follows:
> window.history.length;
~~~

~~~ javascript
// as if the user had clicked on the Back/Forward browser buttons as follows:
> history.forward();
> history.back();
~~~

~~~ javascript
// the same as calling history.back()
> history.go(-1);

// going two pages back
> history.go(-2);

// Reload the current page
> history.go(0);
~~~




### window.frames

window.frames is a collection of all of the frames in the current page. 

It doesn't distinguish between frames and iframes (inline frames). 

~~~ javascript
// Regardless of whether there are frames on the page or not, 
// window.frames always exists and points to window
> window.frames === window;
true
~~~

页面中存在一个 iframe

~~~ html
<iframe name="myframe" src="hello.html" />
~~~

~~~ javascript
> frames.length
1

// To get access to the iframe's window，如下任一一种方法：
window.frames[0];
window.frames[0].window;
window.frames[0].window.frames;
frames[0].window;
frames[0];

// Using a property called top, you can access the top-most page
> window.frames[0].window.top === window;
true
> window.frames[0].window.top === window.top;
true

// self is the same as window 
> self === window;
true
> frames[0].self == frames[0].window;
true

// If a frame has a name attribute, you can not only access the frame by name
> window.frames['myframe'] === window.frames[0];
true
> frames.myframe === window.frames[0];
true
~~~




### window.screen


~~~ javascript
> window.screen.colorDepth;
32

> screen.width;
1440
> screen.availWidth;
1440
> screen.height;
900
> screen.availHeight;
847
~~~

### window.devicePixelRatio 缩放比例

网页在浏览器中的缩放比例，不缩放，值为 1；放大到 150%，值为 1.5；缩小到 90%，值为 0.9

~~~ javascript
// the difference (ratio) between physical pixels and device pixels in the
// retina displays in mobile devices (for example, value 2 in iPhone).
> window.devicePixelRatio;
1
~~~




### open() , close()

打开/关闭浏览器窗口。

~~~ javascript
var win = window.open('http://www.packtpub.com', 'packt',
'width=300,height=300,resizable=yes');

win.close(); // closes the new window.

~~~






### moveTo() , resizeTo()

* `window.moveTo(100, 100)` moves the browser window to screen location x = 100 and y = 100
* `window.moveBy(10, -10)` moves the window 10 pixels to the right and 10 pixels up from its current location
* `window.resizeTo(x, y)` and `window.resizeBy(x, y)` accept the same parameters as the move methods but they resize the window as opposed to moving it







### alert(), prompt(), confirm()

`alert()` is not an ECMAScript function, but a BOM method. 另外两个方法在 ECMAScript 中。

* confirm() gives the user two options, OK and Cancel
* prompt() collects textual input



#### confirm()

~~~ javascript
if (confirm('Are you cool?')) {
  // cool
} else {
  // no cool
}
~~~

![](window-confirm.png)

* Nothing gets written to the console until you close this message, this means that any JavaScript code execution freezes, waiting for the user's answer
* Clicking on OK returns true, clicking on Cancel or closing the message using the X icon (or the ESC key) returns false



#### prompt()

~~~ javascript
> var answer = prompt('And your name was?');
> answer;
~~~

![](window-prompt.png)

The value of answer is one of the following:
* **null** if you click on `Cancel` or the `X icon`, or press <kbd>ESC</kbd>
* **"" (empty string)** if you click on OK or press <kbd>Enter</kbd> without typing anything
* **A text string** if you type something and then click on `OK` (or press <kbd>Enter</kbd>)




### setTimeout(), setInterval()

`setTimeout()` and `setInterval()` allow for scheduling the execution of a piece of code.

* setTimeout() attempts to execute the given code once after a specified number of milliseconds. 
* setInterval() attempts to execute it repeatedly after a specified number of milliseconds has passed.

~~~ javascript
// shows an alert after approximately 2 seconds (2000 milliseconds):
> function boo() { alert('Boo!'); }
> setTimeout(boo, 2000);
4 // 返回值是，计划执行的ID，可以用这个ID，通过 clearTimeout() 来 cancel timeout。

> var id = setTimeout(boo, 2000);
> clearTimeout(id);
~~~

~~~ javascript
> function boo() { console.log('boo'); }
> var id = setInterval(boo, 2000);
boo
boo
boo
> clearInterval(id);
~~~

也可以使用匿名函数

~~~ javascript
var id = setInterval(
  function () {
    alert('boo, boo');
  },
  2000
);
~~~














## 浏览器兼容性


### feature sniffing

~~~ javascript
if (typeof window.addEventListener === 'function') {
  // feature is supported, let's use it
} else {
  // hmm, this feature is not supported, will have to
  // think of another way
}

~~~









