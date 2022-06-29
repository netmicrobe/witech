---
layout: post
title: rubyXL操作excel文件，关联 ruby, xlsx
categories: [dev, ruby]
tags: []
---

* 参考： 
  * [github.com/rubyXL](https://github.com/weshatheleopard/rubyXL)
  * []()
  * []()
  * []()
  * 各个Excel库评测对比
    * [Parsing Excel Files with Ruby](https://spin.atomicobject.com/2017/03/22/parsing-excel-files-ruby/)
    * [Faster Excel Parsing in Ruby](https://blog.schembri.me/post/faster-excel-parsing-in-ruby/)
  * []()
  * []()
  * []()
  * []()
  * []()


## 遍历行 / row

* 从某行开始遍历，比如，ignore header line，即从第二行开始

~~~ruby
sheet[1..-1].each do |row|
  # ignore first row as table header
  # do something interesting with a row
end
~~~

* 带着index
~~~ruby
workbook.first.each_with_index do |row, index|
  puts "Line number #{index} - Value = #{row[0].value}"
end
~~~


## 遍历 cell

遍历一行中的cell，转换为数组

~~~ruby
sheet[0].cells.collect {|c| c.value}
~~~


## 以列为数据对象的 excel ，生成 hash

~~~ruby
workbook = RubyXL::Parser.parse(xlsx_file_path)
# 第一个sheet
sheet = workbook[0]
col_a = sheet.collect {|row| row[0].value}
col_b = sheet.collect {|row| row[1].value}
entity_hash = Hash[[col_a, col_b].transpose]
~~~

* 说明： 上例中 `Array#transpose` 将数组做了个90度翻转重构，例如： 

~~~
2.3.7 :001 > a = [
2.3.7 :002 >       ['name', 'email', 'phone'],
2.3.7 :003 >       ['john', 'john@test.com', '1234567']
2.3.7 :004?>   ] 
 => [["name", "email", "phone"], ["john", "john@test.com", "1234567"]] 

2.3.7 :007 > b = a.transpose
=> [["name", "john"], ["email", "john@test.com"], ["phone", "1234567"]]
~~~


















































