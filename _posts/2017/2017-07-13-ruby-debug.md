---
layout: post
title: ruby 和 rails 调试方法
categories: [dev, ruby]
tags: [ruby, debug, rails]
---

##  meta information

    self    # 当前对象，打印出类名
    class  类型
    included_modules   所有包含的Module
    instance_variables 所有变量
    methods  所有方法
    ancestors 祖先（继承自）
    类名.constants
    instance_variables    # 打印出当前实例的所有变量


* 例子

~~~ ruby
# 查找方法是继承自哪里
puts Car.ancestors.inspect
~~~

~~~ ruby
Issue.ancestors.each { |a| p a if a.instance_methods.include?(:your-wanna-method) }
String.ancestors.grep(Class)
object.method(:your-method)
object.method(:your-method).source_location
~~~

~~~ ruby
some-class.methods    # 打印出对应类的方法
~~~


## logger

~~~ ruby
logger.debug "Person attributes hash: #{@person.attributes.inspect}"
logger.info "Processing the request..."
logger.fatal "Terminating application, raised unrecoverable error!!!"
~~~








## rails

rails console 进入rails 执行环境，测试语句

app.entities_path 打印 route path

在 controller 中调试
参考：http://guides.rubyonrails.org/debugging_rails_applications.html

调试 Activie Record 使用 explain
explain 能打印出SQL
User.where(:id => 1).joins(:posts).explain
User.where(:id => 1).includes(:posts).explain

获取 header，request.env

request.env['HTTP_ACCEPT_LANGUAGE']  # 获取 Accept-Language

debug

<%= debug @post %>

inspect

<%= [1, 2, 3, 4, 5].inspect %>

### Logger

The available log levels are: 
:debug, :info, :warn, :error, and :fatal, 
corresponding to the log level numbers from 0 up to 4 respectively.

The default Rails log level is info in production mode and debug in development and test mode.

配置：
config.log_level = :warn # In any environment initializer, or
Rails.logger.level = 0 # at any time

写日志
logger.debug "Person attributes hash: #{@person.attributes.inspect}"
logger.info "Processing the request..."
logger.fatal "Terminating application, raised unrecoverable error!!!"
