---
layout: post
title: 在Ubuntu上安装uml画图工具-astah-community
categories: [cm, linux]
tags: [diagram]
---

* 参考： 
  * []()
  * []()
  * []()
  * []()


下载地址： <http://cdn.change-vision.com/files/astah-community-7_2_0-1ff236.zip>

解压，运行其中的脚本 astah


### 遗留问题

可以打开GUI，加载 asta 文件，但是打开其中的图表报错：

* Java版本

~~~
openjdk 11.0.7 2020-04-14
OpenJDK Runtime Environment (build 11.0.7+10-post-Ubuntu-2ubuntu218.04)
OpenJDK 64-Bit Server VM (build 11.0.7+10-post-Ubuntu-2ubuntu218.04, mixed mode, sharing)
~~~


* 报错信息

~~~
2020-07-23 14:50:30,300 [AWT-EventQueue-0] JP.co.esm.caddies.jomt.jview.eA <ERROR> - error has occurred.
java.lang.NoClassDefFoundError: com/sun/java/swing/plaf/windows/WindowsLookAndFeel
	at JP.co.esm.caddies.jomt.jview.swing.SwingDiagramEditorPeer.a(X:232) ~[astah-community.jar:na]
	at JP.co.esm.caddies.jomt.jview.bf.<init>(X:181) ~[astah-community.jar:na]
	at JP.co.esm.caddies.jomt.jview.bf.<init>(X:169) ~[astah-community.jar:na]
	at JP.co.esm.caddies.jomt.jcontrol.OpenDiagramEditorCommand.a(X:239) ~[astah-community.jar:na]
	at JP.co.esm.caddies.jomt.jcontrol.OpenDiagramEditorCommand.execute(X:164) ~[astah-community.jar:na]
	at g.start(X:53) ~[astah-community.jar:na]
	at m.run(X:88) ~[astah-community.jar:na]
	at m.b(X:103) ~[astah-community.jar:na]
	at l.a(X:107) ~[astah-community.jar:na]
	at g.a(X:96) ~[astah-community.jar:na]
	at g.a(X:118) ~[astah-community.jar:na]
	at g.a(X:106) ~[astah-community.jar:na]
	at JP.co.esm.caddies.jomt.jcontrol.OpenDiagramEditorFromPrjCommand.execute(X:55) ~[astah-community.jar:na]
	at g.start(X:53) ~[astah-community.jar:na]
	at m.run(X:88) ~[astah-community.jar:na]
	at m.b(X:103) ~[astah-community.jar:na]
	at l.a(X:107) ~[astah-community.jar:na]
	at q.a(X:116) ~[astah-community.jar:na]
	at q.actionPerformed(X:95) ~[astah-community.jar:na]
	at java.desktop/javax.swing.AbstractButton.fireActionPerformed(AbstractButton.java:1967) ~[na:na]
	at java.desktop/javax.swing.AbstractButton$Handler.actionPerformed(AbstractButton.java:2308) ~[na:na]
	at java.desktop/javax.swing.DefaultButtonModel.fireActionPerformed(DefaultButtonModel.java:405) ~[na:na]
	at java.desktop/javax.swing.DefaultButtonModel.setPressed(DefaultButtonModel.java:262) ~[na:na]
	at java.desktop/javax.swing.AbstractButton.doClick(AbstractButton.java:369) ~[na:na]
	at java.desktop/javax.swing.plaf.basic.BasicMenuItemUI.doClick(BasicMenuItemUI.java:1020) ~[na:na]
	at java.desktop/javax.swing.plaf.basic.BasicMenuItemUI$Handler.mouseReleased(BasicMenuItemUI.java:1064) ~[na:na]
	at java.desktop/java.awt.Component.processMouseEvent(Component.java:6631) ~[na:na]
	at java.desktop/javax.swing.JComponent.processMouseEvent(JComponent.java:3342) ~[na:na]
	at java.desktop/java.awt.Component.processEvent(Component.java:6396) ~[na:na]
	at java.desktop/java.awt.Container.processEvent(Container.java:2263) ~[na:na]
	at java.desktop/java.awt.Component.dispatchEventImpl(Component.java:5007) ~[na:na]
	at java.desktop/java.awt.Container.dispatchEventImpl(Container.java:2321) ~[na:na]
	at java.desktop/java.awt.Component.dispatchEvent(Component.java:4839) ~[na:na]
	at java.desktop/java.awt.LightweightDispatcher.retargetMouseEvent(Container.java:4918) ~[na:na]
	at java.desktop/java.awt.LightweightDispatcher.processMouseEvent(Container.java:4547) ~[na:na]
	at java.desktop/java.awt.LightweightDispatcher.dispatchEvent(Container.java:4488) ~[na:na]
	at java.desktop/java.awt.Container.dispatchEventImpl(Container.java:2307) ~[na:na]
	at java.desktop/java.awt.Window.dispatchEventImpl(Window.java:2772) ~[na:na]
	at java.desktop/java.awt.Component.dispatchEvent(Component.java:4839) ~[na:na]
	at java.desktop/java.awt.EventQueue.dispatchEventImpl(EventQueue.java:772) ~[na:na]
	at java.desktop/java.awt.EventQueue$4.run(EventQueue.java:721) ~[na:na]
	at java.desktop/java.awt.EventQueue$4.run(EventQueue.java:715) ~[na:na]
	at java.base/java.security.AccessController.doPrivileged(Native Method) ~[na:na]
	at java.base/java.security.ProtectionDomain$JavaSecurityAccessImpl.doIntersectionPrivilege(ProtectionDomain.java:85) ~[na:na]
	at java.base/java.security.ProtectionDomain$JavaSecurityAccessImpl.doIntersectionPrivilege(ProtectionDomain.java:95) ~[na:na]
	at java.desktop/java.awt.EventQueue$5.run(EventQueue.java:745) ~[na:na]
	at java.desktop/java.awt.EventQueue$5.run(EventQueue.java:743) ~[na:na]
	at java.base/java.security.AccessController.doPrivileged(Native Method) ~[na:na]
	at java.base/java.security.ProtectionDomain$JavaSecurityAccessImpl.doIntersectionPrivilege(ProtectionDomain.java:85) ~[na:na]
	at java.desktop/java.awt.EventQueue.dispatchEvent(EventQueue.java:742) ~[na:na]
	at java.desktop/java.awt.EventDispatchThread.pumpOneEventForFilters(EventDispatchThread.java:203) ~[na:na]
	at java.desktop/java.awt.EventDispatchThread.pumpEventsForFilter(EventDispatchThread.java:124) ~[na:na]
	at java.desktop/java.awt.EventDispatchThread.pumpEventsForHierarchy(EventDispatchThread.java:113) ~[na:na]
	at java.desktop/java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:109) ~[na:na]
	at java.desktop/java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:101) ~[na:na]
	at java.desktop/java.awt.EventDispatchThread.run(EventDispatchThread.java:90) ~[na:na]
Caused by: java.lang.ClassNotFoundException: com.sun.java.swing.plaf.windows.WindowsLookAndFeel
	at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:581) ~[na:na]
	at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:178) ~[na:na]
	at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:522) ~[na:na]
	... 56 common frames omitted

~~~




