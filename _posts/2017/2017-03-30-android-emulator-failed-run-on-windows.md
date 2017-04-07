---
layout: post
title: 模拟器在windows上无法运行，abi 选择 intel atom x86 时
categories: [android, cm, emulator]
tags: [android, emulator, windows]
---

## 问题现象

AVD 的 abi 选择 intel atom x86 时，模拟器在windows上无法运行，报错如下：

```
...
CPU acceleration status: HAXM is not installed on this machine
...
```

## 分析

是因为 Intel® Hardware Accelerated Execution Manager （HAXM）没安装。

## 解决版本

1. 下载 HAXM : <https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager>
2. 解压后运行 intelhaxm-android.exe
3. 安装好后，在去启动 AVD 就正常了。

## 可能遇到的其他问题

* 参考： [Intel HAXM 安装指南](https://software.intel.com/en-us/android/articles/installation-instructions-for-intel-hardware-accelerated-execution-manager-windows)

### Execute Disable Bit capability error

When installing Intel HAXM, you may encounter an error regarding Execute Disable Bit support.
This error message can be triggered by the following conditions:

    Execute Disable Bit is not supported by your computer’s processor.
    Execute Disable Bit is not enabled.

Execute Disable Bit is not supported

Intel HAXM requires an Intel processor with Execute Disable Bit functionality and cannot be used on systems lacking this hardware feature. To determine the capabilities of your Intel processor, visit http://ark.intel.com.

### Execute Disable Bit is not enabled

In some cases, Execute Disable Bit may be disabled in the system BIOS and must be enabled within the BIOS setup utility. To access the BIOS setup utility, a setup key must be pressed during the computer’s boot sequence. This key is dependent on which BIOS is used but it is typically the F2, Delete, or Esc key. Within the BIOS setup utility, Execute Disable Bit may be identified by the terms "XD", "Execute Disable", "No Execute", or "Hardware DEP", depending on the BIOS used.

Windows* hosts may need to enable DEP (Data Execution Prevention) in addition to Execute Disable Bit, as described in this Microsoft* KB article: http://support.microsoft.com/kb/875352.

For specific information on entering BIOS setup and enabling Execute Disable Bit, please contact your hardware manufacturer.

### Intel Virtualization Technology (Intel VT-x) capability

When installing Intel HAXM, you may encounter an error regarding Intel VT-x support.
This error message can be triggered by the following conditions:

    Intel VT-x is not supported by your computer’s processor
    Intel VT-x is not enabled

### Intel VT-x is not supported

Intel HAXM requires an Intel processor with Intel VT-x functionality and cannot be used on systems lacking this hardware feature. To determine the capabilities of your Intel processor, visit​ http://ark.intel.com.

### Intel VT-x not enabled

In some cases, Intel VT-x may be disabled in the system BIOS and must be enabled within the BIOS setup utility. To access the BIOS setup utility, a key must be pressed during the computer’s boot sequence. This key is dependent on which BIOS is used but it is typically the F2, Delete, or Esc key. Within the BIOS setup utility, Intel VT may be identified by the terms "VT", "Virtualization Technology", or "VT-d." Make sure to enable all of the Virtualization features.

For specific information on entering BIOS setup and enabling Intel VT, please contact your hardware manufacturer.

## 参考

* [Intel® Hardware Accelerated Execution Manager (Intel® HAXM)](https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager)
* [Installation Instructions for Intel® Hardware Accelerated Execution Manager (Intel® HAXM) - Microsoft Windows](https://software.intel.com/en-us/android/articles/installation-instructions-for-intel-hardware-accelerated-execution-manager-windows)
* [stackoverflow - Error in launching AVD with AMD processor](http://stackoverflow.com/questions/26355645/error-in-launching-avd-with-amd-processor)
* [stackoverflow - Intel X86 emulator accelerator (HAXM installer) VT/NX not enabled](http://stackoverflow.com/questions/26521014/intel-x86-emulator-accelerator-haxm-installer-vt-nx-not-enabled)

