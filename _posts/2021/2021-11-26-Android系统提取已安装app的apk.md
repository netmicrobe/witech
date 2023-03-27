---
layout: post
title: Android系统提取已安装app的apk，关联 adb, android, dumpsys, aapt
categories: [cm, android]
tags: []
---

* 参考
  * [How to Extract APK File of Android App Without Root](https://beebom.com/how-extract-apk-android-app/)
  * []()
  * []()
  * []()
  * []()



~~~bash
adb shell pm list packages

adb shell pm path com.sdu.didi.psnger
package:/data/app/com.sdu.didi.psnger-zSCS03i2itPZSSnYvVXlig==/base.apk

adb pull /data/app/com.sdu.didi.psnger-zSCS03i2itPZSSnYvVXlig==/base.apk .
~~~



* 获取当前运行在前台的app 的 包名

~~~sh
adb shell dumpsys activity recents | grep 'Recent #0' | cut -d= -f2 | sed 's| .*||' | cut -d '/' -f1
~~~



## 备份所有安装的apk

* 参考
* <https://stackoverflow.com/questions/16650765/get-application-name-label-via-adb-shell-or-terminal>


~~~sh
#!/bin/bash

_TOOLS=/android-sdk-path/build-tools/34.0.0-rc2
_AAPT=${_TOOLS}/aapt
_PMLIST=packages_list.txt
_DIST_DIR="packages_"$(date "+%Y-%m-%d_%H%M%S")

adb shell pm list packages | sed -e 's|^package:||' | sort > ./${_PMLIST}

mkdir -p ${_DIST_DIR}

n=0
while read -u 9 _line; do
    #if (( n > 0 )); then break; fi
    _package=${_line##*:}
    _apkpath=$(adb shell pm path ${_package} | sed -e 's|^package:||' | head -n 1)
    _apkfilename=$(basename "${_apkpath}")
    
    if [[ "${_apkpath}" = /data/app/* ]]
    then
        echo ""
        echo "line: ${_line}"
        echo "package: ${_package}"
        echo "_apkpath: ${_apkpath}"
        echo "_apkfilename: {$_apkfilename}"
        
        adb pull ${_apkpath} ${_DIST_DIR}/
        
        _name=$(${_AAPT} dump badging "${_DIST_DIR}/${_apkfilename}" | sed -n 's|^application-label:\(.\)\(.*\)\1$|\2|p' )
        echo "APP NAME: ${_name}"
        
        _version=$(${_AAPT} dump badging "${_DIST_DIR}/${_apkfilename}" | sed -n '/versionName=/p' | awk 'match($0, /versionName=\S+/) {print substr($0, RSTART+13, RLENGTH-14)}')
        echo "APP VERSION: ${_version}"
        
        mv "${_DIST_DIR}/${_apkfilename}" "${_DIST_DIR}/${_package}-${_version}-${_name}.apk"
        
        echo ""
        n=$((n+1))
    fi
done 9< ${_PMLIST}

echo ""
echo "TOTAL $n apps are backed up."
~~~























