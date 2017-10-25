---
layout: post
title: JavaScript Object Oriented Programming 面向对象简介
categories: [dev, web]
tags: [JavaScript, oop, object-oriented]
---

* 参考
  * 《 Object-Oriented JavaScript 》.2nd - Stoyan.Stefanov


## JavaScript 术语和演进

### 术语

ECMAScript
: ECMA发布。JavaScript 纯语言规范，不包含特定浏览器相关的功能

DOM
: W3C发布。Document Object Model. html/xml 文档结构对象化，便于 script 操作。

BOM
: Browser Object Model

### 演进

* 1996 - 2001 
  IE和Netscape大战，IE6 胜利。
* 2004
  Gmail and Google Maps 发布，JavaScript 趋于成熟。
* 2006
  XMLHttpRequest（XHR） 被浏览器普遍支持，2006.4 形成 W3C 草案。Ajax 兴起。
* 2009.12
  ECMAScript 5（简称ES5） 被官方接受（Officially Accepted）。
* 2014.10
  HTML5 <i class="fa fa-html5" aria-hidden="true"></i> published in October 2014 by the World Wide Web Consortium (W3C)


## 特殊的指令

### "use strict";

`"use strict";`  声明后，这个函数或者这个js程序，严格遵守 ES5

* 注意：这只是个字符串，JS允许只写个字符串，但不指定给变量。这样ES5向后兼容老浏览器。




## 嵌入HTML文档

~~~ html
<head>
  <title>JS test</title>
  <script src="somefile.js"></script>
</head>
~~~

~~~ html
<body>
  <script>
  var a = 1;
  a++;
  </script>
</body>
~~~




## 基本语法


### 变量

1.  var 定义变量

2.  变量名只包含字母、数字、下划线，且数字不能是第一个

    ~~~ javascript
    var a;
    var thisIsAVariable;
    var _and_this_too;
    var mix12three;
    ~~~

3.  定义的同时赋值

    ~~~ javascript
    var a = 1;
    ~~~

4.  同时定义&赋值多个变量

    ~~~ javascript
    var v1, v2, v3 = 'hello', v4 = 4, v5;
    ~~~

5.  The $ character in variable names

    You may see the dollar sign character ($) used in variable names, as in
    $myvar or less commonly my$var. This character is allowed to appear
    anywhere in a variable name, although previous versions of the ECMA
    standard discouraged its use in handwritten programs and suggested
    it should only be used in generated code (programs written by other
    programs). This suggestion is not well respected by the JavaScript
    community, and $ is in fact commonly used in practice as a function name.

6.  变量名大小写敏感


#### 变量作用域

1. If a variable is defined inside a function, it's not visible outside of the function
2. The term "global variables" describes variables you define outside of any function (in the global program code), as opposed to "local variables", which are defined inside a function.
3. if you don't use var to declare a variable, this variable is automatically assigned a global scope.




### 操作符

和Java相同，
算数操作符： `+-*/ ++ -- += -=`
逻辑操作符： `!` `&&` `||`


### 数据类型

#### 原始数据类型

1. Number: 整数 or 浮点数，例如: `1`, `100`, `3.14`.
    1. 八进制，以 `0` 开头：`0377` = 十进制的 255
    2. 十六进制，以 `0x` 开头： `0xff` = 十进制的 255
    3. 指数表示，`数字e指数` ： `2e+3` = 2 x 1000 = 2000
    4. Infinity
    5. NaN
2. String: 字符串，例如： "a", "one", and "one 2 three".
    1. \u加四个数字，表示unicode特殊字符，例如："\u0421\u0442\u043E\u044F\u043D" = "Стoян"
    2. \r 回车； \n 换行； \t 制表符；
3. Boolean: `true` or `false`.
    1. 任何类型，可以用两个逻辑否转换成boolean值，例如：var b = "one"; !!b == true
        可以转换为 true 的值：
        * 空字符串
        * null
        * undefined
        * `0`
        * 'NaN`
4. Undefined: `undefined` 。不存在的变量、声明后未赋值的变量。
5. Null: `null`。 It means no value, an empty value, or nothing. The difference with undefined is that if a variable has a value null, it's still defined, it just so happens that its value is nothing.

#### typeof 检查变量类型

* typeof 返回值
  * "number"
  * "string"
  * "boolean"
  * "undefined"
  * "object"
  * "function"

例子：

~~~ javascript
var n = 1;
typeof n;

结果：
"number"
~~~


#### 数组

##### 初始化：

~~~ javascript
var a = [];
var a = [1, 2, 3];
~~~

##### 获取数组长度， Array.length



##### 添加、更新元素

~~~ javascript
> a[2] = 'three';
"three"
> a;
[1, 2, "three"]

> a[3] = 'four';
"four"
> a;
[1, 2, "three", "four"]

> var a = [1, 2, 3];
> a[6] = 'new';
"new"
> a;
[1, 2, 3, undefined x 3, "new"]

~~~



##### 删除元素：


~~~ javascript
> var a = [1, 2, 3];
> delete a[1];
true
> a;
[1, undefined, 3]
> typeof a[1];
"undefined"
~~~


##### 数组元素

~~~ javascript
> var a = [1, "two", false, null, undefined];
> a;
[1, "two", false, null, undefined]
> a[5] = [1, 2, 3];
[1, 2, 3]
> a;
[1, "two", false, null, undefined, Array[3]]
~~~



##### 字符串数组

~~~ javascript
> var s = 'one';
> s[0];
"o"
> s[1];
"n"
> s[2];
"e"
~~~






### 流程控制语法

#### if

~~~ javascript
if (a > 2 || a < -2) {
  result = 'a is not between -2 and 2';
} else if (a === 0 && b === 0) {
  result = 'both a and b are zeros';
} else if (a === b) {
  result = 'a and b are equal';
} else {
  result = 'I give up';
}
~~~

#### switch

~~~ javascript
var a = '1',
result = '';
switch (a) {
  case 1:
    result = 'Number 1';
    break;
  case '1':
    result = 'String 1';
    break;
  default:
    result = 'I don\'t know';
    break;
}
~~~

#### while / do-while loop

~~~ javascript
var i = 0;
while (i < 10) {
  i++;
}

~~~

~~~ javascript
var i = 0;
do {
  i++;
} while (i < 10);
~~~


#### for loop

~~~ javascript
if (typeof somevar !== "undefined")var punishment = '';
for (var i = 0; i < 100; i++) {
  punishment += 'I will never do this again, ';
}
~~~

#### for-in loop

~~~ javascript
var a = ['a', 'b', 'c', 'x', 'y', 'z'];
var result = '\n';
for (var i in a) {
  result += 'index: ' + i + ', value: ' + a[i] + '\n';
}
~~~


### 注释

~~~ javascript
// beginning of line

var a = 1; // anywhere on the line

/* multi-line comment on a single line */

/*
comment that spans several lines
*/

~~~


### functions

#### 定义 functions

~~~ javascript
function sum(a, b) {
  var c = a + b;
  return c;
}

> var result = sum(1, 2);
> result;
3

~~~

#### 另一种 定义function 方式，指定function 变量

~~~ javascript
> function define() {
return 1;
}
> var express = function () {
return 1;
};
> typeof define;
"function"
> typeof express;
"function"
~~~


#### Anonymous functions - Callback functions

~~~ javascript
function invokeAdd(a, b) {
  return a() + b();
}

function one() {
  return 1;
}
function two() {
  return 2;
}

> invokeAdd(one, two);
3

// 或者

> invokeAdd(function () {return 1; }, function () {return 2; });
3

// 再或者

> invokeAdd(
  function () { return 1; },
  function () { return 2; }
);
3

~~~

#### Anonymous functions - Immediate functions

匿名函数直接立即执行，用于某些不想引入全局变量的情况。

~~~ javascript
(
  function (name) {
    alert('Hello ' + name + '!');
  }
)('dude');

~~~


#### Inner (private) functions 函数中再定义函数

这种函数，只能在所定义的父函数中调用。

~~~ javascript
function outer(param) {
  function inner(theinput) {
    return theinput * 2;
  }
  return 'The result is ' + inner(param);
}
~~~


#### Functions that return functions

~~~ javascript
function a() {
  alert('A!');
  return function () {
    alert('B!');
  };
}

> var newFunc = a();
> newFunc();

~~~


#### arguments 特殊函数变量

在 function 中用 arguments 这个特殊变量，可以使得 function 可以处理任意数量的参数。

~~~ javascript
> function args() {
return arguments;
}
> args();
[]
> args( 1, 2, 3, 4, true, 'ninja');
[1, 2, 3, 4, true, "ninja"]

~~~


#### 改写自己的 function, rewrite themself

应用场景：一次性工作，之后就不再执行之前的函数体。

~~~ javascript
function a() {
  alert('A!');
  a = function () {
    alert('B!');
  };
}
~~~

~~~ javascript
var a = (function () {
  function someSetup() {
    var setup = 'done';
  }
  function actualWork() {
    alert('Worky-worky');
  }
  someSetup();
  return actualWork;
}());

~~~

#### 动态生成一系列函数

~~~ javascript
function F() {
  function binder(x) {
    return function () {
      return x;
    };
  }
  var arr = [], i;
  for (i = 0; i < 3; i++) {
    arr[i] = binder(i);
  }
  return arr;
}
~~~





## Object

### properties

最简单的Object，就是个 Hash Table：

~~~ javascript
var hero = {
  breed: 'Turtle',
  occupation: 'Ninja'
};
~~~

key 可以用引号括起来，也可以不括，除非有些特殊字符，例如，`空格`，`$`等。

~~~ javascript
var o = {
  $omething: 1,
  'yes or no': 'yes',
  '!@#$%^&*': true
};
~~~

#### Accessing an object's properties

* Using the square bracket notation, for example hero['occupation']
* Using the dot notation, for example hero.occupation
  * 某些场合不能用，例如，property 名字不是合法的变量名字

~~~ javascript
var book = {
  name: 'Catch-22',
  published: 1961,
  author: {
    firstname: 'Joseph',
    lastname: 'Heller'
  }
};

> book.author.firstname;
"Joseph"
> book['author']['lastname'];
"Heller"
> book.author['lastname'];
"Heller"
> book['author'].lastname;
"Heller"

> var key = 'firstname';
> book.author[key];
"Joseph"

~~~






### methods

~~~ javascript
var hero = {
  breed: 'Turtle',
  occupation: 'Ninja',
  say: function () {
    return 'I am ' + hero.occupation;
  }
};

> hero.say();
"I am Ninja"
> hero['say']();
"I am Ninja"
~~~



### 动态修改 properties & methods

~~~ javascript
> var hero = {};

> typeof hero.breed;
"undefined"

> hero.breed = 'turtle';
> hero.name = 'Leonardo';
> hero.sayName = function () {
    return hero.name;
  };

> hero.sayName();
"Leonardo"

> delete hero.name;
true

> hero.sayName();
"undefined"

~~~


### this 关键字

~~~ javascript
> var hero = {
  name: 'Rafaelo',
  sayName: function () {
    return this.name;
  }
};
> hero.sayName();
"Rafaelo"
~~~

### 构造函数

构造函数，其实就是Class定义，以 function 形式存在。

编码约定：作为构造函数的function name ，首字母大写。

~~~javascript
function Hero(name) {
  this.name = name;
  this.occupation = 'Ninja';
  this.whoAreYou = function () {
    return "I'm " + this.name + " and I'm a " + this.occupation;
  };
}

> var h1 = new Hero('Michelangelo');
> var h2 = new Hero('Donatello');
> h1.whoAreYou();
"I'm Michelangelo and I'm a Ninja"
> h2.whoAreYou();
"I'm Donatello and I'm a Ninja"

~~~

#### 查看对象的构造函数 some-object.constructor

~~~ javascript
> h2.constructor;
function Hero(name) {
  this.name = name;
}
~~~

提取 object 的构造方法，来构造一个新的同类型对象。

~~~ javascript
> var h3 = new h2.constructor('Rafaello');
> h3.name;
"Rafaello"
~~~


#### instanceof

~~~ javascript
> function Hero() {}
> var h = new Hero();
> var o = {};
> h instanceof Hero;
true
> h instanceof Object;
true
> o instanceof Object;
true
~~~


#### Object 赋值都是传递的引用

~~~ javascript
> var original = {howmany: 1};
> var mycopy = original;
> mycopy.howmany;
1
> mycopy.howmany = 100;
100
> original.howmany;
100
~~~

~~~ javascript
>
>
>
>
0
var original = {howmany: 100};
var nullify = function (o) { o.howmany = 0; };
nullify(original);

~~~


#### compare objects

When you compare objects, you'll get true only if you compare two references to the same object.

~~~ javascript
> var fido = {breed: 'dog'};
> var benji = {breed: 'dog'};
> benji === fido;
false
> benji == fido;
false
~~~











### Global Object

* The host environment provides a global object and all global variables are accessible as properties of the global object.
* If your host environment is the web browser, the global object is called `window`.
  * 在所有函数外面使用 `this`，也能访问到全局对象。

~~~ javascript
> var a = 1;
> window.a;
1
> this.a;
1
~~~

#### built-in function

全局函数，实际也是 全局对象的属性。

~~~ javascript
> parseInt('101 dalmatians');
101
> window.parseInt('101 dalmatians');
101
> this.parseInt('101 dalmatians');
101

~~~











## Prototype


### 指定 Prototype 为 object 对象

~~~ javascript
foo.prototype = {};

> typeof foo.prototype;
"object"
~~~


### 向 prototype 添加属性&方法

~~~ javascript
function Gadget(name, color) {
  this.name = name;
  this.color = color;
  this.whatAreYou = function() {
    return 'I am a ' + this.color + ' ' + this.name; 
  };
}
~~~

另外一种方法：

~~~ javascript
Gadget.prototype.price = 100;
Gadget.prototype.rating = 3;
Gadget.prototype.getInfo = function () {
  return 'Rating: ' + this.rating +
    ', price: ' + this.price;
};
~~~



### object 属性访问，沿prototype溯源而上

some-object.some-property 取值顺序：
1. 寻找 some-object 自己的属性 some-property 有没有值
    有则返回，否则，继续
2. 寻找 some-object.constructor.prototype 是否有属性 some-property 
    有则返回，否则，溯源而上，寻找 prototype 的 prototype 是否有此属性

~~~ javascript
var newtoy = new Gadget('webcam', 'black');

> newtoy.name;
"webcam"
> newtoy.rating;   // 获取的是 prototype 的属性
3

> newtoy.constructor === Gadget;
true
> newtoy.constructor.prototype.rating;
3

// 追溯到 object's toString() method
> newtoy.toString();
"[object Object]"

~~~


#### `hasOwnProperty`检查是否 object 自己的属性，而不是prototype 的

~~~ javascript
> Object.prototype.hasOwnProperty('toString');
true
~~~


#### object 自己的同名属性，优先于（覆盖）prototype的属性

~~~ javascript
> function Gadget(name) {
this.name = name;
}
> Gadget.prototype.name = 'mirror';

> var toy = new Gadget('camera');
> toy.name;
"camera"

> toy.hasOwnProperty('name');
true

// 删除 object 自有属性后，溯源到 prototype的属性

> delete toy.name;
true
> toy.name;
"mirror"
> toy.hasOwnProperty('name');
false

// 直接复制，添加对象属性

> toy.name = 'camera';
> toy.name;
"camera"

// 方法也是属性

> toy.toString();
"[object Object]"
> toy.hasOwnProperty('toString');
false

// toString 是 Object.prototype 的属性

> toy.constructor.hasOwnProperty('toString');
false
> toy.constructor.prototype.hasOwnProperty('toString');
false
> Object.hasOwnProperty('toString');
false
> Object.prototype.hasOwnProperty('toString');
true

~~~


### 遍历对象的属性 enumerating properties

~~~ javascript
var params = {
  productid: 666,
  section: 'products'
};
var url = 'http://example.org/page.php?',
    i,
    query = [];
    
// 遍历对象的属性
for (i in params) {
  query.push(i + '=' + params[i]);
}
url += query.join('&');

~~~

#### enumerable

* 不是所有属性都是能遍历出来的，能否遍历用 `propertyIsEnumerable` 检查。
  * `propertyIsEnumerable()` returns `false` for all of the prototype's properties, even those that are enumerable and show up in the for-in loop.
* ES5 可以指定属性是否 enumerable ， 而ES3没有这个自由。

~~~ javascript
function Gadget(name, color) {
  this.name = name;
  this.color = color;
  this.getName = function () {
    return this.name;
  };
}
Gadget.prototype.price = 100;
Gadget.prototype.rating = 3;

var newtoy = new Gadget('webcam', 'black');
for (var prop in newtoy) {
  console.log(prop + ' = ' + newtoy[prop]);
}

// 结果：
name = webcam
color = black
getName = function () {
  return this.name;
}
price = 100
rating = 3

~~~

~~~ javascript
// 只打印自有属性
for (var prop in newtoy) {
  if (newtoy.hasOwnProperty(prop)) {
    console.log(prop + '=' + newtoy[prop]);
  }
}

// 结果：
name=webcam
color=black
getName = function () {
return this.name;
}
~~~

~~~ javascript
> newtoy.propertyIsEnumerable('name');
true

// Most built-in properties and methods are not enumerable.
> newtoy.propertyIsEnumerable('constructor');
false

Any properties coming down the prototype chain are not enumerable.
> newtoy.propertyIsEnumerable('price');
false

// however, that such properties are enumerable if you reach the object contained
// in the prototype and invoke its propertyIsEnumerable() method.
> newtoy.constructor.prototype.propertyIsEnumerable('price');
true

~~~


### `isPrototypeOf()` 检查对象是否是另一个对象的 prototype

~~~ javascript
var monkey = {
  hair: true,
  feeds: 'bananas',
  breathes: 'air'
};

function Human(name) {
  this.name = name;
}
Human.prototype = monkey;

> var george = new Human('George');
> monkey.isPrototypeOf(george);
true

~~~

#### `Object.getPrototypeOf` 获取对象的prototype对象，ES5支持

~~~ javascript
> Object.getPrototypeOf(george).feeds;
"bananas"

> Object.getPrototypeOf(george) === monkey;
true
~~~

#### special property __proto__ 获取对象的prototype对象，ES5之前的某些浏览器支持

* **注意：** IE 不支持 __proto__ 属性。

~~~ javascript
> var monkey = {
feeds: 'bananas',
breathes: 'air'
};
> function Human() {}
> Human.prototype = monkey;

> var developer = new Human();

// 使用 __proto__
> developer.__proto__ === monkey;
true

> typeof developer.__proto__;
"object"
> typeof developer.prototype;
"undefined"
> typeof developer.constructor.prototype;
"object"

~~~




### secret link `__proto__`


### 扩展 built-in 对象


~~~ javascript
// trim() method for strings, which is a method 
//    that exists in ES5 but is missing in older browsers
if (typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/g,'');
  };
}

> " hello ".trim();
"hello"
~~~












## inheritance 继承




### 设置 构造函数的 prototype 后，同时也要设置 prototype.constructor

默认情况下 ，function 对象创建时，function的prototype对象同时创建，且prototype对象的constructor 属性指向自身。

~~~ javascript
> function Cat() {};
"undefined"

> Cat;
function Cat() {}

> Cat.prototype;
Object {constructor: function}
  constructor: function Cat()
  __proto__: Object
~~~

如果修改了 `prototype`，这个 `prototype.constructor` 没有设置，则溯源到 `Object.constructor` : `function Object()`

~~~ javascript
>Cat.prototype = {};
Object {}
  __proto__: Object
    constructor: function Object() { [native code] }
~~~








### 利用 prototype 链实现继承 inheritence

~~~ javascript
function Shape(){
  this.name = 'Shape';
  this.toString = function () {
    return this.name;
  };
}
function TwoDShape(){
  this.name = '2D shape';
}
function Triangle(side, height){
  this.name = 'Triangle';
  this.side = side;
  this.height = height;
  this.getArea = function () {
    return this.side * this.height / 2;
  };
}

// prototype 链
TwoDShape.prototype = new Shape();
Triangle.prototype = new TwoDShape();

// reset the constructor after inheriting
TwoDShape.prototype.constructor = TwoDShape;
Triangle.prototype.constructor = Triangle;

// 访问自己的方法
>var my = new Triangle(5, 10);
>my.getArea();
25

// 通过 prototype 链，访问到祖先类的方法
>my.toString();
"Triangle"

// 重置了Prototype 的 constructor 后， constructor 是正确的
>my.constructor === Triangle;
true

// instanceOf 操作符，可以识别出类型
> my instanceof Shape;
true
> my instanceof TwoDShape;
true
> my instanceof Triangle;
true
> my instanceof Array;
false

// The same happens when you call isPropertyOf()on the constructors passing my:
>Shape.prototype.isPrototypeOf(my);
true
>TwoDShape.prototype.isPrototypeOf(my);
true
>Triangle.prototype.isPrototypeOf(my);
true
>String.prototype.isPrototypeOf(my);
false

// 父类的构造方法同样可以使用
>var td = new TwoDShape();
>td.constructor === TwoDShape;
true
>td.toString();
"2D shape"
>var s = new Shape();
>s.constructor === Shape;
true
~~~


### 利用临时构造方法，实现继承 inheritence

this approach supports the idea that only properties and methods
added to the prototype should be inherited, and own properties should not. 


~~~ javascript
// Shape 类

function Shape() {}
// augment prototype
Shape.prototype.name = 'Shape';
Shape.prototype.toString = function () {
  return this.name;
};

// TwoDShape 类

function TwoDShape() {}
// take care of inheritance
var F = function () {};
F.prototype = Shape.prototype;
TwoDShape.prototype = new F();
TwoDShape.prototype.constructor = TwoDShape;
// augment prototype
TwoDShape.prototype.name = '2D shape';

// Triangle 类

function Triangle(side, height) {
  this.side = side;
  this.height = height;
}
// take care of inheritance
var F = function () {};
F.prototype = TwoDShape.prototype;
Triangle.prototype = new F();
Triangle.prototype.constructor = Triangle;
// augment prototype
Triangle.prototype.name = 'Triangle';
Triangle.prototype.getArea = function () {
  return this.side * this.height / 2;
};

// ---- 开始测试

>var my = new Triangle(5, 10);
>my.getArea();
25
>my.toString();
"Triangle"

// 检查 Prototype 链

>my.__proto__ === Triangle.prototype;
true
>my.__proto__.constructor === Triangle;
true
>my.__proto__.__proto__ === TwoDShape.prototype;
true
>my.__proto__.__proto__.__proto__.constructor === Shape;
true

// also the parents' properties are not overwritten by the children:
>var s = new Shape();
>s.name;
"Shape"

>"I am a " + new TwoDShape(); // calling toString()
"I am a 2D shape"

~~~





### 继承的语法，收拢到 `extend` 函数，以便 _复用_

#### extend

~~~ javascript
function extend(Child, Parent) {
  var F = function () {};
  F.prototype = Parent.prototype;
  Child.prototype = new F();
  Child.prototype.constructor = Child;
  Child.uber = Parent.prototype;
}
~~~ 

>> 如下是使用了 extend 继承函数的例子
>
>~~~ javascript
>// define -> augment
>function Shape() {}
>Shape.prototype.name = 'Shape';
>Shape.prototype.toString = function () {
>  return this.constructor.uber
>  ? this.constructor.uber.toString() + ', ' + this.name
>  : this.name;
>};
>// define -> inherit -> augment
>function TwoDShape() {}
>extend(TwoDShape, Shape); // 继承～～～
>TwoDShape.prototype.name = '2D shape';
>~~~



#### extend2 , copy properties

~~~ javascript
function extend2(Child, Parent) {
  var p = Parent.prototype;
  var c = Child.prototype;
  for (var i in p) {
    c[i] = p[i];
  }
  c.uber = p;
}
~~~


### Extend Copy, Shallow Copy 不需要 prototype，对象之间直接继承

~~~ javascript
function extendCopy(p) {
  var c = {};
  for (vari in p) {
    c[i] = p[i];
  }
  c.uber = p;
  return c;
}

// 基础对象
var shape = {
  name: 'Shape',
  toString: function () {
    return this.name;
  }
};

// 继承一次
var twoDee = extendCopy(shape);
twoDee.name = '2D shape';
twoDee.toString = function () {
  return this.uber.toString() + ', ' + this.name;
};

// 继承两次
var triangle = extendCopy(twoDee);
triangle.name = 'Triangle';
triangle.getArea = function () {
  return this.side * this.height / 2;
};

// 使用对象
>triangle.side = 5;
>triangle.height = 10;
>triangle.getArea();
25
>triangle.toString();
"Shape, 2D shape, Triangle"

~~~



### Deep Copy

相对只拷贝 reference 的 _shallow copy_

deep copy 是个迭代的过程。

~~~ javascript
function deepCopy(p, c) {
  c = c || {};
  for (var i in p) {
    if (p.hasOwnProperty(i)) {
      if (typeof p[i] === 'object') {
        c[i] = Array.isArray(p[i]) ? [] : {};
        deepCopy(p[i], c[i]);
      } else {
        c[i] = p[i];
      }
    }
  }
  return c;
}

~~~

* 注意： `Array.isArray()` exists since ES5 ，要兼容 ES3的browser，使用如下自定义函数：

    ~~~ javascript
    if (Array.isArray !== "function") {
      Array.isArray = function (candidate) {
        return Object.prototype.toString.call(candidate) === '[object Array]';
      };
    }
    ~~~



### Object.create

~~~ javascript
>var square = Object.create(triangle);
~~~

`Object.create` 相当于 如下的 object()

~~~ javascript
function object(o) {
  var n;
  function F() {}
  F.prototype = o;
  n = new F();
  n.uber = o;
  return n;
}

// 使用
var triangle = object(twoDee);
triangle.name = 'Triangle';
triangle.getArea = function () {
  return this.side * this.height / 2;
};

>triangle.toString();
"Shape, 2D shape, Triangle"

~~~


### prototype inheritence 和 copy properties 混合使用

* Use prototypal inheritance to use an existing object as a prototype of a new one
* Copy all of the properties of another object into the newly created one

~~~ javascript
function objectPlus(o, stuff) {
  var n;
  function F() {}
  F.prototype = o;
  n = new F();
  n.uber = o;
  for (var i in stuff) {
    n[i] = stuff[i];
  }
  return n;
}

// Create a 2D object by inheriting shape and adding more properties. 
var twoDee = objectPlus(shape, {
  name: '2D shape',
  toString: function () {
    return this.uber.toString() + ', ' + this.name;
  }
});

// create a triangle object that inherits from 2D and adds more properties.
var triangle = objectPlus( twoDee, {
  name: 'Triangle',
  getArea: function () {
    return this.side * this.height / 2;
  },
  side: 0,
  height: 0
});

// creating a concrete triangle my with defined side and height
var my = objectPlus(triangle, {
  side: 4, height: 4
});
>my.getArea();
8
>my.toString();
"Shape, 2D shape, Triangle, Triangle"

~~~


### 多重继承 multiple inheritence

~~~ javascript
function multi() {
  var n = {}, stuff, j = 0, len = arguments.length;
  for (j = 0; j <len; j++) {
    stuff = arguments[j];
    for (vari in stuff) {
      if (stuff.hasOwnProperty(i)) {
        n[i] = stuff[i];
      }
    }
  }
  return n;
}

var shape = {
  name: 'Shape',
  toString: function () { return this.name; }
};

vartwoDee = {
  name: '2D shape',
  dimensions: 2
};

var triangle = multi(shape, twoDee, {
  name: 'Triangle',
  getArea: function () {
    return this.side * this.height / 2;
  },
  side: 5,
  height: 10
});

>triangle.getArea();
25
>triangle.dimensions;
2
>triangle.toString();
"Triangle"
~~~

#### Mixins

需要某些 object 的方法，又不需要 这些object 进入 inheritence 序列，

就可以使用上述 `multi()` ，将方法和参数 “mixin” 进来。



### 寄生继承 Parasitic Inheritence

~~~ javascript
vartwoD = {
  name: '2D shape',
  dimensions: 2
};

function triangle(s, h) {
  var that = object(twoD);
  that.name ='Triangle';
  that.getArea = function () {
    return this.side * this.height / 2;
  };
  that.side = s;
  that.height = h;
  return that;
}

// Because triangle() is a normal function, not a constructor, it doesn't require the new
operator. 
>var t = triangle(5, 10);
>t.dimensions;
2

// But because it returns an object, calling it with new by mistake works too.
>vart2 = new triangle(5,5);
>t2.getArea();
12.5

~~~




### 借用父类构造器的继承 borrowing a constructor

This can be called stealing a constructor, or inheritance by
borrowing a constructor 

~~~ javascript
function Shape(id) {
  this.id = id;
}
Shape.prototype.name = 'Shape';
Shape.prototype.toString = function () {
  return this.name;
};

function Triangle() {
  // 利用 Object.apply 借用 Shape's constructor
  Shape.apply(this, arguments);
}
Triangle.prototype.name = 'Triangle';

>var t = new Triangle(101);
>t.name;
"Triangle"

>t.id;
101

// The triangle failed to get the Shape function's prototype properties 
// because there was never a new Shape() instance created, so the prototype was never used. 

>t.toString();
"[object Object]"

// ---
// 利用 prototype 继承
function Triangle() {
  Shape.apply(this, arguments);
}
Triangle.prototype = new Shape();
Triangle.prototype.name = 'Triangle';
~~~


#### Borrow a constructor and copy its prototype

~~~ javascript
function Shape(id) {
  this.id = id;
}
Shape.prototype.name = 'Shape';
Shape.prototype.toString = function () {
  return this.name;
};
function Triangle() {
  Shape.apply(this, arguments);
}
extend2(Triangle, Shape);
Triangle.prototype.name = 'Triangle';

// Testing

>var t = new Triangle(101);
>t.toString();
"Triangle"
>t.id;
101

// No double inheritance:
>typeof t.__proto__.id;
"undefined"

~~~

















## WebKit console

* 参考
  * <http://www.ruanyifeng.com/blog/2011/03/firebug_console_tutorial.html>
  * [Firebug Tutorial - Logging, Profiling and CommandLine (Part I)](http://michaelsync.net/2007/09/09/firebug-tutorial-logging-profiling-and-commandline-part-i)
  * [Firebug Tutorial - Logging, Profiling and CommandLine (Part II)](http://michaelsync.net/2007/09/10/firebug-tutorial-logging-profiling-and-commandline-part-ii)

`WebKit console` 提供了 `console` 对象来向 console 输出内容。




### console.log() , error(), debug(), warn()

* console.log()
  * 输出日志
* console.error()
  * 输出错误日志，红色高亮。

![](console.png)



### 占位符

console对象的上面5种方法，都可以使用printf风格的占位符。不过，占位符的种类比较少，只支持字符（%s）、整数（%d或%i）、浮点数（%f）和对象（%o）四种。

~~~ javascript
console.log("%d年%d月%d日",2011,3,26);
console.log("圆周率是%f",3.1415926);
~~~

`%o` 占位符，可以用来查看一个对象内部情况。比如，有这样一个对象：

~~~ javascript
var dog = {} ;
dog.name = "大毛" ;
dog.color = "黄色";

console.log("%o",dog);
~~~


### 分组显示， console.group() 和 console.groupEnd()

如果信息太多，可以分组显示，用到的方法是console.group()和console.groupEnd()。

~~~ javascript
console.group("第一组信息");
console.log("第一组第一条");
console.log("第一组第二条");
console.groupEnd();

console.group("第二组信息");
console.log("第二组第一条");
console.log("第二组第二条");
console.groupEnd();
~~~

![](console分组显示.png)


### console.dir()

`console.dir()` 可以显示一个对象所有的属性和方法。

~~~ javascript
// 例如，查看document对象的属性和方法
console.dir(document)
~~~





### console.dirxml()

`console.dirxml()` 用来显示网页的某个节点（node）所包含的html/xml 文档内容。

~~~ javascript
var table = document.getElementById("table1");
console.dirxml(table);
~~~



### console.assert()

`console.assert()` 用来判断一个表达式或变量是否为真。

如果结果为否，则在控制台输出一条相应信息，并且抛出一个异常。

~~~ javascript
var result = 0;
console.assert( result );
var year = 2000;
console.assert(year == 2011 );
~~~

![](console-assert断言.png)



### console.trace()

`console.trace()` 用来追踪函数的调用轨迹。

~~~ javascript
function add(a,b) {
  console.trace();
  return a+b;
}

var x = add3(1,1);
function add3(a,b){return add2(a,b);}
function add2(a,b){return add1(a,b);}
function add1(a,b){return add(a,b);}
~~~

运行后，会显示add()的调用轨迹，从上到下依次为add()、add1()、add2()、add3()。

![](console-trace效果示意.png)




### 计时功能 `console.time()` 和 `console.timeEnd()`

`console.time()` 和 `console.timeEnd()` ，用来显示代码的运行时间。

~~~ javascript
console.time("计时器一");
for(var i=0;i<1000;i++){
  for(var j=0;j<1000;j++){}
}
console.timeEnd("计时器一");
~~~

![](console计时器示意.png)


### 性能分析 console.profile()

性能分析（Profiler）就是分析程序各个部分的运行时间，找出瓶颈所在，使用的方法是console.profile()。

假定有一个函数Foo()，里面调用了另外两个函数funcA()和funcB()，其中funcA()调用10次，funcB()调用1次。


~~~ javascript
function Foo(){
  for(var i=0;i<10;i++) { funcA(1000); }
  funcB(10000);
}
function funcA(count){
  for(var i=0;i<count;i++){}
}
function funcB(count){
  for(var i=0;i<count;i++){}
}
~~~

然后，就可以分析Foo()的运行性能了。

~~~ javascript
console.profile('性能分析器一');
Foo();
console.profileEnd();
~~~

控制台会显示一张性能分析表，如下图。

![](console性能分析示例.png)

除了使用console.profile()方法，firebug还提供了一个"概况"（Profiler）按钮。第一次点击该按钮，"性能分析"开始，你可以对网页进行某种操作（比如ajax操作），然后第二次点击该按钮，"性能分析"结束，该操作引发的所有运算就会进行性能分析。



## 常用技巧



### typeof 检查变量是否存在

~~~ javascript
if (typeof somevar !== "undefined")
~~~


### 类型转换

#### parseInt()

~~~ javascript
> parseInt('123');
123
> parseInt('abc123');
NaN
> parseInt('1abc23');
1
> parseInt('123abc');
123
~~~

* 第二个参数，是使用的什么进制，缺省为 10 进制。

~~~ javascript
> parseInt('FF', 10);
NaN
> parseInt('FF', 16);
255

> parseInt('0377', 10);
377
> parseInt('0377', 8);
255
~~~


#### parseFloat()

~~~ javascript
> parseFloat('1.23');
1.23
> parseFloat('a123.34');
NaN
> parseFloat('12a3.34');
12
~~~

支持指数

~~~ javascript
> parseFloat('123e-2');
1.23
> parseFloat('1e10');
10000000000
> parseInt('1e10');
1
~~~



#### isNaN()

~~~ javascript
> isNaN(NaN);
true
> isNaN(123);
false
> isNaN(1.23);
false
> isNaN(parseInt('abc123'));
true

// 遇到字符串参数，自动转化为数字

> isNaN('1.23');
false
> isNaN('a1.23');
true

~~~

#### isFinite()

~~~ javascript
> isFinite(Infinity);
false
> isFinite(-Infinity);
false
> isFinite(12);
true
> isFinite(1e308);
true
> isFinite(1e309);
false
~~~

the biggest number in JavaScript is 1.7976931348623157e+308, so 1e309 is effectively infinity.



#### 数字转换为字符串

参见： [数字转换为字符串](#number-to-string)







### Encode/decode URIs

* encodeURI()
* decodeURI()
* encodeURIComponent()
* decodeURIComponent()

encodeURI() 与 encodeURIComponent() 的区别是，前者encode 整个 url，后者encode所有可以编码的字符，一般用于 encode query string。

~~~ javascript
> var url = 'http://www.packtpub.com/script.php?q=this and that';
> encodeURI(url);
"http://www.packtpub.com/script.php?q=this%20and%20that"

> encodeURIComponent(url);
"http%3A%2F%2Fwww.packtpub.com%2Fscr%20ipt.php%3Fq%3Dthis%20and%20that"

~~~

* 注意 escape() and unescape() 编码函数已经废弃，使用的老旧的编码规范。



### eval()

接受代码字符串，并执行。

~~~ javascript
> eval('var ii = 2;');
> ii;
2
~~~


### 使用 `Object.toString` 检查 object 的类型

~~~ javascript
> Object.prototype.toString.call({});
"[object Object]"
> Object.prototype.toString.call([]);
"[object Array]"
~~~

~~~ javascript
// 简化
> var toStr = Object.prototype.toString;
~~~


~~~ javascript
// 函数参数的类型 the array-like object arguments

> (function () {
return toStr.call(arguments);
}());
"[object Arguments]"
~~~

~~~ javascript
// inspect DOM elements
> toStr.call(document.body);
"[object HTMLBodyElement]"
~~~


### shims , polyfills 对“老版本浏览器”的兼容插件


