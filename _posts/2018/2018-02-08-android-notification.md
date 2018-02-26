---
layout: post
title: android notification 系统通知
categories: [ dev, android ]
tags: [ android ]
---


* refer
  * <https://developer.android.com/guide/topics/ui/notifiers/notifications.html>



[NotificationChannel-ref]: https://developer.android.com/reference/android/app/NotificationChannel.html
[createNotificationChannels-ref]: https://developer.android.com/reference/android/app/NotificationManager.html#createNotificationChannels(java.util.List<android.app.NotificationChannel>)
[getNotificationChannel-ref]: https://developer.android.com/reference/android/app/NotificationManager.html#getNotificationChannel(java.lang.String)
[getNotificationChannels-ref]: https://developer.android.com/reference/android/app/NotificationManager.html#getNotificationChannels()


## notification channels

* Android 8.0 (API level 26)开始，要显示通知，必须实现 1或更多的 notification channel。
* create an instance of [NotificationChannel][NotificationChannel-ref] for each distinct type of notification you need to send.
* All notifications posted to the same notification channel have the same behavior. 
  * Importance
  * Sound
  * Lights
  * Vibration
  * Show on lockscreen
  * Override do not disturb 



### Creating a notification channel

创建步骤：

1. **Construct** a notification channel object
    * with an ID that's unique within your package.
2. **Configure** the notification channel object 
    * with any desired initial settings, such as an alert sound, as well as an optional description visible to the user.
3. **Submit** the notification channel object to the notification manager.


* 注意：
  * 一般在 app 启动时创建，之后用同样ID再创建没有任何效果（已经被提交给系统的notification manager了）
  * 批量创建channel使用 [createNotificationChannels()][createNotificationChannels-ref]


~~~ java
NotificationManager mNotificationManager =
        (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
// The id of the channel.
String id = "my_channel_01";
// The user-visible name of the channel.
CharSequence name = getString(R.string.channel_name);
// The user-visible description of the channel.
String description = getString(R.string.channel_description);
int importance = NotificationManager.IMPORTANCE_HIGH;
NotificationChannel mChannel = new NotificationChannel(id, name, importance);
// Configure the notification channel.
mChannel.setDescription(description);
mChannel.enableLights(true);
// Sets the notification light color for notifications posted to this
// channel, if the device supports this feature.
mChannel.setLightColor(Color.RED);
mChannel.enableVibration(true);
mChannel.setVibrationPattern(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
mNotificationManager.createNotificationChannel(mChannel);
~~~


### Creating a notification channel group

* **Notification channel** groups allow you to manage multiple notification channels with identical names within a single app.
* Each notification channel group requires an ID that must be unique within your package, as well as a user-visible name.

~~~ java
// The id of the group.
String group = "my_group_01";
// The user-visible name of the group.
CharSequence name = getString(R.string.group_name);
NotificationManager mNotificationManager =
        (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
mNotificationManager.createNotificationChannelGroup(new NotificationChannelGroup(group, name));
~~~

After you've created a new group, you can call setGroup() to associate a new channel with the group.


### Reading notification channel settings

Users can modify the settings for notification channels, including behaviors such as vibration and alert sound. 

to discover the settings a user has applied to a notification channel:

* [NotificationChannel getNotificationChannel (String channelId)][getNotificationChannel-ref]
  * To retrieve a single notification channel
* [List\<NotificationChannel\> getNotificationChannels ()][getNotificationChannels-ref]
  * Returns all notification channels belonging to the calling package



### Updating notification channel settings

After you create a notification channel, the user is in charge of its settings and behavior. 

You can call createNotificationChannel() and then submit the notification channel again to the notification manager to rename an existing notification channel, or update its description.

~~~ java
// redirect a user to the settings for a notification channel
Intent intent = new Intent(Settings.ACTION_CHANNEL_NOTIFICATION_SETTINGS);
intent.putExtra(Settings.EXTRA_CHANNEL_ID, mChannel.getId());
intent.putExtra(Settings.EXTRA_APP_PACKAGE, getPackageName());
startActivity(intent);
~~~


### Deleting a notification channel

~~~ java
NotificationManager mNotificationManager =
        (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
// The id of the channel.
String id = "my_channel_01";
mNotificationManager.deleteNotificationChannel(id);
~~~






## Creating a notification

* You specify the UI information and actions for a notification in a `NotificationCompat.Builder` object. 
* To create the notification itself, you call `NotificationCompat.Builder.build()`, which returns a Notification object containing your specifications. 
* To issue the notification, you pass the Notification object to the system by calling NotificationManager.notify().

### 通知必备的信息

A `Notification` object must contain the following:

* A small icon, set by setSmallIcon().
* A title, set by setContentTitle().
* Detail text, set by setContentText().
* On Android 8.0 (API level 26) and higher, a valid notification channel ID, set by setChannelId() or provided in the NotificationCompat.Builder constructor when creating a channel.



### Notification actions

An action allows users to go directly from the notification to an Activity in your app

Inside a Notification, the action itself is defined by a `PendingIntent` containing an Intent that starts an Activity in your app.

if you want to start Activity when the user clicks the notification text in the notification drawer, you add the PendingIntent by calling setContentIntent().

In Android 4.1 and later, you can start an Activity from an action button.

You can also start an Activity when the user dismisses a notification.



### Notification priority and importance

To set a notification's priority, call `NotificationCompat.Builder.setPriority()` and pass in one of the NotificationCompat priority constants. 

There are five priority levels, ranging from `PRIORITY_MIN (-2)` to `PRIORITY_MAX (2)`; if not set, the priority defaults to `PRIORITY_DEFAULT (0)`.


### Creating a simple notification

Android 8.0 (API level 26) and higher requires that you post notifications to a notification channel.

~~~ java
// The id of the channel.
String CHANNEL_ID = "my_channel_01";
NotificationCompat.Builder mBuilder =
        new NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.notification_icon)
            .setContentTitle("My notification")
            .setContentText("Hello World!");
// Creates an explicit intent for an Activity in your app
Intent resultIntent = new Intent(this, ResultActivity.class);

// The stack builder object will contain an artificial back stack for the
// started Activity.
// This ensures that navigating backward from the Activity leads out of
// your app to the Home screen.
TaskStackBuilder stackBuilder = TaskStackBuilder.create(this);
// Adds the back stack for the Intent (but not the Intent itself)
stackBuilder.addParentStack(ResultActivity.class);
// Adds the Intent that starts the Activity to the top of the stack
stackBuilder.addNextIntent(resultIntent);
PendingIntent resultPendingIntent =
        stackBuilder.getPendingIntent(
            0,
            PendingIntent.FLAG_UPDATE_CURRENT
        );
mBuilder.setContentIntent(resultPendingIntent);
NotificationManager mNotificationManager =
    (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

// mNotificationId is a unique integer your app uses to identify the
// notification. For example, to cancel the notification, you can pass its ID
// number to NotificationManager.cancel().
mNotificationManager.notify(mNotificationId, mBuilder.build());
~~~





## Managing notifications

When you need to issue a notification multiple times for the same type of event, you should avoid making a completely new notification. Instead, you should consider updating a previous notification, either by changing some of its values or by adding to it, or both.


### Updating notifications

创建一个 `Notification`，复用之前用于 `NotificationManager.notify()` 的 notification-id，
再次调用 `NotificationManager.notify()` 即可。
如果通知尚存，会更新其信息；如果已被清除，会出现个新通知。

* 注意
  1. 如果通知太过频繁，系统会丢弃掉一些通知。
  2. You can optionally call setOnlyAlertOnce() to only turn on a notification sound, vibration, and ticker if the notification is not already showing.

~~~ java
mNotificationManager =
        (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
// Sets an ID for the notification, so it can be updated
int notifyID = 1;
mNotifyBuilder = new NotificationCompat.Builder(this, CHANNEL_ID)
    .setContentTitle("New Message")
    .setContentText("You've received new messages.")
    .setSmallIcon(R.drawable.ic_notify_status);
numMessages = 0;
// Start of a loop that processes data and then notifies the user
...
    mNotifyBuilder.setContentText(currentText)
        .setNumber(++numMessages);
    // Because the ID remains unchanged, the existing notification is
    // updated.
    mNotificationManager.notify(
            notifyID,
            mNotifyBuilder.build());
...
~~~



### Removing notifications

如下任一情况发生，通知消失：

* The user dismisses the notification either individually or by using "Clear All" (if the notification can be cleared).
* The user clicks the notification, and you called `NotificationCompat.Builder.setAutoCancel()` when you created the notification.
* You call `NotificationManager.cancel()` for a specific notification ID. This method also deletes ongoing notifications.
* You call `NotificationManager.cancelAll()`, which removes all of the notifications you previously issued.
* If you set a timeout when creating a notification using `NotificationCompat.Builder.setTimeoutAfter()`, the system cancels the notification after the specified duration elapses. If required, you can cancel a notification before the specified timeout duration elapses.



























