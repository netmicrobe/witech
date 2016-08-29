---
layout: post
title: Android：解决webview不支持tel scheme链接的问题
categories: [android, dev]
tags: [android]
---

## 问题：

tel:189xxxx
这种链接在浏览器可以调起拨号盘，但是Webview没这功能

## 解决方法 1：

{% highlight java %}
public boolean shouldOverrideUrlLoading(WebView view, String url) {
    if (url.startsWith("tel:")) { 
        Intent intent = new Intent(Intent.ACTION_DIAL,
                Uri.parse(url)); 
        startActivity(intent); 
    }else if(url.startsWith("http:") || url.startsWith("https:")) {
            view.loadUrl(url);
    }
    return true;
}
{% endhighlight %}

## 解决方法 2：

{% highlight java %}
public boolean shouldOverrideUrlLoading(WebView view, String url) {
    if( url.startsWith("http:") || url.startsWith("https:") ) {
        return false;
    }

    // Otherwise allow the OS to handle it
    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
    startActivity( intent ); 
    return true;
}
{% endhighlight %}

参考：<http://stackoverflow.com/questions/4338305/android-webview-tel-links-show-web-page-not-found>





