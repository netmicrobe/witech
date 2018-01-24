---
layout: post
title: android 自动化测试：不借助电脑，在设备上直接运行测试
categories: [ dev, android ]
tags: [ android, ui-automator, espresso, adb ]
---



改进的EspressoFirst，可以从 app 启动 test
-----------------------------------------------------

* 参考
  * [vogella.com - Android user interface testing with Espresso - Tutorial](http://www.vogella.com/tutorials/AndroidTestingEspresso/article.html)
  * <https://stackoverflow.com/a/14372897>

* MainActivity.java

~~~ java
package com.wispeedio.espressofirst;

import android.content.ComponentName;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {
    EditText editText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editText = (EditText) findViewById(R.id.inputField);
    }

    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.changeText:
                editText.setText("Lalala");
                break;
            case R.id.switchActivity:
                Intent intent = new Intent(this, SecondActivity.class);
                intent.putExtra("input", editText.getText().toString());
                startActivity(intent);
                break;
            case R.id.run_test:
                // 方法1，使用 startInstrumentation 来启动 Test
                Bundle bd = new Bundle();
                // 指定执行特定类中的用例
                //bd.putString("class", "com.wispeedio.espressofirst.MainActivityEspressoTest");

                // bd 即使是空洞Bundle，也必须指定，
                // 否则报错：NullPointerException in onCreate() of AndroidJUnitRunner
                startInstrumentation(
                  new ComponentName(
                    "com.wispeedio.espressofirst.test",
                    "android.support.test.runner.AndroidJUnitRunner"), null, bd);

                // 方法2，可能有用，也可能因为权限不够而失败
                // 可以尝试添加 permission："android.permission.INJECT_EVENTS"
//                try {
//                    Process process =
//                      Runtime.getRuntime().exec(
//                        "adb shell am instrument -w com.wispeedio.espressofirst.test/android.support.test.runner.AndroidJUnitRunner");
//                } catch(Exception e) {
//                    Log.d("wiii", "am instrument error: " + e);
//                }
                break;
        }

    }
}
~~~

* activity_main.xml

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    >

    <EditText
        android:id="@+id/inputField"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />

    <Button
        android:id="@+id/changeText"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="New Button" android:onClick="onClick"/>

    <Button
        android:id="@+id/switchActivity"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Change Text" android:onClick="onClick"/>

    <Button
        android:id="@+id/run_test"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Run Test!" android:onClick="onClick"/>
</LinearLayout>
~~~



* SecondActivity.java

~~~
package com.wispeedio.espressofirst;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class SecondActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        TextView viewById = (TextView) findViewById(R.id.resultView);
        Bundle inputData = getIntent().getExtras();
        String input = inputData.getString("input");
        viewById.setText(input);
    }
}
~~~

* activity_second.xml

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical" android:layout_width="match_parent"
    android:layout_height="match_parent">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textAppearance="?android:attr/textAppearanceLarge"
        android:text="Large Text"
        android:id="@+id/resultView" />
</LinearLayout>

~~~

* MainActivityEspressoTest.java

~~~ java
package com.wispeedio.espressofirst;

/**
 * Created by wi on 2018/1/5.
 */

import android.support.test.rule.ActivityTestRule;
import android.support.test.runner.AndroidJUnit4;
import android.util.Log;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.action.ViewActions.closeSoftKeyboard;
import static android.support.test.espresso.action.ViewActions.typeText;
import static android.support.test.espresso.assertion.ViewAssertions.matches;

import static android.support.test.espresso.matcher.ViewMatchers.withId;
import static android.support.test.espresso.matcher.ViewMatchers.withText;


@RunWith(AndroidJUnit4.class)
public class MainActivityEspressoTest {


    @Rule
    public ActivityTestRule<MainActivity> mActivityRule =
            new ActivityTestRule<>(MainActivity.class);

    @Test
    public void ensureTextChangesWork() {
        // Type text and then press the button.
        onView(withId(R.id.inputField))
                .perform(typeText("HELLO"), closeSoftKeyboard());
        onView(withId(R.id.changeText)).perform(click());

        // Check that the text was changed.
        onView(withId(R.id.inputField)).check(matches(withText("Lalala")));
    }

    @Test
    public void changeText_newActivity() {
        // Type text and then press the button.
        onView(withId(R.id.inputField)).perform(typeText("NewText"),
                closeSoftKeyboard());
        onView(withId(R.id.switchActivity)).perform(click());

        // This view is in a different Activity, no need to tell Espresso.
        onView(withId(R.id.resultView)).check(matches(withText("NewText")));
    }
}
~~~

* app/build.gradle

~~~ gradle
apply plugin: 'com.android.application'

android {
    compileSdkVersion 25
    buildToolsVersion "25.0.3"
    defaultConfig {
        applicationId "com.wispeedio.espressofirst"
        minSdkVersion 15
        targetSdkVersion 25
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
    compile 'com.android.support:appcompat-v7:25.3.1'
    compile 'com.android.support.constraint:constraint-layout:1.0.2'
    testCompile 'junit:junit:4.12'
}
~~~

















stackoverflow 3299006: running-android-unit-tests-from-the-command-line
-----------------------------------------------------

<https://stackoverflow.com/questions/3299006/running-android-unit-tests-from-the-command-line>

~~~
pm list instrumentation
pm list packages
~~~




Running Android Tests on a Device or Emulator
-----------------------------------------------------

<http://mattsnider.com/running-android-tests-on-a-device-or-emulator/>

~~~ shell
adb -s <emulator name> shell am instrument -w -e <path to test file> <test package>:<test runner>

# Here is an example from GmsCore
adb -s emulator-5554 shell am instrument -w -e class com.google.android.gms.games.broker.PlayerAgentTest com.google.android.gms.test/android.support.test.runner.AndroidJUnitRunner
~~~

~~~ shell
adb -s <emulator name> shell am instrument -w -e debug true -e <path to test file> <test package>:<test runner>

# Here is an example from GmsCore
adb -s emulator-5554 shell am instrument -w -e debug true -e class com.google.android.gms.games.broker.PlayerAgentTest com.google.android.gms.test/android.support.test.runner.AndroidJUnitRunner
~~~







adb shell am instrument 命令详解
-----------------------------------------------------

官网关于该命令的详解：<https://developer.android.com/studio/command-line/adb.html?hl=zh-cn>

### 1 Instrument是什么？

instrument为am命令的一个子命令。用于启动一个Instrumentation测试。首先连接手机或者模拟器，通过adb shell命令，进入shell层进行操作。

### 2 命令格式及参数解读（来自官网）

格式：instrument [options] component

目标 component 是表单 `test_package/runner_class`，在UiAutomator2.0中，目标 component为：`测试包名/android.support.test.runner.AndroidJUnitRunner`(即运行器固定：AndroidJUnitRunner类是一个JUnit测试运行器,允许运行JUnit 3或JUnit 4测试类在 Android 设备上,包括那些使用Espresso和UI Automator框架。)

#### 各项参数：

~~~
-r：以原始形式输出测试结果；该选项通常是在性能测试时与[-e perf true]一起使用。
-e name value：提供了以键值对形式存在的过滤器和参数。例如：-e testFile <filePath>（运行文件中指定的用例）；-e package <packageName>（运行这个包中的所有用例）……  有十几种。 
-p file：将分析数据写入 file。
-w：测试运行器需要使用此选项。-w <test_package_name>/<runner_class> ：<test_package_name>和<runner_class>在测试工程的AndroidManifest.xml中查找，作用是保持adb shell打开直至测试完成。
--no-window-animation：运行时关闭窗口动画。
--user user_id | current：指定仪器在哪个用户中运行；如果未指定，则在当前用户中运行。
~~~

### 3  怎么运行手机中现有的instrumentation, 并输出详细结果，同时将profiling性能数据写到本地文件中?

先列出手机中已安装的instrumentation：adb shell pm list instrumentation
adb shell am instrument  XXX


### 4  命令的具体使用

比如com.le.tcauto.uitest.test是包含所有测试代码的应用的包名：（来自：http://blog.csdn.net/swordgirl2011/article/details/50881390）

*  运行所有的用例： adb shell am instrument -w com.le.tcauto.uitest.test/android.support.test.runner.AndroidJUnitRunner

*  运行一个类中的所有用例：
adb shell am instrument -w -r `-e class com.letv.leview.setproxy ` com.le.tcauto.uitest.test/android.support.test.runner.AndroidJUnitRunner
          
*  运行类中的某个方法：adb shell am instrument -w -r   `-e debug false -e class com.letv.leview.setproxy#testDemo` com.le.tcauto.uitest.test/android.support.test.runner.AndroidJUnitRunner

*  运行多个类的所有用例：adb shell am instrument -w -r   `-e debug false -e class com.letv.leview.setproxy,com.letv.leview.resetdate` com.le.tcauto.uitest.test/android.support.test.runner.AndroidJUnitRunner

*  运行所有测试用例除了指定的类：adb shell am instrument -w -r `-e notClass com.letv.leview.setproxy` com.le.tcauto.uitest.test/android.support.test.runner.AndroidJUnitRunner

*  运行所有测试除了指定的用例：adb shell am instrument -w -r   `-e debug false -e class com.letv.leview.setproxy#testDemo` com.le.tcauto.uitest.test/android.support.test.runner.AndroidJUnitRunner

*  运行文件中的所列的用例：adb shell am instrument -w `-e testFile /sdcard/tmp/testFile.txt` com.android.foo/com.android.test.runner.AndroidJUnitRunner   文件制定的 格式为：com.android.foo.FooClaseName#testMethodName

* 运行指定测试切片的用例：adb shell am instrument -w `-e numShards 4 -e shardIndex 1` com.android.foo/android.support.test.runner.AndroidJUnitRunner

* 运行指定注解的测试用例：adb shell am instrument -w `-e annotation com.android.foo.MyAnnotation` com.android.foo/android.support.test.runner.AndroidJUnitRunner。如果使用多个选项，则运行的用例为两者的交集，比如：“-e size large -e annotation com.android.foo.MyAnnotation”，将只运行同时含LargeTest和MyAnnotation注解的用例。

* 运行没有指定注解的用例：adb shell am instrument -w `-e notAnnotation com.android.foo.MyAnnotation` com.android.foo/android.support.test.runner.AndroidJUnitRunner，指定多个注解，用“,”隔开，e.g. adb shell am instrument -w -e notAnnotation com.android.foo.MyAnnotation,com.android.foo.AnotherAnnotation com.android.foo/android.support.test.runner.AndroidJUnitRunner

* 以上所有参数也可以通过`<meta-data>`标签配置在AndroidManifest文件，比如 `<meta-data android:name="listener" android:value="com.foo.Listener"/>`，通过shell命令 传入的参数将覆盖AndroidManifest文件中配置的参数。

### 5  开始容易写错？

AS ——Select Run/Debug —— Configuration ——Edit Configuration ——配置 ——OK

运行完成，下方会显示该命令，然后copy过来。

### 6 工程实践，见AS



















