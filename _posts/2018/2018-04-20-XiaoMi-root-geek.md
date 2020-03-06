---
layout: post
title: 小米5x/8se 解锁、root、刷机、玩机
categories: [ cm, android ]
tags: [ adb, fastboot, bootloader, root, unlock, twrp ]
---

* 参考
  * [小米ROM官方下载](http://www.miui.com/download.html)
  * [小米官网刷机教程](http://www.miui.com/shuaji-329.html)
  * 小米5x _tiffany_
    * <http://en.miui.com/forum-141-1.html>
    * [How To Root And Install TWRP Recovery For Xiaomi Mi 5X [tiffany]](https://www.getdroidtips.com/root-twrp-xiaomi-mi-5x-tiffany/)
    * [Unlock Bootloader, Install TWRP Recovery and Root Xiaomi Mi 5X (Tiffany)](http://www.stechguide.com/install-twrp-recovery-and-root-xiaomi-mi-5x/)
    * [How To Install dotOS on Xiaomi Mi 5X based on Android 8.1 Oreo](https://www.getdroidtips.com/dotos-xiaomi-mi-5x/)
    * [Device configuration for Xiaomi Mi 5X](https://github.com/Mi5xDevs/android_device_xiaomi_tiffany)
    * [Mi 5X Oxygen/Tiffany TWRP 3.1.1](http://en.miui.com/thread-1110001-1-1.html)
    * [All about Mi 5X from AliExpress (fake firmware, bricks and etc)](http://en.miui.com/thread-840402-1-1.html)


## 解锁

* 参考
  * <https://www.romzhijia.net/shuaji/22013.html>
  * <http://www.romleyuan.com/lec/read?id=83>


1. 申请解锁
    到2020年情况变了，小米越来越。。。不打算再买小米了。
    
    1. 设置 -\> 更多设置 -\> 开发者选项 -\> 设备解锁状态 -\> 绑定帐号和设备
        **注意** 小米账号绑定的手机号来上网，否则绑定不了。
        如果还绑定不了，手机卡流量上网，重新再手机上登录下小米账号。再绑定“账号和设备”试试。
        lj小米。。。
    1. 需要登录小米账号后，到开发者选项将设备和账号绑定0-1000小时，一般默认为168小时，部分新机实际几百小时，具体绑定时间，我们解锁的时候会提示。
    1. 访问 <https://unlock.update.miui.com> 去申请
    1. 申请通过下载unlock工具 miflash_unlock-*.zip

2. 小米账号登录 <http://en.miui.com/unlock/download_en.html> 下载unlock工具 miflash_unlock-en-2.3.803.10.zip

3. 安装unlock工具，并在工具中用小米账号登录

4. 关机, 同时按住`音量下键`和`电源键`进入 Fastboot mode;

5. 将手机连上电脑，点击 "Unlock".

6. 解锁成功，重启进入 fastboot 模式，输入 `fastboot oem device-info` 查看是否unlock成功。


* 2020年之前申请解锁的方法（留个纪念）
  1. 小米账号登录手机 15 天之后才能解锁
  1. 小米账号登录 <http://www.miui.com/unlock/index_en.html> 申请解锁
  1. 大概半小时内会批准通过，收到一条短信提醒



### 小米8 SE 提示 "Current account is not bound to this device"

1. 开机 》设置 》更多设置 》开发者选项
2. OEM解锁，开启
3. 设备解锁状态 》绑定帐号和设备



## 小米 fastboot oem 命令

* ref
  * [AskUbuntu - no permissions fastboot - fastboot and adb not working](https://askubuntu.com/a/705541)

~~~
fastboot oem device-info
fastboot oem lock
fastboot oem unlock
~~~

如果出现错误： `no permissions (user in plugdev group; are your udev rules wrong?); `，尝试如下方法：

~~~
sudo $(which fastboot) devices
sudo $(which fastboot) reboot
~~~





## ROOT

1. 刷了开发版
2. 安全中心 》应用管理 》权限 》ROOT权限管理


## 刷机

### 方法1：系统内升级

1. 下载 MIUI_ROM 最新安装包 <http://www.miui.com/download.html>

2. 将手机连接电脑，将 zip 包拷贝至内置存储 /downloaded_rom 文件夹下，或仅包含"英文或数字"路径的文件夹下，然后进入“系统更新”：

3. MIUI 6/7/8/9：点右上角“...”选择“手动选择安装包” ，然后选择 zip 包。
    * 带BL锁机型：
      只能选择[MIUI官方下载页](http://www.miui.com/download.html)中**最新版本**
      进行卡刷升级，非最新外发版本不支持卡刷。

4. 选择正确完整包后，系统会自动开始升级，完成之后，重启进入新系统。



### 方法2：通过 Recovery 升级

因Recovery界面不同，不适用mtk平台的红米手机也不适用带有BL锁的机型。

1. 下载 MIUI_ROM 最新安装包
2. 电脑上操作，重命名zip文件包为 update.zip 拷贝至内置存储 **根目录**。
3. 进入Recovery模式
    * 开机状态下：进入“系统更新”，点右上角“...”选择“重启到恢复模式（Recovery）”，点击“立即重启” 进入Recovery模式。
    * 关机状态下：同时按住`音量上+电源键开机`，屏幕亮起松开电源键保持长按音量键 进入Recovery模式。
4. Recovery界面进行卡刷。
    选择“简体中文”并确认（音量键选择电源键确认），
    选择“将update选择“简体中文”并确认（音量键选择电源键确认），
    选择“将update.zip安装至系统一”并确认。
    选择确认后等待完成，选择重启至系统一即可。



### 方法3：线刷

不适用部分红米手机（如下列表没有的机型则不支持）。

1. 下载 通用刷机工具
    <http://bigota.d.miui.com/tools/MiFlash2017-12-12-0-ex.zip>
    (大小:36M，MD5:9d3bb2ba44b75ef1a840483f599bb419)
    (如需安装驱动，执行XiaoMiFlash.exe运行后，点击左上角Driver,再点击安装即可) 
2. 下载 线刷fastboot版本
    <http://www.miui.com/shuaji-393.html>
    (请检查文件后缀名是否为".tgz"，如果为".gz" 请重新命名后缀为".tgz"）

3. 进入Fastboot模式
    关机状态下，同时按住 音量下+电源键 进入Fastboot模式将手机USB连接电脑。

4. 线刷包下载完成后解压，打开线刷包文件夹
5. 打开刷机工具，贴入线刷包的解压路径
6. 刷机工具，点击“加载设备”，刷机程序会自动识别手机；点击“刷机”后开始刷机。
7. 然后等待，工具显示刷机成功，手机会自动开机。

* **注意** 刷机工具最下方，不要选择“clean all and lock”，选择“Clean All”

## remount /system rewritable

参考： <https://blog.csdn.net/yapingmcu/article/details/53203549>

~~~ bat
>adb version
Android Debug Bridge version 1.0.39
Version 0.0.1-4500957
Installed as D:\sdk_full\platform-tools\adb.exe

>adb root

>adb disable-verity
Verity disabled on /system
Now reboot your device for settings to take effect

>adb reboot

>adb root

>adb remount
remount succeeded

>adb shell
tiffany:/ # mount | grep system
/dev/block/mmcblk0p24 on /system type ext4 (rw,seclabel,relatime,discard,data=ordered)
~~~



## 修改按键映射

* 参考
  * <https://zhidao.baidu.com/question/1800869515413680627.html>
  * <http://tieba.baidu.com/p/1899865022?traceid=>
  * [android kl文件](https://blog.csdn.net/mcgrady_tracy/article/details/47358689)
  * [android 添加按键（一) kl文件 kcm文件](https://blog.csdn.net/kc58236582/article/details/49925267)
  * [android kl 文件的作用](https://blog.csdn.net/u013308744/article/details/49274069)

### android kl文件

~~~ shell
# 查看手机的input设备
adb shell cat /proc/bus/input/devices

# 或者
adb shell getevent -p

# 或者
adb shell dumpsys input
~~~

~~~ shell
# 小米5x 的执行效果
# ft5435_ts 是触控按键
# fts_ts 可能是触摸屏，有这么个属性 touch.size.calibration: geometric

$ adb shell cat /proc/bus/input/devices

...

I: Bus=0018 Vendor=0000 Product=0000 Version=0000
N: Name="ft5435_ts"
P: Phys=
S: Sysfs=/devices/soc/78b7000.i2c/i2c-3/3-0038/input/input1
U: Uniq=
H: Handlers=mdss_fb kgsl event1
B: PROP=2
B: EV=b
B: KEY=400 0 0 100040008800 0 0
B: ABS=260800000000000

I: Bus=0018 Vendor=0000 Product=0000 Version=0000
N: Name="fts_ts"
P: Phys=
S: Sysfs=/devices/soc/78b7000.i2c/i2c-3/3-0040/input/input2
U: Uniq=
H: Handlers=mdss_fb kgsl event2
B: PROP=2
B: EV=b
B: KEY=400 0 0 100040000800 0 0
B: ABS=261800000000000

...
~~~


### 【实战】小米5x：交换 Home 键 和 返回键的位置

1. 编辑 /system/usr/keylayout/Generic.kl
    1. `key 158   BACK` 改为 `key 172   BACK`
    1. `key 172   HOME` 改为 `key 158   HOME`
1. `adb shell cat /proc/bus/input/devices` 查看 input 设备名称，这里是 *ft5435_ts*
1. 编辑 /system/usr/keylayout/ft5435_ts.kl
    1. `key 172    HOME    VIRTUAL` 改为 `key 158    HOME    VIRTUAL`
    1. `key 158    BACK    VIRTUAL` 改为 `key 172    BACK    VIRTUAL`
1. 重启手机






## 使用屏幕的虚拟导航按键 / Enable On-Screen buttons 

屏幕上显示back、home、menu三剑客按键。

修改 /system/build.prop 中添加 `qemu.hw.mainkeys=0` 或者已有该属性，就改其值为 0。

















