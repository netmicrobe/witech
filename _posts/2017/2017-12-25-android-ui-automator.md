---
layout: post
title: android 自动化测试
categories: [ dev, android ]
tags: [ android, ui-automator ]
---


* [Android Develop - Testing Support Library](https://developer.android.com/topic/libraries/testing-support-library/index.html)
* [Android Develop - UI Automator](https://developer.android.com/training/testing/ui-automator.html)
* [Android Develop - Espresso](https://developer.android.com/training/testing/espresso/index.html)
* [Android Develop - Testing UI for Multiple Apps](https://developer.android.com/training/testing/ui-testing/uiautomator-testing.html)
* []()




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






































































