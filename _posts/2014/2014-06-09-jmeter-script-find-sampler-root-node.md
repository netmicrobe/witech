---
layout: post
title: jmeter：找到当前sampler的根节点
description: 
categories: [cm, jmeter]
tags: [cm, jmeter]
---

##  修改JMeter源码：JMeterThread.java，开放hashtree

apache-jmeter-2.9\src\core\org\apache\jmeter\threads\JMeterThread.java

```java
- private final HashTree testTree;
+ public final HashTree testTree;
```

jmeter.2.11.RC2/src/core/org/apache/jmeter/control/TransactionController.java

```java
- private transient TransactionSampler transactionSampler;
+ public transient TransactionSampler transactionSampler;
```

##  在BeanShell Assertion里边编码

```java
Sampler sam = ctx.getCurrentSampler();
// Find parent controllers of current sampler
FindTestElementsUpToRootTraverser pathToRootTraverser=null;
TransactionSampler transactionSampler = null;
if(sam instanceof TransactionSampler) {
    transactionSampler = (TransactionSampler) sam;
    pathToRootTraverser = new FindTestElementsUpToRootTraverser((transactionSampler).getTransactionController());
} else {
    pathToRootTraverser = new FindTestElementsUpToRootTraverser(sam);
}
ctx.getThread().testTree.traverse(pathToRootTraverser);
List controllersToReinit = pathToRootTraverser.getControllersToRoot();
 
// Trigger end of loop condition on all parent controllers of current sampler
System.out.println("============================== " + prev.getSampleLabel());
for (Iterator iterator = controllersToReinit.iterator(); iterator.hasNext();) {
    Controller parentController =  (Controller)iterator.next();
    System.out.println("    " + parentController.getName());
}
```

## 运行效果

![](/images/cm/jmeter/track_root_of_sampler_sample01.png)
![](/images/cm/jmeter/track_root_of_sampler_sample02.png)








