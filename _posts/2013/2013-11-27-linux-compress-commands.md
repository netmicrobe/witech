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
