---
layout: post
title: android studio 编译时，忽略 lint 的“miss translation”检查
categories: [cm, android]
tags: [android studio, lint]
---

* 参考
  * [Android Studio showing Errors(Missing Translation) after Updating](http://quabr.com/42646003/android-studio-showing-errorsmissing-translation-after-updating)


## 2种方法

### 修改 app 的 build.gradle

```
android {
     lintOptions {
        disable 'MissingTranslation'
    }
}
```

### 在 resource xml 文件中声明 “忽略翻译检查”

```
<?xml version="1.0" encoding="utf-8"?>
<resources
  xmlns:tools="http://schemas.android.com/tools"
  tools:ignore="MissingTranslation" >

  <!-- your strings here; no need now for the translatable attribute -->

</resources>
```






