---
layout: post
title: JavaScript 内建对象 built-in objects
categories: [dev, web]
tags: [JavaScript, oop, object-oriented, js-built-in]
---

* 参考
  * 《 Object-Oriented JavaScript 》.2nd - Stoyan.Stefanov


## Built-in Objects

* Data wrapper objects
  * Object, Array, Function, Boolean, Number, and String
* Utility objects
  * Math, Date, and RegExp
* Error objects
  * Error, other error objects


### Object

~~~ javascript
> var o = {};
> var o = new Object();
~~~

* The `.constructor` property returns a reference to the constructor function
* `o.toString()` is a method that returns a string representation of the object
* `o.valueOf()` returns a single-value representation of the object; often this is the object itself






### Array

~~~ javascript
> var a = new Array();
> var a = [];
~~~

* `[]` 获取元素
* `length` 数组中元素数目
* `push()` 在数组末尾追加一个元素，返回数组大小
* `pop()` 删除数组末尾元素，并返回该元素
* `sort()` sorts the array and returns it. 
* `join(glue-str)` 返回一个字符串，用 glue-str 将数组所有元素连接在一起。
* `slice(start-index, end-index)` 从数组中切除一段形成新数组，并返回；原数组不改变。
* `splice(start-index, length, inject-element-01, inject-element-02, ...)`  The first two parameters define the start index and length (number of elements) of the slice to be removed; the other parameters pass the new values:。modifies the source array。

#### length

可以设置 length 来改变数组大小

~~~ javascript
> var a = [];
> a[0] = 1;
> a.length;
1

放大

> a.length = 5;
5
> a;
[1, undefined x 4]

缩小

> a.length = 2;
2
> a;
[1, undefined x 1]

~~~

#### push & pop

* `push()` 在数组末尾追加一个元素，返回数组大小
* `pop()` 删除数组末尾元素，并返回该元素

~~~ javascript
> var a = [3, 5, 1, 7, 'test'];
> a.push('new');
6
> a;
[3, 5, 1, 7, "test", "new"]
> a.pop();
"new"
> a;
[3, 5, 1, 7, "test"]
~~~

#### sort

* `sort()` sorts the array and returns it. 

~~~ javascript
> var b = a.sort();
> b;
[1, 3, 5, 7, "test"]
> a === b;
true
~~~

#### join

* `join(glue-str)` 返回一个字符串，用 glue-str 将数组所有元素连接在一起。

~~~ javascript
> a.join(' is not ');
"1 is not 3 is not 5 is not 7 is not test"
~~~

#### slice

* `slice(start-index, end-index)` 从数组中切除一段形成新数组，并返回；原数组不改变。

~~~ javascript
> b = a.slice(1, 3);
[3, 5]
> b = a.slice(0, 1);
[1]
> b = a.slice(0, 2);
[1, 3]
> a;
[1, 3, 5, 7, "test"]
~~~

#### splice

* `splice(start-index, length, inject-element-01, inject-element-02, ...)`  The first two parameters define the start index and length (number of elements) of the slice to be removed; the other parameters pass the new values:。modifies the source array。返回一个新数组，由被替换的元素组成。

~~~ javascript
> b = a.splice(1, 2, 100, 101, 102);
[3, 5]
> a;
[1, 100, 101, 102, 7, "test"]
> a.splice(1, 3);
[100, 101, 102]
> a;
[1, 7, "test"]
~~~




### Function

function 实际也是一个 object.

~~~ javascript
> function myfunc(a) {
return a;
}
> myfunc.constructor;
function Function() { [native code] }
~~~

* `length()` 返回能接受的参数的数目
* `prototype` 该属性只对构造函数有意义，返回构造函数所对应的对象模板。
* `toString()` 返回函数定义代码
* `call(object-acts-this, args...)` 将本object 的方法应用到其他object，嫁接啊！
* `apply(object-acts-this， args-array)` 和 `call` 相同，只是参数以数组形式传入
* `arguments` 返回函数参数值列表，返回值类似 array，支持[]、length ，但不是array，不支持 slice()、sort()等方法

#### length

~~~ javascript
> function myfunc(a, b, c) {
return true;
}
> myfunc.length;
3
~~~

#### prototype

* `prototype` 该属性只对构造函数有意义，返回构造函数所对应的对象模板。

~~~ javascript
var ninja = {
  name: 'Ninja',
  say: function () {
    return 'I am a ' + this.name;
  }
};
> function F() {}
> typeof F.prototype;
"object"

> F.prototype = ninja; // 修改构造函数的 prototype 属性，构造出新类型的对象

> var baby_ninja = new F();
> baby_ninja.name;
"Ninja"
> baby_ninja.say();
"I am a Ninja"
~~~

#### toString

* `toString()` 返回函数定义代码

~~~ javascript
> function myfunc(a, b, c) {
return a + b + c;
}
> myfunc.toString();
"function myfunc(a, b, c) {
return a + b + c;
}"

// 内建函数打印不出来代码，只能得到 native code 的提示。

> parseInt.toString();
"function parseInt() { [native code] }"

~~~


#### call & apply

* `call(object-acts-this, args...)` 将本object 的方法应用到其他object，嫁接啊！
* `apply(object-acts-this， args-array)` 和 `call` 相同，只是参数以数组形式传入

~~~ javascript
var some_obj = {
  name: 'Ninja',
  say: function (who) {
    return 'Haya ' + who + ', I am a ' + this.name;
  }
};
> some_obj.say('Dude');
"Haya Dude, I am a Ninja"


> var my_obj = {name: 'Scripting guru'};
> some_obj.say.call(my_obj, 'Dude');         // 以 my_obj 为 this，执行 some_obj.say
"Haya Dude, I am a Scripting guru"


// 用 call 调用多个参数的方法
some_obj.someMethod.call(my_obj, 'a', 'b', 'c');


// apply vs call
some_obj.someMethod.apply(my_obj, ['a', 'b', 'c']);
some_obj.someMethod.call(my_obj, 'a', 'b', 'c');

~~~

#### arguments

* `arguments` 返回函数参数值列表，返回值类似 array，支持[]、length ，但不是array，不支持 slice()、sort()等方法

~~~ javascript
> function f() {
return arguments;
}
> f(1, 2, 3);
[1, 2, 3]
~~~

~~~ javascript
// 将 arguments 转换为 array 的方法
> function f() {
var args = [].slice.call(arguments);
// 或者 Array.prototype.slice.call(arguments)
return args.reverse();
}
> f(1, 2, 3, 4);
[4, 3, 2, 1]
~~~

### Number

使用 new Number 可以创建 Number 对象。

~~~ javascript
> var n = Number('12.12');
> n;
12.12
> typeof n;
"number"
> var n = new Number('12.12');
> typeof n;
"object"
~~~

#### Number 的常量

~~~ javascript
> Number.MAX_VALUE;
1.7976931348623157e+308

> Number.MIN_VALUE;
5e-324

> Number.POSITIVE_INFINITY;
Infinity

> Number.NEGATIVE_INFINITY;
-Infinity

> Number.NaN;
NaN
~~~


#### 数字转换为字符串

[](){: name="number-to-string"}

* `toFixed(小数点后数字数目)`
* `toExponential()`
* `toString(进制)`

~~~ javascript
> var n = new Number(123.456);
> n.toFixed(1);
"123.5"

> (12345).toExponential();
"1.2345e+4"

> var n = new Number(255);
> n.toString();
"255"
> n.toString(10);
"255"
> n.toString(16);
"ff"
> (3).toString(2);
"11"
> (3).toString(10);
"3"

~~~


### String

`new String` 创建 String 对象。

~~~ javascript
> var primitive = 'Hello';
> typeof primitive;
"string"

> var obj = new String('world');
> typeof obj;
"object"
~~~

#### String 对象支持 [] 操作。等效函数 charAt

~~~ javascript
> obj[0];
"w"
> obj[4];
"d"

// 等效函数 charAt
> obj.charAt(4)
"d"

> obj.length;
5
~~~

#### `valueOf` `toString` 都可以返回字符串值

~~~ javascript
> obj.valueOf();
"world"
> obj.toString();
"world"
> obj + "";
"world"
~~~

#### `length` 返回字符串长度

~~~ javascript
> "potato".length;
6
~~~


#### `toUpperCase` & `toLowerCase`

~~~ javascript
> var s = new String("Couch potato");

> s.toUpperCase();
"COUCH POTATO"

> s.toLowerCase();
"couch potato"
~~~


#### 字符串搜索 indexOf & lastIndexOf

未找到匹配字符串返回 -1

~~~ javascript
> var s = new String("Couch potato");

> s.indexOf('o');
1

> s.indexOf('o', 2);
7

> s.lastIndexOf('o');
11

> s.indexOf('Couch');
0

> s.indexOf('couch');  // 未找到匹配字符串返回 -1
-1

~~~


#### slice & substring 提取部分字符串

~~~ javascript
> var s = new String("Couch potato");

> s.slice(1, 5);
"ouch"

> s.substring(1, 5);
"ouch"

> s.slice(1, -1);   // 提取到末尾
"ouch potat"

> s.substring(1, -1); // 反向提取
"C"

~~~


#### split ，将字符串拆成字符串数组

~~~ javascript
> s.split(" ");
["Couch", "potato"]
~~~

#### join ，将字符串数组，组合为字符串

~~~ javascript
> s.split(' ').join(', ');
"Couch, potato"
~~~

#### concat 在字符串末尾追加字符串

~~~ javascript
> s.concat("es");
"Couch potatoes"
~~~



### Math

Math 和其他 built-in 对象不同， 不是构造方法，是一个全局对象，包含使用的常量和方法。

~~~ javascript
// The constant π:
> Math.PI;
3.141592653589793

// Square root of 2:
> Math.SQRT2;
1.4142135623730951

// Euler's constant:
> Math.E;
2.718281828459045

// Natural logarithm of 2:
> Math.LN2;
0.6931471805599453

// Natural logarithm of 10:
> Math.LN10;
2.302585092994046
~~~

#### random() function returns a number between 0 and 1

~~~ javascript
> Math.random();
0.3649461670235814
~~~

For numbers between any two values, use the formula `((max - min) * Math.random()) + min` .

~~~ javascript
// 2-10的随机数
> 8 * Math.random() + 2;
9.175650496668485
~~~


#### 小数转整数，floor, ceil, round

* floor() to round down
* ceil() to round up
* round() to round to the nearest

#### min, max 比较并返回结果

#### 数学计算，乘方、开方、三角函数

* raise to a power using pow()
* find the square root using sqrt()
* trigonometric operations—sin(), cos(), atan()





### Date

#### new Date

* 今天

    ~~~ javascript
    > new Date();
    Wed Feb 27 2013 23:49:28 GMT-0800 (PST)
    ~~~

* 指定日期&时间字符串

    ~~~ javascript
    > new Date('2015 11 12');
    Thu Nov 12 2015 00:00:00 GMT-0800 (PST)
    > new Date('1 1 2016');
    Fri Jan 01 2016 00:00:00 GMT-0800 (PST)
    > new Date('1 mar 2016 5:30');
    Tue Mar 01 2016 05:30:00 GMT-0800 (PST)
    ~~~

* 指定时间部件

    * Year
    * Month: 0 (January) to 11 (December)
    * Day: 1 to 31
    * Hour: 0 to 23
    * Minutes: 0 to 59
    * Seconds: 0 to 59
    * Milliseconds: 0 to 999

    ~~~ javascript
    new Date(2015, 0, 1, 17, 05, 03, 120);
    Tue Jan 01 2015 17:05:03 GMT-0800 (PST)

    > new Date(2016, 1, 29);
    Mon Feb 29 2016 00:00:00 GMT-0800 (PST)

    // 自动转化为下个月第一天
    > new Date(2016, 1, 30);
    Tue Mar 01 2016 00:00:00 GMT-0800 (PST)
    ~~~

* 指定 timestamp

timestamp
: the number of milliseconds since the UNIX epoch, where 0 milliseconds is January 1, 1970

~~~ javascript
> new Date(1357027200000);
Tue Jan 01 2013 00:00:00 GMT-0800 (PST)

~~~

#### set* & get* 操作日期组件

getMonth(), setMonth(), getHours(), setHours(), and so on. 

~~~ javascript

// getMonth , setMonth

> var d = new Date(2015, 1, 1);
> d.toString();
Sun Feb 01 2015 00:00:00 GMT-0800 (PST)

> d.setMonth(2);
1425196800000
> d.toString();
Sun Mar 01 2015 00:00:00 GMT-0800 (PST)

> d.getMonth();
2
~~~

#### gettime 返回 timestamp

#### toDateString 返回日期字符串

~~~ javascript
> var d = new Date(2016, 5, 20);

> d.toDateString();
"Mon Jun 20 2016"
~~~



#### Date 全局对象

* Date() 返回日期字符串

    ~~~ javascript
    > Date();
    Wed Feb 27 2013 23:51:46 GMT-0800 (PST)

    > Date(1, 2, 3, "it doesn't matter");
    Wed Feb 27 2013 23:51:52 GMT-0800 (PST)

    > typeof Date();
    "string"

    > typeof new Date();
    "object"
    ~~~

* Date.parse 将字符串转化为 timestamp

    ~~~ javascript
    > Date.parse('Jan 11, 2018');
    1515657600000
    ~~~

* Date.UTC 将日期组件转化为 UTC timestamp

    其他 Date 函数都是本地时间。Date.UTC 返回的是全球标准时间。
    中国在东8区，比UTC晚8个小时。

    ~~~ javascript
    > Date.UTC(2018, 0, 11);
    1515628800000
    ~~~

* Date.now 返回当前时间的 timestamp

    ~~~ javascript
    > Date.now();
    1362038353044
    > Date.now() === new Date().getTime();
    true
    ~~~




### RegExp 正则表达式

Javascript 使用 Perl 5 的正则表达式 语法。

创建正在表达式对象： 

~~~ javascript
var re = new RegExp("j.*t");

// 等价
> var re = /j.*t/;
~~~

#### RegExp 设置开关

* `g` for global，默认为关/false，搜索到“第一个匹配”后即停止
* `i` for ignoreCase，默认为 false
* `m` for multiline ，默认为 false，不会跨行搜索



~~~ javascript
// 创建RegExp对象时，第二个参数，可以指定开关。

> var re = new RegExp('j.*t', 'gmi');

> re.global;
true
// global 在RegExp对象创建时候指定，之后不能修改
> re.global = false;
> re.global;
true

// 也可以在 pattern 字符串中指定设置
> var re = /j.*t/ig;
> re.global;
true

~~~


#### test & exec 

* `test` 方法检查字符串中是否有匹配项
* `exec` 返回匹配项的数组

~~~ javascript
> /j.*t/.test("Javascript");
false

// ignore case 后就匹配了

> /j.*t/i.test("Javascript");
true

~~~

~~~ javascript
> /j.*t/i.exec("Javascript")[0];
"Javascript

~~~

#### `$&` `$1` 匹配内容复用

[](){: name="regex-reuse" }

~~~ javascript

// $& 表示匹配到的项目
> s.replace(/[A-Z]/g, "_$&");
"_Hello_Java_Script_World"

// $1, $2 模式中使用 () 来标注的匹配项目的部分
 s.replace(/([A-Z])/g, "_$1");
"_Hello_Java_Script_World"

> var email = "stoyan@phpied.com";
> var username = email.replace(/(.*)@.*/, "$1");
> username;
"stoyan"

~~~

#### 支持正则表达式参数的 String methods

* `match()` returns an array of matches
* `search()` returns the position of the first match
* `replace()` allows you to substitute matched text with another string
* `split()` also accepts a regexp when splitting a string into array elements

##### `match` 例子：

~~~ javascript
> var s = new String('HelloJavaScriptWorld');

> s.match(/a/);
["a"]

> s.match(/a/g);
["a", "a"]

> s.match(/j.*a/i);
["Java"]
~~~

* `search` samples

~~~ javascript
> var s = new String('HelloJavaScriptWorld');

> s.search(/j.*a/i);
5
~~~


##### `replace` samples

~~~ javascript
> var s = new String('HelloJavaScriptWorld');

// 删除所有大写字母
> s.replace(/[A-Z]/g, '');
"elloavacriptorld"

// 不带global设置，删除第一个大写字母
> s.replace(/[A-Z]/, '');
"elloJavaScriptWorld"

~~~

其他例子参见： [匹配内容复用](#regex-reuse)

* Replace Callback

    ~~~ javascript
    > function replaceCallback(match) {
      return "_" + match.toLowerCase();
    }

    > s.replace(/[A-Z]/g, replaceCallback);
    "_hello_java_script_world"

    ~~~

    callback function 其实不只一个参数：

    * The first parameter is the match
    * The last is the string being searched
    * The one before last is the position of the match
    * The rest of the parameters contain any strings matched by any groups in your regex pattern

    ~~~ javascript
    > var glob;
    > var re = /(.*)@(.*)\.(.*)/;
    var callback = function () {
      glob = arguments;
      return arguments[1] + ' at ' +
        arguments[2] + ' dot ' +
        arguments[3];
    };

    > "stoyan@phpied.com".replace(re, callback);
    "stoyan at phpied dot com"

    > glob;
    ["stoyan@phpied.com", "stoyan", "phpied", "com", 0,
    "stoyan@phpied.com"]
    ~~~

##### `split`

~~~ javascript
> var csv = 'one, two,three ,four';

// 避免将空格带入数组元素

> csv.split(/\s*,\s*/);
["one", "two", "three", "four"]

~~~


### Error Objects

* Error
  * EvalError
  * RangeError,
  * ReferenceError
  * SyntaxError
  * TypeError
  * URIError


#### try/catch/finally

~~~ javascript
try {
  iDontExist(); // 不存在的方法，调用，FF&chrome会抛出 ReferenceError，IE会抛出 TypeError
} catch (e) {
  alert(e.name + ': ' + e.message);
} finally {
  alert('Finally!');
}
~~~

#### `throw` 抛出自定义 Error

`new Error` 出 error object。

~~~ javascript
try {
  var total = maybeExists();
  if (total === 0) {
    throw new Error('Division by zero!');
  } else {
    alert(50 / total);
  }
} catch (e) {
  alert(e.name + ': ' + e.message);
} finally {
  alert('Finally!');
}

~~~

直接抛出 object

~~~ javascript
throw {
  name: "MyError",
  message: "OMG! Something terrible has happened"
}
~~~


