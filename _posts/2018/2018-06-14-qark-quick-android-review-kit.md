---
layout: post
title: QARK, Quick Android Review Kit
categories: [ cm, android ]
tags: [ security, qark ]
---

* 参考
  * [Github - linkedin/qark/](https://github.com/linkedin/qark/)

---

* Qark (Quick Android Review Kit) 用来扫描Android 代码和apk的安全漏洞。
* Unlike commercial products, it is 100% free to use. 
* it can produce ADB commands, or even fully functional APKs, that turn hypothetical vulnerabilities into working "POC" exploits.


## Install

~~~
git clone https://github.com/linkedin/qark.git
sudo apt-get install openjdk-8-jdk
pip install html5lib
~~~


## Usage

To run in interactive mode:

~~~
$ python qarkMain.py
~~~

To run in headless mode:

~~~
$ python qarkMain.py --source 1 --pathtoapk /Users/foo/qark/sampleApps/goatdroid/goatdroid.apk --exploit 1 --install
or
$ python qarkMain.py --source 2 -c /Users/foo/qark/sampleApps/goatdroid/goatdroid --manifest /Users/foo/qark/sampleApps/goatdroid/goatdroid/AndroidManifest.xml --exploit 1 --install
~~~

* 注：没有成功运行生成报告，在centos7、ubuntu18.04 都试过了。
  ~~~
  ------------ Building Exploit APK ------------
  /opt/github.linkedin.qark/qark/settings.properties
  /opt/android-sdk/
  Exception while determining highest SDK. Using default SDK 21
  org.gradle.process.internal.ExecException: Process 'command '/opt/android-sdk/tools/android'' finished with non-zero exit value 2
    at org.gradle.process.internal.DefaultExecHandle$ExecResultImpl.assertNormalExitValue(DefaultExecHandle.java:365)
    at org.gradle.process.internal.DefaultExecAction.execute(DefaultExecAction.java:31)
    at org.gradle.api.internal.file.DefaultFileOperations.exec(DefaultFileOperations.java:151)
    at org.gradle.api.internal.project.AbstractProject.exec(AbstractProject.java:792)
    at org.gradle.groovy.scripts.DefaultScript.exec(DefaultScript.java:197)
    at org.gradle.api.Script$exec$1.callCurrent(Unknown Source)
    at build_1wmemms4vnpi0gmxkdny1k5w3.sdksAvailable(/opt/github.linkedin.qark/qark/build/qark/app/build.gradle:8)
    at build_1wmemms4vnpi0gmxkdny1k5w3.highestSdkAvailable(/opt/github.linkedin.qark/qark/build/qark/app/build.gradle:28)
    at build_1wmemms4vnpi0gmxkdny1k5w3$_run_closure1.doCall(/opt/github.linkedin.qark/qark/build/qark/app/build.gradle:91)
    at org.gradle.api.internal.ClosureBackedAction.execute(ClosureBackedAction.java:63)
    at org.gradle.api.internal.plugins.ExtensionsStorage$ExtensionHolder.configure(ExtensionsStorage.java:145)
    at org.gradle.api.internal.plugins.ExtensionsStorage.configureExtension(ExtensionsStorage.java:69)
    at org.gradle.api.internal.plugins.DefaultConvention$ExtensionsDynamicObject.invokeMethod(DefaultConvention.java:207)
    at org.gradle.api.internal.CompositeDynamicObject.invokeMethod(CompositeDynamicObject.java:147)
    at org.gradle.groovy.scripts.BasicScript.methodMissing(BasicScript.java:79)
    at build_1wmemms4vnpi0gmxkdny1k5w3.run(/opt/github.linkedin.qark/qark/build/qark/app/build.gradle:90)
    at org.gradle.groovy.scripts.internal.DefaultScriptRunnerFactory$ScriptRunnerImpl.run(DefaultScriptRunnerFactory.java:52)
    at org.gradle.configuration.DefaultScriptPluginFactory$ScriptPluginImpl.apply(DefaultScriptPluginFactory.java:148)
    at org.gradle.configuration.project.BuildScriptProcessor.execute(BuildScriptProcessor.java:39)
    at org.gradle.configuration.project.BuildScriptProcessor.execute(BuildScriptProcessor.java:26)
    at org.gradle.configuration.project.ConfigureActionsProjectEvaluator.evaluate(ConfigureActionsProjectEvaluator.java:34)
    at org.gradle.configuration.project.LifecycleProjectEvaluator.evaluate(LifecycleProjectEvaluator.java:59)
    at org.gradle.api.internal.project.AbstractProject.evaluate(AbstractProject.java:504)
    at org.gradle.api.internal.project.AbstractProject.evaluate(AbstractProject.java:83)
    at org.gradle.execution.TaskPathProjectEvaluator.configureHierarchy(TaskPathProjectEvaluator.java:47)
    at org.gradle.configuration.DefaultBuildConfigurer.configure(DefaultBuildConfigurer.java:35)
    at org.gradle.initialization.DefaultGradleLauncher.doBuildStages(DefaultGradleLauncher.java:129)
    at org.gradle.initialization.DefaultGradleLauncher.doBuild(DefaultGradleLauncher.java:106)
    at org.gradle.initialization.DefaultGradleLauncher.run(DefaultGradleLauncher.java:86)
    at org.gradle.launcher.exec.InProcessBuildActionExecuter$DefaultBuildController.run(InProcessBuildActionExecuter.java:80)
    at org.gradle.launcher.cli.ExecuteBuildAction.run(ExecuteBuildAction.java:33)
    at org.gradle.launcher.cli.ExecuteBuildAction.run(ExecuteBuildAction.java:24)
    at org.gradle.launcher.exec.InProcessBuildActionExecuter.execute(InProcessBuildActionExecuter.java:36)
    at org.gradle.launcher.exec.InProcessBuildActionExecuter.execute(InProcessBuildActionExecuter.java:26)
    at org.gradle.launcher.cli.RunBuildAction.run(RunBuildAction.java:51)
    at org.gradle.internal.Actions$RunnableActionAdapter.execute(Actions.java:171)
    at org.gradle.launcher.cli.CommandLineActionFactory$ParseAndBuildAction.execute(CommandLineActionFactory.java:237)
    at org.gradle.launcher.cli.CommandLineActionFactory$ParseAndBuildAction.execute(CommandLineActionFactory.java:210)
    at org.gradle.launcher.cli.JavaRuntimeValidationAction.execute(JavaRuntimeValidationAction.java:35)
    at org.gradle.launcher.cli.JavaRuntimeValidationAction.execute(JavaRuntimeValidationAction.java:24)
    at org.gradle.launcher.cli.CommandLineActionFactory$WithLogging.execute(CommandLineActionFactory.java:206)
    at org.gradle.launcher.cli.CommandLineActionFactory$WithLogging.execute(CommandLineActionFactory.java:169)
    at org.gradle.launcher.cli.ExceptionReportingAction.execute(ExceptionReportingAction.java:33)
    at org.gradle.launcher.cli.ExceptionReportingAction.execute(ExceptionReportingAction.java:22)
    at org.gradle.launcher.Main.doAction(Main.java:33)
    at org.gradle.launcher.bootstrap.EntryPoint.run(EntryPoint.java:45)
    at org.gradle.launcher.bootstrap.ProcessBootstrap.runNoExit(ProcessBootstrap.java:54)
    at org.gradle.launcher.bootstrap.ProcessBootstrap.run(ProcessBootstrap.java:35)
    at org.gradle.launcher.GradleMain.main(GradleMain.java:23)
    at org.gradle.wrapper.BootstrapMainStarter.start(BootstrapMainStarter.java:33)
    at org.gradle.wrapper.WrapperExecutor.execute(WrapperExecutor.java:130)
    at org.gradle.wrapper.GradleWrapperMain.main(GradleWrapperMain.java:48)
  /opt/github.linkedin.qark/qark/settings.properties
  /opt/android-sdk/
  Using latest found build tools 28.0.1
  :app:preBuild UP-TO-DATE
  :app:preDebugBuild UP-TO-DATE
  :app:compileDebugNdk UP-TO-DATE
  :app:checkDebugManifest
  :app:preReleaseBuild UP-TO-DATE
  :app:prepareComAndroidSupportAppcompatV72221Library
  :app:prepareComAndroidSupportDesign2221Library
  :app:prepareComAndroidSupportRecyclerviewV72221Library
  :app:prepareComAndroidSupportSupportV42221Library
  :app:prepareDebugDependencies
  :app:compileDebugAidl
  :app:compileDebugRenderscript
  :app:generateDebugBuildConfig
  :app:generateDebugAssets UP-TO-DATE
  :app:mergeDebugAssets
  :app:generateDebugResValues
  :app:generateDebugResources
  :app:mergeDebugResources
  :app:processDebugManifest
  :app:processDebugResources
  :app:generateDebugSources
  :app:compileDebugJavaNote: Some input files use or override a deprecated API.
  Note: Recompile with -Xlint:deprecation for details.
  Note: Some input files use unchecked or unsafe operations.
  Note: Recompile with -Xlint:unchecked for details.

  :app:preDexDebug
  :app:dexDebug
  :app:processDebugJavaRes UP-TO-DATE
  :app:validateDebugSigning
  :app:packageDebug
  :app:zipalignDebug
  :app:assembleDebug

  BUILD SUCCESSFUL

  Total time: 1 mins 9.514 secs
  INFO - The apk can be found in the /opt/github.linkedin.qark/qark/build/qark directory
  ERROR - Problem with reporting; No html report generated. Please see the readme file for possible solutions.
  Goodbye!


  ~~~

## Requirements

    python 2.7.6
    JRE 1.6+ (preferably 1.7+)
    OSX or RHEL6.6 (Others may work, but not fully tested)















































