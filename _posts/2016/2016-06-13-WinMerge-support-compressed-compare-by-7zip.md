---
layout: post
title: winMerge 支持压缩包比较
categories: [cm, diff]
tags: [cm, diff, winMerge]
author: Palec
---

参考：<http://stackoverflow.com/a/32537300>


In WinMerge 2.14.0[^1], the easiest way to enable archive support is to 

* download the 7-7ip plugin for WinMerge[^2],
* use its installer to install the DLLs and related components for the latest 7-Zip supported into the folder of WinMerge[^3] (select the “Application specific installation” and “Enable standalone operation”), and
* change the WinMerge settings to use these files and detect archive type automatically (in “Options → Archive Support” select “Enable archive file support”, “Use local 7-Zip from WinMerge folder” and “Detect archive type from file signature”).

![](/images/cm/diff/WinMerge_7z_settings.png)

Image and the solution are by jtuc, the developer of WinMerge. I found them in a WinMerge forum thread.

Then, if you compare two JAR files (or files in any other archive-based format, e.g. ODF or OOXML), their contents should be compared as if they were extracted first. It works for me on Windows 10.

Some details on installing archive support are mentioned in the WinMerge manual.

[^1]: WinMerge 2.14.0 is the latest stable release as of 2015-09, released at 2013-02-03.

[^2]: Merge7z DllBuild 0028 is the latest as of 2015-09, released at 2010-12-28.

[^3]: The DLLs are Merge7z920.dll and Merge7z920U.dll for 7-Zip 9.20 in Merge7z DllBuild 0028, and the path to WinMerge executable is probably C:\Program Files (x86)\WinMerge\WinMergeU.exe. The “U” stands for Unicode in both the DLL’s and executable’s name. For WinMergeU.exe, only Merge7z920U.dll is needed, but better have both and don’t have to care.

