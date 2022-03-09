---
layout: post
title: rails-rake-task-使用.md
categories: [dev, ruby]
tags: []
---

* 参考
  * [What is Rake in Ruby & How to Use it](https://www.rubyguides.com/2019/02/ruby-rake/)
  * []()







## How to Write a Rake Task

~~~ruby
desc "Print reminder about eating more fruit."

task :apple do
  puts "Eat more apples!"
end
~~~

using Rails, you can save this under `lib/tasks/apple.rake`.


To run this task:

~~~sh
rake apple
# "Eat more apples!"
~~~


## rake task 开发

