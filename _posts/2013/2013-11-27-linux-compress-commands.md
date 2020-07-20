---
layout: post
title: linux 压缩命令 tar, 7z
categories: [cm, linux]
tags: [linux, tar, 7z]
---

* 参考
  * [Gzip vs Bzip2 vs XZ Performance Comparison](https://www.rootusers.com/gzip-vs-bzip2-vs-xz-performance-comparison/)
  * [-m (Set compression Method) switch](https://sevenzip.osdn.jp/chm/cmdline/switches/method.htm#:~:text=It can be in the range from 1 to 10,and a slower compression process.&text=Sets multithread mode.,-If you have)
  * []()
  * []()


## gz,tar

压缩：tar -czf some.tar.gz file1 file2 folder1/*
解压：tar -xzf some.tar.gz







## xz

* [13 Simple XZ Examples](https://www.rootusers.com/13-simple-xz-examples/)
* [Linux xz Command Tutorial for Beginners (7 Examples)](https://www.howtoforge.com/linux-xz-command/)
* []()
* []()


### 安装xz

~~~
# debian / ubuntu
apt-get install xz-utils


# RHEL
yum install xz
~~~


### xz压缩

~~~
# --threads=0 尽可能使用所有进程
# 默认compress level 是 6
# -e or --extreme flag 将使用更多CPU来提高压缩率，会拖慢压缩时间
# -k 执行完不删除原来的文件
xz -z6vek --threads=0 target-file

# compress level = 0
time xz -0v linux-3.18.19.tar
# compress level = 9
time xz -9v linux-3.18.19.tar

# 压缩多个文件
xz file1.txt file2.txt file3.txt
~~~


### xz解压

~~~
# -k 执行完不删除原来的文件
xz -dk file.txt.xz
# 或
unxz -k file.txt.xz
~~~


~~~
xz -h
Usage: xz [OPTION]... [FILE]...
Compress or decompress FILEs in the .xz format.

  -z, --compress      force compression
  -d, --decompress    force decompression
  -t, --test          test compressed file integrity
  -l, --list          list information about .xz files
  -k, --keep          keep (don't delete) input files
  -f, --force         force overwrite of output file and (de)compress links
  -c, --stdout        write to standard output and don't delete input files
  -0 ... -9           compression preset; default is 6; take compressor *and*
                      decompressor memory usage into account before using 7-9!
  -e, --extreme       try to improve compression ratio by using more CPU time;
                      does not affect decompressor memory requirements
  -T, --threads=NUM   use at most NUM threads; the default is 1; set to 0
                      to use as many threads as there are processor cores
  -q, --quiet         suppress warnings; specify twice to suppress errors too
  -v, --verbose       be verbose; specify twice for even more verbose
  -h, --help          display this short help and exit
  -H, --long-help     display the long help (lists also the advanced options)
  -V, --version       display the version number and exit

With no FILE, or when FILE is -, read standard input.

Report bugs to <lasse.collin@tukaani.org> (in English or Finnish).
XZ Utils home page: <http://tukaani.org/xz/>
~~~









## bzip2

* [Linux bzip2 Command Tutorial for Beginners](https://www.howtoforge.com/linux-bzip2-command/)
* []()
* []()
* []()

~~~
$ bzip2 -h
bzip2, a block-sorting file compressor.  Version 1.0.6, 6-Sept-2010.

   usage: bzip2 [flags and input files in any order]

   -h --help           print this message
   -d --decompress     force decompression
   -z --compress       force compression
   -k --keep           keep (don't delete) input files
   -f --force          overwrite existing output files
   -t --test           test compressed file integrity
   -c --stdout         output to standard out
   -q --quiet          suppress noncritical error messages
   -v --verbose        be verbose (a 2nd -v gives more)
   -L --license        display software version & license
   -V --version        display software version & license
   -s --small          use less memory (at most 2500k)
   -1 .. -9            set block size to 100k .. 900k
   --fast              alias for -1
   --best              alias for -9

   If invoked as `bzip2', default action is to compress.
              as `bunzip2',  default action is to decompress.
              as `bzcat', default action is to decompress to stdout.

   If no file names are given, bzip2 compresses or decompresses
   from standard input to standard output.  You can combine
   short flags, so `-v -4' means the same as -v4 or -4v, &c.
~~~








## 7z

* [7-Zip Command Line Examples — All Syntaxes Shared Here](https://7ziphelp.com/7zip-command-line)
* [Understanding 7z command switches - part I](https://www.howtoforge.com/tutorial/understanding-7z-command-switches/)
* []()
* []()


### 安装

```shell
#Ubuntu
sudo apt-get install p7zip-full

# CentOS
yum -y install p7zip

# arch
sudo pacman -S p7zip
```

### 解压

```shell
7z x some7zfile.7z       解压到当前目录
```

### 压缩

```shell
7z a target-name.7z target-dir/

# -mx=1 最快压缩
7z a -mx=1 -mmt=6 target-name.7z target-file1 target-file2
```

### 其他技巧

#### 对目录下的子文件逐个压缩

* 参考
  * <https://stackoverflow.com/a/17009555/3316529>

~~~ shell
for i in $(ls -1); do 7z a ${i%%/}.7z ${i%%/}; done
~~~

另外一种方法：

~~~ shell
\ls -1 | xargs -I% 7z a %.7z %
~~~






