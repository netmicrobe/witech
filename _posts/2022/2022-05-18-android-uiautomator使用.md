---
layout: post
title: android-uiautomator使用，关联 
categories: []
tags: []
---

* 参考
  * []()
  * []()
  * []()
  * []()
  * [genymotion 模拟器](https://www.genymotion.com/download/)
  * [夜神模拟器](https://www.yeshen.com/)
  * []()
  * [android/testing-samples](https://github.com/android/testing-samples)
  * [Testing UI for Multiple Apps](https://android-doc.github.io/training/testing/ui-testing/uiautomator-testing.html)
  * [How to usetextmethodinandroid.support.test.uiautomator.UiSelector](https://www.tabnine.com/code/java/methods/android.support.test.uiautomator.UiSelector/text)
  * [Uiautomator- how to get the text value on the textview obj of which the checkbox value is checked??](https://stackoverflow.com/questions/30853168/uiautomator-how-to-get-the-text-value-on-the-textview-obj-of-which-the-checkbox)
  * [UiAutomator Accessing a child with limited information](https://stackoverflow.com/questions/19964757/uiautomator-accessing-a-child-with-limited-information)
  * []()
  * [Test apps on Android](https://developer.android.com/training/testing#UIAutomator)
  * [Write automated tests with UI Automator](https://developer.android.com/training/testing/other-components/ui-automator)
  * [https://developer.android.com/training/testing/other-components/ui-automator](https://developer.android.com/training/testing/other-components/ui-automator)
  * [UI Automator](https://developer.android.google.cn/training/testing/ui-automator?hl=zh-cn)
  * []()
  * [UIAutomatorViewer Tutorial: Inspector for Android Testing](https://www.guru99.com/uiautomatorviewer-tutorial.html)
  * [First steps with UI Automator](https://greenspector.com/en/first-steps-with-ui-automator/)
  * [Android Native - How to create UI Automator tests](https://www.daniweb.com/programming/mobile-development/tutorials/536829/android-native-how-to-create-ui-automator-tests)
  * [Android cross component with the UI Automator framework - Tutorial](https://www.vogella.com/tutorials/AndroidTestingUIAutomator/article.html)
  * [Can one Android application control another application via UI Automator?](https://devdreamz.com/question/942144-can-one-android-application-control-another-application-via-ui-automator)
  * [Can one Android application control another application via UI Automator?](https://stackoverflow.com/questions/16953809/can-one-android-application-control-another-application-via-ui-automator)
  * [Can one Android application control another application via UI Automator?](https://catwolf.org/qs?id=1d5ff9c2-cf7b-4df4-b0ff-b2e2b812eab9&x=y)
  * [THE DEFINITIVE GUIDE OF ANDROID UI AUTOMATOR WITH KOTLIN](https://www.droidcon.com/2021/08/06/the-definitive-guide-of-android-ui-automator-with-kotlin/)
  * [Android UIAutomator浅谈](https://www.jianshu.com/p/7718860ec657)
  * []()

## 概述

UI Automator 是一个界面测试框架，适用于整个系统上以及多个已安装应用间的跨应用功能界面测试。

此框架需要 Android 4.3（API 级别 18）或更高版本。

* UI Automator 查看器

uiautomatorviewer 工具提供了一个方便的 GUI，用于扫描和分析 Android 设备上当前显示的界面组件。

uiautomatorviewer 工具位于 `<android-sdk>/tools/bin` 目录中。


## APIs

### 访问设备状态 UiDevice

UI Automator 测试框架提供了一个 `UiDevice` 类，用于在运行目标应用的设备上访问和执行操作。您可以调用其方法以访问设备属性，如当前屏幕方向或显示屏尺寸。UiDevice 类还可用于执行以下操作：

改变设备的旋转。
按硬件键，如“音量调高按钮”。
按返回、主屏幕或菜单按钮。
打开通知栏。
截取当前窗口的屏幕截图。
例如，如需模拟按下“主屏幕”按钮，请调用 `UiDevice.pressHome()` 方法。

### UI Automator API

通过 UI Automator API，您可以编写可靠的测试，而无需了解目标应用的实现细节。您可以使用这些 API 在多个应用间捕获和操纵界面组件：

UiCollection：枚举容器的界面元素，目的是为了计数，或者按可见文本或内容说明属性来定位子元素。
UiObject：表示设备上可见的界面元素。
UiScrollable：支持搜索可滚动界面容器中的项目。
UiSelector：表示对设备上的一个或多个目标界面元素的查询。
Configurator：可让您设置用于运行 UI Automator 测试的关键参数。


## 例子

Google Samples - [BasicSample](https://github.com/googlesamples/android-testing/tree/master/ui/uiautomator/BasicSample)

* 如何执行： 

  在 BasicSample/app/src/androidTest/java/com/example/android/testing/uiautomator/BasicSample/ChangeTextBehaviorTest.java 中找到test case 的方法（`@Test`修饰的）
  点击方法名称左边的绿色箭头，选 `run xxx` 或 `ctrl + shift + F10`

* 执行效果
  Oneplus5T 氢OS Android 10，可以操作任意app。其他机型没实验。


其他的配置文件如下：

* app build.gradle

BasicSample/app/build.gradle

~~~
apply plugin: 'com.android.application'

android {
    compileSdkVersion 30
    buildToolsVersion rootProject.buildToolsVersion
    defaultConfig {
        applicationId "com.example.android.testing.uiautomator.BasicSample"
        minSdkVersion 18
        targetSdkVersion 30
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
    productFlavors {
    }
    testOptions {
        unitTests {
            includeAndroidResources = true
        }
        managedDevices {
            devices {
                // run with ../gradlew  nexusOneApi30DebugAndroidTest
                nexusOneApi30(com.android.build.api.dsl.ManagedVirtualDevice) {
                    // A lower resolution device is used here for better emulator performance
                    device = "Nexus One"
                    apiLevel = 30
                    // Also use the AOSP ATD image for better emulator performance
                    systemImageSource = "aosp-atd"
                }
            }
        }
    }
}

dependencies {
    implementation 'com.google.guava:guava:30.1.1-android'
    // Testing-only dependencies
    androidTestImplementation 'androidx.test:core:1.4.1-alpha06'
    androidTestImplementation 'androidx.test.ext:junit:1.1.4-alpha06'
    androidTestImplementation 'androidx.test:runner:1.5.0-alpha03'
    // UiAutomator Testing
    androidTestImplementation 'androidx.test.uiautomator:uiautomator:2.2.0'
    androidTestImplementation 'org.hamcrest:hamcrest-integration:1.3'
}
~~~

* project build.gradle

BasicSample/build.gradle

~~~
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    ext.agpVersion = "7.2.0"
    repositories {
        // Insert local test repo here
        google()
        mavenCentral()
    }
    dependencies {
        classpath "com.android.tools.build:gradle:$agpVersion"
    }
}

allprojects {
    repositories {
        // Insert local test repo here
        google()
        mavenCentral()
    }
}

ext {
    buildToolsVersion = "31.0.0"
    androidxAnnotationVersion = "1.2.0"
    guavaVersion = "30.1.1-android"
    coreVersion = "1.4.1-alpha06"
    extJUnitVersion = "1.1.4-alpha06"
    runnerVersion = "1.5.0-alpha03"
    rulesVersion = "1.4.1-alpha06"
    espressoVersion = "3.5.0-alpha06"
    uiAutomatorVersion = "2.2.0"
}
~~~

* androidTest AndroidManifest.xml

BasicSample/app/src/androidTest/AndroidManifest.xml

~~~xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
      xmlns:tools="http://schemas.android.com/tools"
      package="com.example.android.testing.uiautomator.BasicSample.test"
      android:versionCode="1"
      android:versionName="1.0">
    <uses-sdk android:minSdkVersion="18" android:targetSdkVersion="28" />

    <instrumentation android:targetPackage="com.example.android.testing.uiautomator.BasicSample"
                     android:name="androidx.test.runner.AndroidJUnitRunner"/>

    <application tools:replace="label" android:label="BasicSampleTest" />
</manifest>
~~~

* main AndroidManifest.xml

BasicSample/app/src/main/AndroidManifest.xml

~~~xml
<?xml version="1.0" encoding="utf-8"?>
<!--
~ Copyright (C) 2015 The Android Open Source Project
~
~ Licensed under the Apache License, Version 2.0 (the "License");
~ you may not use this file except in compliance with the License.
~ You may obtain a copy of the License at
~
~   http://www.apache.org/licenses/LICENSE-2.0
~
~ Unless required by applicable law or agreed to in writing, software
~ distributed under the License is distributed on an "AS IS" BASIS,
~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
~ See the License for the specific language governing permissions and
~ limitations under the License.
-->

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.android.testing.uiautomator.BasicSample" >

    <application
        android:icon="@drawable/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/AppTheme" >
        <activity
            android:name="com.example.android.testing.uiautomator.BasicSample.MainActivity"
            android:label="@string/app_name" >
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <activity android:name="com.example.android.testing.uiautomator.BasicSample.ShowTextActivity"/>
    </application>

</manifest>
~~~



