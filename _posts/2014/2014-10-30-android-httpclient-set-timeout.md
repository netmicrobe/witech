---
layout: post
title: android httpclient 设置超时时间
description: 
categories: [android, dev]
tags: [android]
---

{% highlight java %}
try {  
    httpClient.getParams().setParameter("http.socket.timeout", new Integer(30000));  
    HttpResponse response=httpClient.execute(httpPost);  
    Log.i(TAG, "QHttpClient httpPostWithFile [2] StatusLine = "+response.getStatusLine());  
    responseData =EntityUtils.toString(response.getEntity());  
} catch (Exception e) {  
    e.printStackTrace();  
}finally{  
    httpPost.abort();  
}
{% endhighlight %}
