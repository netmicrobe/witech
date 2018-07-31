---
layout: post
title: ruby 和 rails 调试方法
categories: [dev, ruby]
tags: [ruby, debug, rails, irb]
---

## console

命令行输入 `irb`

### rails console

* refer <http://edgeguides.rubyonrails.org/command_line.html>

```
bundle exec rails console
或者
bundle exec rails dbconsole
```

### 不打印返回值：在命令后面加上分号和0：“; 0”

```
your-command; 0
```


##  meta information

* self    # 当前对象，打印出类名
* class  类型
* included_modules   所有包含的Module
* ancestors 祖先（继承自）

* 类名.constants
* methods  所有方法
* instance_methods  实例方法
  * instance_methods(false)  不要包含继承来的方法
* instance_variables    # 打印出当前实例的所有变量


* 例子


~~~ ruby
# 查找类是否包含方法
ActiveRecord.methods.each {|m| p m if m.to_s.include?('version')}
ActiveRecord::Base.instance_methods.each {|m| p m if m.to_s.include?('version')}

# 查找数组的方法是否包含，re开头的
[].methods.grep /^re/ # => [:reverse_each, :reverse, ..., :replace, ...]
~~~

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



## 字符编码

~~~ ruby
String#force_encoding("utf-8")    # 强制编码 UTF-8
String#encode("utf-8")            # 当前编码转换为 UTF-8
String#unpack("C*")               # 将字符串转换为 无符号整数数组
String#unpack("C*").map {|b| b.to_s(16)} # 展示为十六进制
Array.pack("C*")                  # 将无符号整数数组 转换为 字符串
~~~



## rails

### 进入rails 执行环境，测试语句

```
rails console
```

### 查看 route

#### 命令行列出所有可用routes

~~~ ruby
bundle exec rake routes

# 某个controller 的 routes
CONTROLLER=users bundle exec rake routes
~~~


#### 开发模式直接网页查看 routes

`http://localhost:3000/rails/info/routes`

#### `app.entities_path` 打印 route path



### 在 controller 中调试

参考： <http://guides.rubyonrails.org/debugging_rails_applications.html>

### 调试 Activie Record 使用 explain ， 能打印出SQL

~~~ ruby
User.where(:id => 1).joins(:posts).explain
User.where(:id => 1).includes(:posts).explain
~~~

### 获取 header，request.env

request.env['HTTP_ACCEPT_LANGUAGE']  # 获取 Accept-Language

### View 里面打印调试

#### debug

<%= debug @post %>

#### inspect

<%= [1, 2, 3, 4, 5].inspect %>

### Logger

The available log levels are: `:debug, :info, :warn, :error, and :fatal, `
corresponding to the log level numbers from 0 up to 4 respectively.

The **default** Rails log level is `info` in production mode and `debug` in development and test mode.

#### 如何配置

~~~ ruby
config.log_level = :warn # In any environment initializer, or
Rails.logger.level = 0 # at any time
~~~

### 写日志

~~~ ruby
logger.debug "Person attributes hash: #{@person.attributes.inspect}"
logger.info "Processing the request..."
logger.fatal "Terminating application, raised unrecoverable error!!!"
~~~