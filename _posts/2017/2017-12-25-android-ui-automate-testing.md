---
layout: post
title: android 自动化测试
categories: [ dev, android ]
tags: [ android, ui-automator, espresso ]
---


* [Android Develop - Testing Support Library](https://developer.android.com/topic/libraries/testing-support-library/index.html)
* [Android Develop - UI Automator](https://developer.android.com/training/testing/ui-automator.html)
* [Android Develop - Espresso](https://developer.android.com/training/testing/espresso/index.html)
* [Android Develop - Testing UI for Multiple Apps](https://developer.android.com/training/testing/ui-testing/uiautomator-testing.html)
* [vogella.com - Android user interface testing with Espresso - Tutorial](http://www.vogella.com/tutorials/AndroidTestingEspresso/article.html)
* []()



## UiAutomator

* [uiobject 方式遍历list items](https://stackoverflow.com/a/35308116)



## Espresso

Use Espresso to write concise, beautiful, and reliable Android UI tests.

The following code snippet shows an example of an Espresso test:

~~~ java
@Test
public void greeterSaysHello() {
    onView(withId(R.id.name_field)).perform(typeText("Steve"));
    onView(withId(R.id.greet_button)).perform(click());
    onView(withText("Hello Steve!")).check(matches(isDisplayed()));
}
~~~

The core API is small, predictable, and easy to learn and yet remains open for customization. Espresso tests state expectations, interactions, and assertions clearly without the distraction of boilerplate content, custom infrastructure, or messy implementation details getting in the way.

Espresso tests run optimally fast! It lets you leave your waits, syncs, sleeps, and polls behind while it manipulates and asserts on the application UI when it is at rest.


### Target Audience

Espresso is targeted at developers, who believe that automated testing is an integral part of the development lifecycle. While it can be used for black-box testing, Espresso’s full power is unlocked by those who are familiar with the codebase under test.


### Packages

* espresso-core - Contains core and basic View matchers, actions, and assertions. See [Basics](espresso-basic) and [Recipes][espresso-recipes].
* [espresso-web][] - Contains resources for WebView support.
* [espresso-idling-resource][] - Espresso’s mechanism for synchronization with background jobs.
* espresso-contrib - External contributions that contain DatePicker, RecyclerView and Drawer actions, accessibility checks, and CountingIdlingResource.
* [espresso-intents][] - Extension to validate and stub intents for hermetic testing.
You can learn more about the latest versions by reading the release notes.

[espresso-basic]: https://developer.android.com/training/testing/espresso/basics.html
[espresso-recipes]: https://developer.android.com/training/testing/espresso/recipes.html
[espresso-web]: https://developer.android.com/training/testing/espresso/web.html
[espresso-idling-resource]: https://developer.android.com/training/testing/espresso/idling-resource.html
[espresso-intents]: https://developer.android.com/training/testing/espresso/intents.html


### 如何在项目中使用 Espresso

#### 配置Gradle

add the following dependency to the Gradle build file of your app.

~~~ gradle
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])

    testCompile 'junit:junit:4.12'

    // Android runner and rules support
    androidTestCompile 'com.android.support.test:runner:0.5'
    androidTestCompile 'com.android.support.test:rules:0.5'

    // Espresso support
    androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })

    // add this for intent mocking support
    androidTestCompile 'com.android.support.test.espresso:espresso-intents:2.2.2'

    // add this for webview testing support
    androidTestCompile 'com.android.support.test.espresso:espresso-web:2.2.2'

}
~~~

Ensure that the `android.support.test.runner.AndroidJUnitRunner` is specified as value for the `testInstrumentationRunner` parameter in the build file of your app. Via the packagingOptions you may have to exclude LICENSE.txt, depending on the libraries you are using. 

~~~ gradle
apply plugin: 'com.android.application'

android {
    compileSdkVersion 22
    buildToolsVersion '22.0.1'
    defaultConfig {
        applicationId "com.example.android.testing.espresso.BasicSample"
        minSdkVersion 10
        targetSdkVersion 22
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }
    packagingOptions {
        exclude 'LICENSE.txt'
    }
    lintOptions {
        abortOnError false
    }
}

dependencies {
    // as before.......
}
~~~




#### Device settings


![](turn-off-animation.png){: style="width:260px"} ![](turn-off-animation2.png){: style="width:260px"}






### Exercise: A first Espresso test


#### Create project under test

Create a new Android project called Espresso First with the package name com.vogella.android.espressofirst. Use the Blank Template as basis for this project.

Change the generated activity_main.xml layout file to the following.

~~~ xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
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
</LinearLayout>
~~~

Create a new file called activity_second.xml.

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

Create a new activity with the following code.

~~~ java
package com.vogella.android.espressofirst;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class SecondActivity extends Activity{
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

Also adjust your MainActivity class.

~~~
package com.vogella.android.espressofirst;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends Activity {

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
        }

    }
}
~~~

#### Create your Espresso test

~~~ java
package com.vogella.android.espressofirst;

import android.support.test.rule.ActivityTestRule;
import android.support.test.runner.AndroidJUnit4;

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

#### 在Android Sutdio里面，右击 MainActivityEspressoTest，选择 Run



### 利用 adb 运行 espresso

参考： <https://developer.android.com/studio/test/command-line.html>

~~~
adb shell am instrument -w <test_package_name>/<runner_class>

adb shell am instrument -w com.your-name.espressofirst.test/android.support.test.runner.AndroidJUnitRunner
~~~



### espresso-cheatsheet

![](espresso-cheatsheet.png)


































