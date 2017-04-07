---
layout: post
title: android studio 编译时，忽略 lint 检查
categories: [cm, android]
tags: [android studio, lint]
---

## 问题

在 Android Studio 打包 apk  时候，老是报告 lint 问题，build 失败。

我不care这些问题呀，让我生成一个 apk ！

## 解决

在 app/build.gradle 的 android {...} 中添加

```
    lintOptions {
        checkReleaseBuilds false
        abortOnError false
    }
```

例如：

```
android {
    compileSdkVersion 21
    buildToolsVersion '25.0.0'

    defaultConfig {
        applicationId "com.qa.swatapk.rt"
        minSdkVersion 11
        targetSdkVersion 21
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.txt'
        }
    }

    lintOptions {
        checkReleaseBuilds false
        abortOnError false
    }
}
```