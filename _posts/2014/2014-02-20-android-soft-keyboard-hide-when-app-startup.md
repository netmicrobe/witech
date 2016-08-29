---
layout: post
title: Android：软键盘app启动时自动隐藏或显示
description: 
categories: [android, dev]
tags: [android]
---

## 最简单的方法：

在AndroidManifest中为Acitivity添加属性：

android:windowSoftInputMode="stateHidden"

## 其他方法：

### 方法一，在onCreate中postDelay隐藏的操作

{% highlight java %}
this.findViewById(android.R.id.content).postDelayed(new Runnable(){

    @Override
    public void run() {
        InputMethodManager im = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        im.hideSoftInputFromWindow(this.findViewById(android.R.id.content).getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
    }
    
}, 500);
{% endhighlight %}

### 方法二，在onCreate注册到某个UI组件的回调中

{% highlight java %}
m_SpinnerFeenoHead.setOnItemSelectedListener(new OnItemSelectedListener(){
    @Override
    public void onItemSelected(AdapterView<?> arg0, View arg1,
            int arg2, long arg3) {

                InputMethodManager im = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        im.hideSoftInputFromWindow(this.findViewById(android.R.id.content).getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
    }

    @Override
    public void onNothingSelected(AdapterView<?> arg0) {
        // TODO Auto-generated method stub
        
    }
});
{% endhighlight %}




