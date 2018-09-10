---
layout: post
title: android 测试
categories: [ dev, android ]
tags: [ android, ui-automator, espresso, test ]
---

* Android Official Doc - Fundamentals of Testing
  * <https://developer.android.com/training/testing/fundamentals.html>




## 迭代测试流程

* The two cycles associated with iterative, test-driven development
  ![](testing-workflow.png)


## 测试金字塔

* The Testing Pyramid, showing the three categories of tests that you should include in your app's test suite
  ![](pyramid.png)

* **Small tests** are unit tests that you can run in isolation from production systems. They typically mock every major component and should run quickly on your machine.
  * Robolectric <http://robolectric.org/>
  * Mockito <http://mockito.org/>
* **Medium tests** are integration tests that sit in between small tests and large tests. They integrate several components, and they run on emulators or real devices.
  * Firebase Test Lab <https://firebase.google.com/docs/test-lab/>
* **Large tests** are integration and UI tests that run by completing a UI workflow. They ensure that key end-user tasks work as expected on emulators or real devices.
  * AndroidJUnitRunner <https://developer.android.com/reference/android/support/test/runner/AndroidJUnitRunner.html>
  * JUnit4 Rules <https://developer.android.com/training/testing/junit-rules.html>
  * Espresso <https://developer.android.com/training/testing/espresso/index.html>
  * UI Automator <https://developer.android.com/training/testing/ui-automator.html>
  * Orchestrator <https://developer.android.com/training/testing/junit-runner.html#using-android-test-orchestrator>


Although the proportion of tests for each category can vary based on your app's use cases, we generally recommend the following split among the categories: 
**70 percent small, 20 percent medium, and 10 percent large.**



## 环境配置

app's top-level build.gradle 添加 依赖库

~~~ gradle
dependencies {
    androidTestCompile 'com.android.support:support-annotations:24.0.0'
    androidTestCompile 'com.android.support.test:runner:0.5'
    androidTestCompile 'com.android.support.test:rules:0.5'
    // Optional -- Hamcrest library
    androidTestCompile 'org.hamcrest:hamcrest-library:1.3'
    // Optional -- UI testing with Espresso
    androidTestCompile 'com.android.support.test.espresso:espresso-core:2.2.2'
    // Optional -- UI testing with UI Automator
    androidTestCompile 'com.android.support.test.uiautomator:uiautomator-v18:2.1.2'
}
~~~

> Caution: If your build configuration includes a compile dependency for the support-annotations library and an androidTestCompile dependency for the espresso-core library, your build might fail due to a dependency conflict. To resolve, update your dependency for espresso-core as follows:

~~~ gradle
androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
    exclude group: 'com.android.support', module: 'support-annotations'
})
~~~


To use JUnit 4 test classes, make sure to specify AndroidJUnitRunner as the default test instrumentation runner in your project by including the following setting in your app's module-level build.gradle file:

~~~ gradle
android {
    defaultConfig {
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }
}
~~~


## Firebase Test Lab

google的云测，每天免费使用5个设备
<https://firebase.google.cn>




## JUnit4 Rules with Testing Support Library

### ActivityTestRule

这个 rule 用来测试单个 Activity。

“被测Activity” 在所有 @Test 和 @before 方法之前启动；在 @After 方法结束后关闭。

测试代码中可使用 `ActivityTestRule.getActivity()` 获取“被测Activity”。

### ServiceTestRule

This rule provides a simplified mechanism to start up and shut down your service before and after the duration of your test.

此 rule 不支持 IntentService。

~~~ java
@RunWith(AndroidJUnit4.class)
@MediumTest
public class MyServiceTest {
    @Rule
    public final ServiceTestRule mServiceRule = new ServiceTestRule();

    @Test
    public void testWithStartedService() {
        mServiceRule.startService(
            new Intent(InstrumentationRegistry.getTargetContext(),
            MyService.class));

        // Add your test code here.
    }

    @Test
    public void testWithBoundService() {
        IBinder binder = mServiceRule.bindService(
            new Intent(InstrumentationRegistry.getTargetContext(),
            MyService.class));
        MyService service = ((MyService.LocalBinder) binder).getService();
        assertTrue("Service didn't return true",
            service.doSomethingToReturnTrue());
    }
}
~~~





## AndroidJUnitRunner

The `AndroidJUnitRunner` class is a JUnit test runner that lets you run JUnit 3- or JUnit 4-style test classes on Android devices, including those using the Espresso and UI Automator testing frameworks.

This class replaces the `InstrumentationTestRunner` class, which only supports JUnit 3 tests.






