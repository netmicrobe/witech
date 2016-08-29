---
layout: post
title: Android：从网页启动客户端，若未安装，跳转到下载地址
description: 
categories: [android, dev]
tags: [android]
---

<http://m3.ifengimg.com/f8fe07623a924fa0/2014/0603/vlongHeadMobile1.js>

{% highlight javascript %}
/*客户端上下banner拉起
 *函数变量名称pullAd
 *安卓下先尝试拉起客户端，再跳到下载链接；IOS直接跳转至下载链接
*/           
var pullAd = function(elementId, cookieId, closeId,col){   
  if ( $(elementId) ) {
    if ( ( device.config.os.android || device.config.os.ios ) 
      && (getCookie(cookieId) !== 'hide' 
      || document.cookie === '') ) {
      
      $(elementId).style.display = 'block'; //banner显示
      
      $(elementId).onclick = function() {  
        //alert("navigator.userAgent" + navigator.userAgent);
        if (navigator.userAgent.indexOf("Linux")>-1) {
          setTimeout(function () {
            //alert("up:"+"ifengVideoPlayer://video/"+GuId+"/h5");
            //public_client_auto("ifengVideoPlayer://video/"+window['videoinfo']['id']+"/h5");
            public_client_auto("ifengVideoPlayer://video/"+GuId+"/h5");
            //alert("end");
          }, 200);      
          setTimeout(function () {                             
            if(document.hasFocus() ) {                                                         
              window.open('http://api.3g.ifeng.com/ifengvideo_tg20?vt=5', 'target=_blank', '');
            }
          }, 1000);
        } else { //if not android
          window.open('http://api.3g.ifeng.com/ifengvideo_tg20?vt=5', 'target=_blank', '');
        }
      }
      
      $(closeId).onclick = function(e) {
        setCookie(cookieId, 'hide');
        $(elementId).style.display = 'none';
        if (e.stopPropagation) {
          e.stopPropagation()
        } else {
          e.cancelBubble = true
        }
      }
    }
    else
    {
      // not android or ios
      $(elementId).style.display = 'none'
    }
  }
};
{% endhighlight %}
