---
layout: post
title: android-ui自动化测试之uiautomator.md
categories: [ testing, android ]
tags: [ uiautomator ]
---

* 参考：
  * 《腾讯Android自动化测试实战》
  * [uiobject 方式遍历list items](https://stackoverflow.com/a/35308116)
  * []()
  * []()





## UiAutomator


### 一般测试流程

1. 分析UI元素，获取元素属性
1. 开发测试代码，模拟用户操作。
1. 编译测试代码成jar，push到手机。
1. 在手机上运行测试，搜集测试结果。


### 获取元素信息的方法

1. 使用uiautomatorviewer工具

`./sdk/tools/bin/uiautomatorviewer`


### 开发

#### 创建 Project

创建Java Project（而不是Android Project），加入依赖： `android.jar`、`uiautomator.jar`， 2个jar都在 `./sdk/platforms/android-xx` 目录。
android-19 以上的新增 `UiSelector.resourceId` 系列方法，能通过resource id 定位元素。


#### 开发用例

* 每个用例都继承自 `UiAutomatorTestCase`
* `setUp()` 先于每个用例执行。进行用例执行的准备。
* `tearDown()` 后于每个用例执行。搜集用例结果，恢复环境。
* 一个 Class 可以包含多个用例 testXXX()，但不建议耦合、存在顺序依赖关系。
* 

#### 示例一：

~~~java
public class HelloUiAutomator extends UiAutomatorTestCase {
    private static final String TAG = HelloUiAutomator.class.getSimpleNmae();
    private static final String FORMAT_LOG = ">>> %s [%s] %s";
    private static final SimpleDateFormat DATA_FORMAT = new SimpleDateFormat("yyyy-HH-DD hh:mm:ss");
    private static final long TIME_OUT_FOR_EXISTS = 5 * 1000L;
    protected void setUp() throws Exception{
        log(TAG, "setUp of " + getName());
        super.setUp();
    }

    /**
     * 测试场景：验证自动休眠设置是否有效
     * 操作过程：
     * 打开系统设置，设置自动休眠时间为 30 秒休眠
     * 30 秒后检查屏幕状态。
     * 预测结果：屏幕为熄灭状态
     */
    public void testSetScreenOffTime() throws IOExcepton, UiObjectNotFoundException, RemoteException {
        // 打开系统设置
        Runtime.getRuntime().exec("monkey -p com.android.settings -v 1");

        // 找到滚动列表：以包名、ResourceId 为条件查找
        UiScrollable mSettingList = new UiScrollable(new UiSelector()
            .packageNmae("com.android.settings")
            .resourceId("android:id/list"));
        mSettingList.waitForExists(TIME_OUT_FOR_EXISTS);
        assertTrue("System setting list not exists", mSettingList.exists());

        // 获取现实控件，并点击进入现实设置，使用UiScrollable 获取子控件会自动滚动查找
        log(TAG, "Enter display setting page");
        UiObject mDisplayEntry = mSettingList.getChildByText(
            new UiSelector().resourceIdMatches(".*title"), "显示");
        assertTrue("Display setting entry not exists", mDisplayEntry.clickAndWaitForNewWindow());

        // 点击休眠
        log(TAG, “ENTER sleep timeout setting page”);
        UiObject mSleepTimeEntry = new UiObject(new UiSelector().textContains("休眠"));

        // 单击设置为 30S
        log(TAG, "set sleeping timeout to 30S");
        UiObject.mTargetTimeOut = new UiObject(new UiSelector().textMatches("30秒|30s"));
        assertTure("Can't find target timeout for setting", mTargetTimeOut.clickAndWaitForNewWindow());

        // 检查结果
        log(TAG, "Sleep 30s for checking auto sleep");
        UiDevice mUiDevice = getUiDevice();
        SystemClock.sleep(30 * 1000);
        assertFalse("Auto sleep didn't work", mUiDevice.isScreenOn());
    }

    protected void tearDown() throws Exception {
        log(TAG, "tearDown of " + getName());
        super.tearDown();
    }

    /**
     * 返回当前系统时间
     */
    private static String getCurTime() {
        return DATA_FORMAT.format(new Date(System.currentTimeMills()));
    }

    /** 输出日志 */
    private static void log(String tag, String message) {
        System.out.println(String.format(FORMAT_LOG, getCurTime, tag, message));
    }

}

~~~







































