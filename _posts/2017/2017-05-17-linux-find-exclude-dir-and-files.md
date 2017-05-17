---
layout: post
title: 使用 find 命令时，排除特定文件夹和文件
categories: [cm, linux]
tags: [linux, find]
---

## 例子，排除 .svn 目录，以及 word 的临时文件

```shell
$ find . -not \( -path "./.svn" -prune -o -name '~$*' -o -name '~WRL*tmp' \) -a -type f;
```

* 目录中所有文件列表

```shell
$ find .
.
./01.接口设计
./01.接口设计/api.docx
./01.接口设计/~$api.docx
./02.接口文档API
./02.接口文档API/document_v1.3.2上游 .docx
./02.接口文档API/document_v1.3.4下游.docx
./02.接口文档API/document_v1.3.5下游.docx
./02.接口文档API/document_v1.3.6下游.docx
./02.接口文档API/document_v1.3.7下游.docx
./02.接口文档API/~$document_v1.3.7.docx
./03.详细设计
./03.详细设计/.svn
./03.详细设计/.svn/entries
./03.详细设计/.svn/format
./03.详细设计/.svn/pristine
./03.详细设计/.svn/pristine/41
./03.详细设计/.svn/pristine/41/41846e52cb77e15e77f2dff53876f4d9fa75a80e.svn-base
./03.详细设计/.svn/pristine/8b
./03.详细设计/.svn/pristine/8b/8bff129fda9647dd9ce3c96768c04b006b9bd07c.svn-base
./03.详细设计/.svn/pristine/98
./03.详细设计/.svn/pristine/98/98b9472d9c3aa3997147af832ae660e385baa0cd.svn-base
./03.详细设计/.svn/pristine/da
./03.详细设计/.svn/pristine/da/da423bd835af7e2208b1120af818056b8c9df750.svn-base
./03.详细设计/.svn/tmp
./03.详细设计/.svn/wc.db
./03.详细设计/.svn/wc.db-journal
./03.详细设计/2.1.1迭代需求模块设计文档.docx
./03.详细设计/2.3.6迭代需求模块设计文档.docx
./03.详细设计/~$1.1迭代需求模块设计文档.docx
./03.详细设计/~WRL2338.tmp

```


* find 命令 来筛选后的结果

```shell
$ find . -not \( -path "./.svn" -prune -o -name '~$*' -o -name '~WRL*tmp' \) -a -type f;

./01.接口设计/api.docx
./02.接口文档API/document_v1.3.2上游 .docx
./02.接口文档API/document_v1.3.4下游.docx
./02.接口文档API/document_v1.3.5下游.docx
./02.接口文档API/document_v1.3.6下游.docx
./02.接口文档API/document_v1.3.7下游.docx
./03.详细设计/.svn/entries
./03.详细设计/.svn/format
./03.详细设计/.svn/pristine/41/41846e52cb77e15e77f2dff53876f4d9fa75a80e.svn-base
./03.详细设计/.svn/pristine/8b/8bff129fda9647dd9ce3c96768c04b006b9bd07c.svn-base
./03.详细设计/.svn/pristine/98/98b9472d9c3aa3997147af832ae660e385baa0cd.svn-base
./03.详细设计/.svn/pristine/da/da423bd835af7e2208b1120af818056b8c9df750.svn-base
./03.详细设计/.svn/wc.db
./03.详细设计/.svn/wc.db-journal
./03.详细设计/2.1.1迭代需求模块设计文档.docx
./03.详细设计/2.3.6迭代需求模块设计文档.docx

```
