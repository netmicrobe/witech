---
layout: post
title: JavaScript XMLHttpRequest
categories: [dev, web]
tags: [javaScript, ajax, xhr]
---

`XMLHttpRequest()` (XHR for short) is an object (a constructor function) that allows you to send
HTTP requests from JavaScript. You can make an HTTP request to the server, get
the response, and update only a part of the page. This way you can build much more
responsive and desktop-like web pages.

`Ajax` stands for **Asynchronous JavaScript and XML**.

<!-- more -->


## 使用 XHR 的基本方法

### Sending the request

~~~ javascript
var xhr = new XMLHttpRequest();
xhr.onreadystatechange = myCallback;

// The first parameter specifies the type of HTTP request (GET, POST, HEAD, and so on).
// The second parameter is the URL you are requesting. 
// The last parameter is a boolean specifying whether the request is asynchronous
//    (true, always prefer this) or not (false, blocks all the JavaScript execution and
//    waits until the response arrives).
xhr.open('GET', 'somefile.txt', true);

// send() accepts any data you want to send with the request. 
// For GET requests, this is an empty string, because the data is in the URL. 
// For POST request, it's a query string in the form key=value&key2=value2.

xhr.send('');


// At this point, the request is sent and your code (and the user) can move on 
// The callback function myCallback will be invoked when the response comes
// back from the server.

~~~



### Processing the response

There is a property of the XHR object called `readyState`. Every time it changes, the
`readystatechange` event fires. 

* `readyState` 属性的可取值：
  * 0-uninitialized
  * 1-loading
  * 2-loaded
  * 3-interactive
  * 4-complete

~~~ javascript
function myCallback() {
  if (xhr.readyState < 4) {
    return; // not ready yet
  }
  if (xhr.status !== 200) {
    alert('Error!'); // the HTTP status code is not OK
    return;
  }
  // all is fine, do the work
  alert(xhr.responseText);
}
~~~


## 常用技巧

### XMLHttpRequest 异步闭环，防止另一个请求复用全局变量，导致找不到原先的XHR对象


~~~ javascript
var xhr = new XMLHttpRequest();
xhr.onreadystatechange = (function (myxhr) {
  return function () {
    myCallback(myxhr);
  };
}(xhr));
xhr.open('GET', 'somefile.txt', true);
xhr.send('');
~~~

### request(url, callback) 封装

~~~ javascript
function request(url, callback) {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = (function (myxhr) {
    return function () {
      if (myxhr.readyState === 4 && myxhr.status === 200) {
        callback(myxhr);
      }
    };
  }(xhr));
  xhr.open('GET', url, true);
  xhr.send('');
}

request(
  'http://www.phpied.com/files/jsoop/content.txt',
  function (o) {
    document.getElementById('text').innerHTML =
    o.responseText;
  }
);

~~~




## 浏览器兼容

In Internet Explorer prior to version 7, the XMLHttpRequest object was an ActiveX
object, so creating an XHR instance is a little different. It goes like the following:

~~~
var xhr = new ActiveXObject('MSXML2.XMLHTTP.3.0');
~~~

### 创建 XMLHttpRequest 对象的兼容性代码

~~~ javascript
var ids = ['MSXML2.XMLHTTP.3.0',
            'MSXML2.XMLHTTP',
            'Microsoft.XMLHTTP'];

var xhr;
if (XMLHttpRequest) {
  xhr = new XMLHttpRequest();
} else {
  // IE: try to find an ActiveX object to use
  for (var i = 0; i < ids.length; i++) {
    try {
      xhr = new ActiveXObject(ids[i]);
      break;
    } catch (e) {}
  }
}

~~~



















