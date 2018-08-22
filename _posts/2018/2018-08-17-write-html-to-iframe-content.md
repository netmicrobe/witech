---
layout: post
title: 向iframe直接写入html内容
categories: [ dev, web ]
tags: [javascript]
---


---

* REFER TO
  * [Injecting HTML into an IFrame](http://softwareas.com/injecting-html-into-an-iframe/)


---


~~~ javascript
var content = "<html><body>" + text + "</body></html>";

var iframe = document.createElement("iframe");
document.body.appendChild(iframe);

var doc = iframe.document;
if(iframe.contentDocument)
    doc = iframe.contentDocument; // For NS6
else if(iframe.contentWindow)
    doc = iframe.contentWindow.document; // For IE5.5 and IE6

// Put the content in the iframe
doc.open();
doc.writeln(content);
doc.close();

~~~

* 操作 iframe document 的 DOM

  ~~~ javascript
  // Load the content into a TiddlyWiki() object
      var storeArea = doc.getElementById("storeArea");
  };
  ~~~





















































