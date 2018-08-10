---
layout: post
title: linux sort 命令
categories: [ cm, linux ]
tags: []
---

## 命令格式

~~~
sort [-bcfMnrtk][源文件][-o 输出文件]

参数：
  -b   忽略每行前面开始出的空格字符。
  -c   检查文件是否已经按照顺序排序。
  -f   排序时，忽略大小写字母。
  -M   将前面3个字母依照月份的缩写进行排序。
  -n   依照数值的大小排序。
  -o<输出文件>   将排序后的结果存入指定的文件。
  -r   以相反的顺序来排序。
  -t<分隔字符>   指定排序时所用的栏位分隔字符。
  -k  选择以哪个区间进行排序。
~~~


## 例子


### 按文件大小排序

* 能找出散在各文件夹的重复文件

~~~ shell
find . -name *.so -exec ls -l {} \; | sort -t ' ' -k 4
~~~

~~~
-rwxrwx---+ 1 root None 335820 8月   6 14:53 ./app/build/intermediates/jniLibs/debug/armeabi-v7a/libjiagu.so
-rwxrwx---+ 1 root None 335820 8月   6 14:53 ./app/libs/armeabi-v7a/libjiagu.so
-rwxrwx---+ 1 root None 335820 8月   7 16:06 ./app/build/intermediates/transforms/mergeJniLibs/debug/0/lib/armeabi-v7a/libjiagu.so
-rwxrwx---+ 1 root None 335820 8月   7 16:06 ./app/build/intermediates/transforms/stripDebugSymbol/debug/0/lib/armeabi-v7a/libjiagu.so
-rwxrwx---+ 1 root None 368580 8月   6 14:53 ./app/build/intermediates/jniLibs/debug/armeabi/libjiagu.so
-rwxrwx---+ 1 root None 368580 8月   6 14:53 ./app/libs/armeabi/libjiagu.so
-rwxrwx---+ 1 root None 368580 8月   7 16:06 ./app/build/intermediates/transforms/mergeJniLibs/debug/0/lib/armeabi/libjiagu.so
-rwxrwx---+ 1 root None 368580 8月   7 16:06 ./app/build/intermediates/transforms/stripDebugSymbol/debug/0/lib/armeabi/libjiagu.so
-rwxrwx---+ 1 root None 446848 8月   6 14:53 ./app/build/intermediates/jniLibs/debug/x86_64/libjiagu.so
-rwxrwx---+ 1 root None 446848 8月   6 14:53 ./app/libs/x86_64/libjiagu.so
-rwxrwx---+ 1 root None 446848 8月   7 16:06 ./app/build/intermediates/transforms/mergeJniLibs/debug/0/lib/x86_64/libjiagu.so
-rwxrwx---+ 1 root None 446848 8月   7 16:06 ./app/build/intermediates/transforms/stripDebugSymbol/debug/0/lib/x86_64/libjiagu.so
-rwxrwx---+ 1 root None 463040 8月   6 14:53 ./app/build/intermediates/jniLibs/debug/arm64-v8a/libjiagu.so
-rwxrwx---+ 1 root None 463040 8月   6 14:53 ./app/libs/arm64-v8a/libjiagu.so
-rwxrwx---+ 1 root None 463040 8月   7 16:06 ./app/build/intermediates/transforms/mergeJniLibs/debug/0/lib/arm64-v8a/libjiagu.so
-rwxrwx---+ 1 root None 463040 8月   7 16:06 ./app/build/intermediates/transforms/stripDebugSymbol/debug/0/lib/arm64-v8a/libjiagu.so
-rwxrwx---+ 1 root None 474972 8月   6 14:53 ./app/build/intermediates/jniLibs/debug/x86/libjiagu.so
-rwxrwx---+ 1 root None 474972 8月   6 14:53 ./app/libs/x86/libjiagu.so
-rwxrwx---+ 1 root None 474972 8月   7 16:06 ./app/build/intermediates/transforms/mergeJniLibs/debug/0/lib/x86/libjiagu.so
-rwxrwx---+ 1 root None 474972 8月   7 16:06 ./app/build/intermediates/transforms/stripDebugSymbol/debug/0/lib/x86/libjiagu.so
~~~






































































