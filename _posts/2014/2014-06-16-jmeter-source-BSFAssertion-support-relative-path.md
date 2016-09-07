---
layout: post
title: jmeter：修改源码，BSFAssetion、BeanShellAssertion 支持设置相对路径的脚本文件
description: 
categories: [cm, jmeter]
tags: [cm, jmeter]
---

### src/core/org/apache/jmeter/services/FileServer.java

脚本文件可以使用相对路径“~\”或"~\"

```java
+       // ADD BY wi, compatible with windows path separator
+       private static final String BASE_PREFIX_WIN = "~\\";
+

     public static String resolveBaseRelativeName(String relativeName) {
-        if (relativeName.startsWith(BASE_PREFIX)){
+        if ( relativeName.startsWith(BASE_PREFIX) || relativeName.startsWith(BASE_PREFIX_WIN) ){
```

### src/core/org/apache/jmeter/util/BSFTestElement.java

BSFAssetion支持设置相对路径的脚本文件

分别在processFileOrScript(BSFManager mgr)、evalFileOrScript(BSFManager mgr) 

```java
-                String script=FileUtils.readFileToString(new File(scriptFile));
-                bsfEngine.exec(scriptFile,0,0,script);
+                               // REMOVE AND REPLACE BY wi, 2014-06-11, for support relative path in BSFAssertion
+                               String realfile = FileServer.resolveBaseRelativeName(scriptFile);
+                               String script=FileUtils.readFileToString(new File(realfile));
+                               bsfEngine.exec(realfile,0,0,script);
+                               // END OF BLOCK BY wi
```

### src/core/org/apache/jmeter/util/BeanShellTestElement.java

BeanShellAssetion脚本文件可以使用相对路径

```java
+import org.apache.jmeter.services.FileServer;

     protected Object processFileOrScript(BeanShellInterpreter bsh) throws JMeterException{
-        String fileName = getFilename();
+               // REMOVE AND REPLACE BY wi, 2014-06-11, for support relative path in BSFAssertion
+               String fileName = FileServer.resolveBaseRelativeName(getFilename());
+               // END OF BLOCK BY wi
```




