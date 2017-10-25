---
layout: post
title: JavaScript Coding Patterns & Design Patterns
categories: [dev, web]
tags: [javascript]
---

## Coding patterns

* Separating behavior
* Namespaces
* Init-time branching
* Lazy definition
* Configuration objects
* Private variables and methods
* Privileged methods
* Private functions as public methods
* Immediate functions
* Chaining
* JSON


### Separating behavior ， 低耦合

HTML 有三部分组成： Content (HTML) , Presentation (CSS) , Behavior (JavaScript)

#### Content (HTML) 

展示样式相关的，交给 CSS展示层，意味着要注意如下几点。

* The style attribute of HTML tags should not be used, if possible.
* Presentational HTML tags such as `<font>` should not be used at all.
* Tags should be used for their semantic meaning, not because of how
  browsers render them by default. For instance, developers sometimes use a
  `<div>` tag where a `<p>` would be more appropriate. It's also favorable to use
  `<strong>` and `<em>` instead of `<b>` and `<i>` as the latter describe the visual
  presentation rather than the meaning.

#### Presentation (CSS)

A good approach to keep presentation out of the content is to reset, or nullify all
browser defaults. For example, using `reset.css` from the Yahoo! UI library.


#### Behavior (JavaScript)

Behavior should be kept separate from both the content and the presentation.

Not using any inline attributes such as `onclick`, `onmouseover`, and so on. Instead, you can use the `addEventListener/attachEvent` methods

* Minimize the number of `<script>` tags
* Avoid inline event handlers
* Do not use CSS expressions
* Dynamically add markup that has no purpose if JavaScript is disabled
by the user
* Towards the end of your content when you are ready to close the `<body>` tag,
insert a single external.js file

#### 示例

~~~ html
<body>
  <form id="myform" method="post" action="server.php">
    <fieldset>
      <legend>Search</legend>
      <input
        name="search"
        id="search"
        type="text"
      />
      <input type="submit" />
    </fieldset>
  </form>
  <script src="behaviors.js"></script> <!-- js 在 body 最后载入 -->
</body>
~~~

~~~ javascript
/* -- behaviors.js -- */

// init
myevent.addListener('myform', 'submit', function (e) {
  // no need to propagate further
  e = myevent.getEvent(e);
  myevent.stopPropagation(e);
  // validate
  var el = document.getElementById('search');
  if (!el.value) { // too bad, field is empty
    myevent.preventDefault(e); // prevent the form submission
    alert('Please enter a search string');
  }
});
~~~

#### Asynchronous JavaScript loading

* `<script src="...">` 放在 body 末尾的原因：
    The reason is that JavaScript blocks the DOM construction of the page
    and in some browsers even the downloads of the other components that follow. By
    moving the scripts to the bottom of the page you ensure the script

* defer
    HTML5 提供了另外一种方法，防止 script 阻塞 page 加载： `defer`
    老浏览器不支持这个方法。
    
    ~~~ html
    <script defer src="behaviors.js"></script>
    ~~~

* inline JavaScript to load the external JavaScript file
    You can have this script loader snippet at the top of your document so that the download has an early start:
    
    ~~~ html
    ...
    <head>
    (function () {
    var s = document.createElement('script');
    s.src = 'behaviors.js';
    document.getElementsByTagName('head')[0].appendChild(s);
    }());
    </head>
    ...
    ~~~

### Namespaces

The idea is simple, you create only one global object and all
your other variables and functions become properties of that object.

#### An Object as a namespace

~~~ javascript
// global namespace
var MYAPP = MYAPP || {};

// sub-object
// Adding the methods to the event utility is still the same:
// object together with the method declarations
MYAPP.event = {
  addListener: function (el, type, fn) {
  // .. do the thing
  },
  removeListener: function (el, type, fn) {
  // ...
  },
  getEvent: function (e) {
  // ...
  }
  // ... other methods or properties
};
~~~

#### Namespaced constructors

~~~ javascript
MYAPP.dom = {};
MYAPP.dom.Element = function (type, properties) {
  var tmp = document.createElement(type);
  for (var i in properties) {
    if (properties.hasOwnProperty(i)) {
      tmp.setAttribute(i, properties[i]);
    }
  }
  return tmp;
};
MYAPP.dom.Text = function (txt) {
  return document.createTextNode(txt);
};


// 使用刚定义的 constructors

var link = new MYAPP.dom.Element('a',
  {href: 'http://phpied.com', target: '_blank'});
var text = new MYAPP.dom.Text('click me');
link.appendChild(text);
document.body.appendChild(link);

~~~


#### A namespace() method


如何定义 namespace() ：

~~~ javascript
var MYAPP = {};
MYAPP.namespace = function (name) {
  var parts = name.split('.');
  var current = MYAPP;
  for (var i = 0; i < parts.length; i++) {
    if (!current[parts[i]]) {
      current[parts[i]] = {};
    }
  current = current[parts[i]];
  }
};
~~~

使用  namespace() ：

~~~ javascript
MYAPP.namespace('dom.style');

// 上述用法，等价且简洁于：

MYAPP.dom = {};
MYAPP.dom.style = {};
~~~




### Init-time branching

这个模式，可以用来解决兼容性问题。每次执行才检查兼容性，代码不容易管理，也降低执行效率。

需要在脚本开始时候，就初始化好适合当前浏览器的代码。

~~~ javascript
var MYAPP = {};
MYAPP.event = {
  addListener: null,
  removeListener: null
};

if (window.addEventListener) {
  MYAPP.event.addListener = function (el, type, fn) {
    el.addEventListener(type, fn, false);
  };
  MYAPP.event.removeListener = function (el, type, fn) {
    el.removeEventListener(type, fn, false);
  };
} else if (document.attachEvent) { // IE
  MYAPP.event.addListener = function (el, type, fn) {
    el.attachEvent('on' + type, fn);
  };
  MYAPP.event.removeListener = function (el, type, fn) {
    el.detachEvent('on' + type, fn);
  };
} else { // older browsers
  MYAPP.event.addListener = function (el, type, fn) {
    el['on' + type] = fn;
  };
  MYAPP.event.removeListener = function (el, type) {
    el['on' + type] = null;
  };
}
~~~




### Lazy definition

类似 init-time branching ， 不同在于，定义行为不是在初始化都做完，而是方式在实际调用的时候。

~~~ javascript
var MYAPP = {};
MYAPP.myevent = {
  addListener: function (el, type, fn) {
    if (el.addEventListener) {
      MYAPP.myevent.addListener = function (el, type, fn) {
        el.addEventListener(type, fn, false);
      };
    } else if (el.attachEvent) {
      MYAPP.myevent.addListener = function (el, type, fn) {
        el.attachEvent('on' + type, fn);
      };
    } else {
      MYAPP.myevent.addListener = function (el, type, fn) {
        el['on' + type] = fn;
      };
    }
    MYAPP.myevent.addListener(el, type, fn);
  }
};
~~~


### Configuration object

This pattern is convenient when you have a function or method that accepts a lot
of optional parameters. 

一个function超过3个参数，使用起来很不方便，因为要记住参数的顺序。

Instead of having many parameters, you can use one parameter and make it an object. The properties of the object are the actual parameters. 

~~~ javascript
MYAPP.dom.FancyButton = function (text, conf) {
  var type = conf.type || 'submit';
  var font = conf.font || 'Verdana';
  // ...
};

// 使用起来倍儿方便！

var config = {
  font: 'Arial, Verdana, sans-serif',
  color: 'white'
};
new MYAPP.dom.FancyButton('puuush', config);

// 另外一种用法

document.body.appendChild(
  new MYAPP.dom.FancyButton('dude', {color: 'red'})
);

~~~



### Private properties and methods

~~~ javascript
/*
In this implementation, styles is a private property and setStyle() is a private
method. The constructor uses them internally (and they can access anything inside
the constructor), but they are not available to code outside of the function.
*/

var MYAPP = {};
MYAPP.dom = {};
MYAPP.dom.FancyButton = function (text, conf) {
  var styles = {
    font: 'Verdana',
    border: '1px solid black',
    color: 'black',
    background: 'grey'
  };
  function setStyles(b) {
    var i;
    for (i in styles) {
      if (styles.hasOwnProperty(i)) {
        b.style[i] = conf[i] || styles[i];
      }
    }
  }
  conf = conf || {};
  var b = document.createElement('input');
  b.type = conf.type || 'submit';
  b.value = text;
  setStyles(b);
  return b;
};
~~~


### Privileged methods

通过 Privileged methods 可以访问私有方法&属性，过程中可以施加些控制。



### Private functions as public methods

~~~ javascript
// define _setStyle() and _getStyle() as private functions, but then assign
// them to the public setStyle() and getStyle()

var MYAPP = {};
MYAPP.dom = (function () {
  var _setStyle = function (el, prop, value) {
    console.log('setStyle');
  };
  var _getStyle = function (el, prop) {
    console.log('getStyle');
  };
  return {
    setStyle: _setStyle,
    getStyle: _getStyle,
    yetAnother: _setStyle
  };
}());
~~~



### Immediate functions

Another pattern that helps you keep the global namespace clean is to wrap your
code in an anonymous function and execute that function immediately. 

~~~ javascript
(function () {
// code goes here...
}());
~~~

~~~ javascript
var MYAPP = {};
MYAPP.dom = (function () {
  // initialization code...
  function _private() {
    // ...
  }
  return {
    getStyle: function (el, prop) {
      console.log('getStyle');
      _private();
    },
    setStyle: function (el, prop, value) {
      console.log('setStyle');
    }
  };
}());
~~~



### Modules

The module pattern includes:

* Namespaces to reduce naming conflicts among modules
* An immediate function to provide a private scope and initialization
* Private properties and methods
* Returning an object that has the public API of the module as follows:

~~~ javascript
namespace('MYAPP.module.amazing');

MYAPP.module.amazing = (function () {
  // short names for dependencies
  var another = MYAPP.module.another;
  
  // local/private variables
  var i, j;
  
  // private functions
  function hidden() {}
  
  // public API
  return {
    hi: function () {
      return "hello";
    }
  };
}());

// using the following module:
MYAPP.module.amazing.hi(); // "hello"

~~~


### Chaining

Chaining is a pattern that allows you to invoke multiple methods on one line as if
the methods are the links in a chain. 

You invoke the next method on the result of the previous without the use
of an intermediate variable.

~~~ javascript
document.body.appendChild(
  new MYAPP.dom.Element('span')
    .setText('hello')
    .setStyle('color', 'red')
    .setStyle('font', 'Verdana')
);
~~~



### JSON

JSON is not technically a coding pattern, but you can say that using JSON is a
good pattern.

You can convert this string of data into a working JavaScript object by simply using eval():

返回 JSON 
~~~ json
{
'name': 'Stoyan',
'family': 'Stefanov',
'books': ['OOJS', 'JSPatterns', 'JS4PHP']
}
~~~

~~~ javascript
var response = eval('(' + xhr.responseText + ')');

console.log(response.name); // "Stoyan"
console.log(response.books[2]); // "JS4PHP"
~~~

或者，

#### 使用 `JSON.parse`

~~~ javascript
var response = JSON.parse(xhr.responseText);
~~~

#### stringify()

json 对象转换为 String。

~~~ javascript
var str = JSON.stringify({hello: "you"});
~~~






## Design Patterns


### Singleton

* Global variable
    这种方法，缺点是，全局变量可能被不小心篡改。
    
    ~~~ javascript
    function Logger() {
      if (typeof global_log === "undefined") {
        global_log = this;
      }
      return global_log;
    }

    var a = new Logger();
    var b = new Logger();
    console.log(a === b); // true，单例

    ~~~


* Property of the Constructor

    This approach certainly solves the global namespace issue because no global
    variables are created. 

    The only drawback is that the property of the `Logger` constructor is publicly visible, so it can be overwritten at any time.

    ~~~ javascript
    function Logger() {
      if (Logger.single_instance) {
        Logger.single_instance = this;
      }
      return Logger.single_instance;
    }
    ~~~


* In a private property

~~~ javascript
var global_log;
var Logger = (function(logger){
  return function() {
    if (typeof logger === "undefined") {
      this.date = new Date();
      logger = this;
    }
    return logger;
  }
}(global_log));
~~~



### Factory

~~~ javascript
var MYAPP = {};
MYAPP.dom = {};
MYAPP.dom.Text = function (url) {
  this.url = url;
  this.insert = function (where) {
    var txt = document.createTextNode(this.url);
    where.appendChild(txt);
  };
};
MYAPP.dom.Link = function (url) {
  this.url = url;
  this.insert = function (where) {
    var link = document.createElement('a');
    link.href = this.url;
    link.appendChild(document.createTextNode(this.url));
    where.appendChild(link);
  };
};
MYAPP.dom.Image = function (url) {
  this.url = url;
  this.insert = function (where) {
    var im = document.createElement('img');
    im.src = this.url;
    where.appendChild(im);
  };
};

// Using the three different constructors is exactly the same, 
// pass the url and call the insert() method:
var url = 'http://www.phpied.com/images/covers/oojs.jpg';

// 未使用工厂方法

var o = new MYAPP.dom.Image(url);
o.insert(document.body);

var o = new MYAPP.dom.Text(url);
o.insert(document.body);

var o = new MYAPP.dom.Link(url);
o.insert(document.body);

// 定义&使用 工厂方法

MYAPP.dom.factory = function (type, url) {
  return new MYAPP.dom[type](url);
};

var image = MYAPP.dom.factory("Image", url);
image.insert(document.body);
~~~




### Decorator

~~~ javascript
var tree = {};
tree.decorate = function () {
  console.log('Make sure the tree won\'t fall');
};

tree.getDecorator = function (deco) {
  tree[deco].prototype = this;
  return new tree[deco];
};

// let's create decorators
tree.RedBalls = function () {
  this.decorate = function () {
    this.RedBalls.prototype.decorate();
    console.log('Put on some red balls');
  };
};

tree.BlueBalls = function () {
  this.decorate = function () {
    this.BlueBalls.prototype.decorate();
    console.log('Add blue balls');
  };
};

tree.Angel = function () {
  this.decorate = function () {
    this.Angel.prototype.decorate();
    console.log('An angel on the top');
  };
};

// let's add all of the decorators to the base object:

tree = tree.getDecorator('BlueBalls');
tree = tree.getDecorator('Angel');
tree = tree.getDecorator('RedBalls');

// Finally, running the decorate() method:
tree.decorate();
~~~





### Observer

#### an example implementation of the push model.

* An array of subscribers that are just callback functions
* `addSubscriber()` and `removeSubscriber()` methods that add to, and
remove from, the subscribers collection
* A `publish()` method that takes data and calls all subscribers, passing the
data to them
* A `make()` method that takes any object and turns it into a publisher by
adding all of the methods mentioned previously to it


~~~ javascript
// Here's the observer mix-in object, which contains all the subscription-related
// methods and can be used to turn any object into a publisher:
var observer = {
  addSubscriber: function (callback) {
    if (typeof callback === "function") {
      this.subscribers[this.subscribers.length] = callback;
    }
  },
  removeSubscriber: function (callback) {
    for (var i = 0; i < this.subscribers.length; i++) {
      if (this.subscribers[i] === callback) {
        delete this.subscribers[i];
      }
    }
  },
  publish: function (what) {
    for (var i = 0; i < this.subscribers.length; i++) {
      if (typeof this.subscribers[i] === 'function') {
        this.subscribers[i](what);
      }
    }
  },
  make: function (o) { // turns an object into a publisher
    for (var i in this) {
      if (this.hasOwnProperty(i)) {
        o[i] = this[i];
        o.subscribers = [];
      }
    }
  }
};


// Now, let's create some publishers. 
// Here's a blogger object which calls publish() every time a new blog posting is ready:
var blogger = {
  writeBlogPost: function() {
    var content = 'Today is ' + new Date();
    this.publish(content);
  }
};
observer.make(blogger);

// 添加 Subscribers
var jack = {
  read: function(what) {
    console.log("I just read that " + what)
  }
};
var jill = {
  gossip: function(what) {
    console.log("You didn't hear it from me, but " + what)
  }
};

blogger.addSubscriber(jack.read);
blogger.addSubscriber(jill.gossip);

// What happens now when the blogger writes a new post? 
// The result is that jack and jill get notified

blogger.writeBlogPost();

// jill may decide to cancel her subscription. 
blogger.removeSubscriber(jill.gossip);

~~~






























































































































































