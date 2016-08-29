---
layout: post
title: Android：软键盘自动隐藏
description: 
categories: [android, dev]
tags: [android]
---

参考：
<http://karimvarela.com/2012/07/24/android-how-to-hide-keyboard-by-touching-screen-outside-keyboard/>

调用InputMethodManager隐藏Soft Keyboard

{% highlight java %}
/**
* Hides virtual keyboard
*/
protected void hideKeyboard(View view)
{
    InputMethodManager in = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
    in.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
}
{% endhighlight %}

可以在content layout设置下：


{% highlight java %}
content-layout.setOnTouchListener(new OnTouchListener()
{
    @Override
    public boolean onTouch(View view, MotionEvent ev)
    {
        hideKeyboard(view);
        return false;
    }
});
{% endhighlight %}

content-layout 可以在layout-xml中命名id获得：

inearLayout layout =(LinearLayout) findViewById(R.id.layout);

也可以直接从activity获得：

this-activity.findViewById(android.R.id.content);



