---
layout: post
title: linux 压缩命令 tar, 7z
categories: [cm, linux]
tags: [linux, tar, 7z]
---


## gz,tar

压缩：tar -czf some.tar.gz file1 file2 folder1/*
解压：tar -xzf some.tar.gz

## 7z

### 安装

```shell
#Ubuntu
sudo apt-get install p7zip-full

# CentOS
yum -y install p7zip
```

### 解压

```shell
7z x some7zfile.7z       解压到当前目录
```

### 压缩

```shell
7z a target-name.7z target-dir/
```

### 对目录下的子文件逐个压缩

* 参考
  * <https://stackoverflow.com/a/17009555/3316529>

~~~ shell
for i in $(ls -1); do 7z a ${i%%/}.7z ${i%%/}; done
~~~

另外一种方法：

~~~ shell
\ls -1 | xargs -I% 7z a %.7z %
~~~






