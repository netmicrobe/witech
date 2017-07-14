---
layout: post
title: ruby 中，将字节数组转换成特定编码的字符串
categories: [dev, ruby]
tags: 
  - encoding
  - ruby
  - character-set
---

* <https://stackoverflow.com/a/4701955>

使用 pack & force_encoding。

~~~ shell
irb> [0xe9, 0xa1, 0xb9].pack("C*").force_encoding("utf-8")
=> "\u9879"
irb> [0xe9, 0xa1, 0xb9].pack("C*").force_encoding("utf-8").encode("gbk")
=> "项"
irb> "\xe9\xa1\xb9".force_encoding("utf-8")
=> "\u9879"
~~~