---
layout: post
title: ruby meta-programming / 元编程
categories: [dev, ruby]
tags: [ruby, meta-programing]
---

## Module

### Module#constants & Module.constants

~~~ ruby
Y = 'a root-level constant'

module M
  Y = 'a constant in M'
  Y    # => "a constant in M"
  ::Y  # => "a root-level constant"

  class C
    X = 'a constant'
  end
end

M::C::X # => "a constant"


M.constants                          # => [:C, :Y]
Module.constants.include? :Object    # => true
Module.constants.include? :Module    # => true
~~~

### Module#nesting

if you need the current path, check out Module.nesting:

~~~ ruby
module M
  class C
    module M2
      Module.nesting    # => [M::C::M2, M::C, M]
    end
  end
end

~~~


## Class 

### classes themselves are nothing but objects.

~~~ ruby
"hello".class    # => String
String.class     # => Class
~~~

the methods of a class are the instance methods of Class.

~~~ ruby
# The "false" argument here means: ignore inherited methods
Class.instance_methods(false)   # => [:allocate, :new, :superclass]
~~~



### class names are nothing but constants

Any reference that begins with an uppercase letter, including the names of
classes and modules, is a constant. 




### Class#superclass

~~~ ruby
Array.superclass          # => Object
Object.superclass         # => BasicObject
BasicObject.superclass    # => nil
~~~

#### The superclass of Class is Module

~~~ ruby
Class.superclass    # => Module
~~~

### class 关系 vs 继承关系

![](classes-are-just-objects.png)

### 已有的Class，可以打开，重新定义；Open Class

~~~ ruby
class String
  def to_alphanumeric
    gsub(/[^\w\s]/, '')
  end
end
~~~

#### 注意：打开类后，定义新方法，与已有的方法同名，老方法被覆盖！ 这种事，被称为 _Monkeypatch_
{: style="color: red"}


### refine , 可控的 MonkeyPatch

从 Ruby 2 开始，支持 Refinement 方式，在有限范围内覆盖类的同名方法。

~~~ ruby
module StringExtensions
  refine String do
    def reverse
      "esrever"
    end
  end
end

module StringStuff
  using StringExtensions
  "my_string".reverse # => "esrever"
end

"my_string".reverse # => "gnirts_ym"
~~~

#### 谨慎使用refine，其作为实验功能加入 Ruby 2，后面可能还有调整。
{: style="color: red"}

#### refine 不太合常规的用法

~~~ ruby
class MyClass
  def my_method
    "original my_method()"
  end
  def another_method
    my_method
  end
end

module MyClassRefinement
  refine MyClass do
    def my_method
      "refined my_method()"
    end
  end
end

using MyClassRefinement
MyClass.new.my_method # => "refined my_method()"
MyClass.new.another_method # => "original my_method()"
~~~




### Class 定义内部，可以直接写代码执行

>何时执行不知道，加载Class定义的时候？

~~~ ruby
class MyClass
  puts 'Hello!'
end
⇒ Hello!
~~~

### Class 定义，有返回值，和函数一样，是最后一个语句的返回值

~~~ ruby
result = class MyClass
  self
end

result # => MyClass
~~~


### self 在 Class 定义中，指代类本身

~~~ ruby
class MyClass
  self  # => MyClass
end
~~~

### class_eval() ；不知道类名时，打开类

`Module#class_eval()` 或 `module_eval( )` evaluates a block in the context of an existing class.

~~~ ruby
def add_method_to(a_class)
  a_class.class_eval do
    def m; 'Hello!' ; end
  end
end

add_method_to String
"abc".m
# => "Hello!"
~~~











## Object（对象）相关 meta

What’s an object? It’s a bunch of instance variables, plus a link to a class.

### object.class 返回所属Class 的 meta类

~~~ ruby
class MyClass
  def my_method
    @v = 1
  end
end
obj = MyClass.new
obj.class    # => MyClass
~~~



### object.instance_variables 列出所有对象属性

~~~ ruby
# 在类定义中出现过的属性，不会在对象创建时，就被分配。
# 运行到属性出现的地方，该对象才会有该属性。
# 同一个类的对象，属性列表未必会完全相同。
#
# 例如，下面例子，不执行 my_method ，@v 不会被分配
#
obj.instance_variables    # => []

obj.my_method
obj.instance_variables    # => [:@v]
~~~




### object.methods ，实例方法，instance_methods

The methods of an object are also the instance methods of its class. 

#### 实例方法不同于类方法

~~~ ruby
String.instance_methods == "abc".methods  # => true
String.methods == "abc".methods           # => false
~~~

#### methods 会返回很多方法，可以用如下方法来查找。

~~~ ruby
obj.methods.grep(/my/)    # => [:my_method]
~~~

![](iv-in-obj-methods-in-class.png)


### instance_variable_set

~~~ ruby
obj3.instance_variable_set("@x", 10)
~~~





## self

Every line of Ruby code is executed inside an object, the so-called _current object_. 

The _current object_ is also known as **self**, because you can access it with the `self` keyword.

* Only one object can take the role of self at a given time, but no object holds
that role for a long time.
* when you call a method, the receiver becomes self.


###　在对象外面的 self ， The Top Level

什么的 **main** 对象，又Ruby 解释器创建，被称为 **top-level context**

~~~ ruby
self         # => main
self.class   # => Object
~~~

### Class Definitions and self

类定义中的 self ， 是类对象本身。

~~~ ruby
class MyClass
  self         # => MyClass
end
~~~










## OOP

### receiver

The **receiver** is the object that you call a method on.

### ancestors chain 

ancestors 包含 Module，而非 ，如下例：Kernel 是 Module，而非 Class

~~~ ruby
MySubclass.ancestors # => [MySubclass, MyClass, Object, Kernel, BasicObject]
~~~

~~~ ruby
module M1
  def my_method
    'M1#my_method()'
  end
end

class C
  include M1
end

class D < C; end

D.ancestors # => [D, C, M1, Object, Kernel, BasicObject]
~~~

### include & prepend

~~~ ruby
class C2
  prepend M2
end

class D2 < C2; end

# 不同于 include 将 包含进来的Module 放在自己和父类直接；
# prepend 将 包含进来的Module 放在自己和子类之间。
D2.ancestors # => [D2, M2, C2, Object, Kernel, BasicObject]
~~~

### 重复include / Multiple inclusions

if that module is already in the chain, Ruby silently ignores the second inclusion.

~~~ ruby
module M1; end
module M2
  include M1
end
module M3
  prepend M1
  include M2
end

# M3 prepends M1 and then includes M2. 
# When M2 also includes M1, that include has no effect,
# because M1 is already in the chain of ancestors. 

M3.ancestors # => [M1, M3, M2]
~~~







## method


When you call a method, Ruby does two things:

1. It finds the method. This is a process called **method lookup**.
    * **method lookup** : to find a method, Ruby goes in the receiver’s class, and from there it climbs the ancestors chain until it finds the method. 

2. It executes the method. To do that, Ruby needs something called **self**.


### `send` , Dynamically calling methods

with `send` , the name of the method that you want to call becomes just a regular
argument. You can wait literally until the very last moment to decide which
method to call, while the code is running. 

This technique is called **Dynamic Dispatch** .

~~~ ruby
# gems/pry-0.9.12.2/lib/pry/pry_instance.rb
def refresh(options={})
  defaults = {}
  attributes = [ :input, :output, :commands, :print, :quiet,
                 :exception_handler, :hooks, :custom_completions,
                 :prompt, :memory_size, :extra_sticky_locals ]
  attributes.each do |attribute|
    defaults[attribute] = Pry.send attribute
  end
  # ...
  defaults.merge!(options).each do |key, value|
    send("#{key}=", value) if respond_to?("#{key}=")
  end
  
  true
end
~~~

#### `send` 可以调用任何 method，包括私有method。要保持封装性，使用 `send_public`


### `define_method`, Defining Methods Dynamically

`Module#define_method` 用来动态定义method。

~~~ ruby
class MyClass
  define_method :my_method do |my_arg|
    my_arg * 3
  end
end
obj = MyClass.new
obj.my_method(2) # => 6
~~~

~~~ ruby
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end
  
  def self.define_component(name)
    define_method(name) do
      info = @data_source.send "get_#{name}_info", @id
      price = @data_source.send "get_#{name}_price", @id
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

  define_component :mouse
  define_component :cpu
  define_component :keyboard
end

# 进化
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
➤   data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end
  def self.define_component(name)
    define_method(name) do
    # ...
    end
  end
end
~~~


### `BasicObject#method_missing` 无此方法时的处理

ruby 没有编译器，运行时才会知道对象的 method 是否存在。

调用的 method 不存在时，会继续调用 `BasicObject.method_missing`

~~~ ruby
class Lawyer; end
nick = Lawyer.new
nick.talk_simple
➤ NoMethodError: undefined method `talk_simple' for #<Lawyer:0x007f801aa81938>
~~~

~~~ ruby
nick.send :method_missing, :my_method
➤ NoMethodError: undefined method `my_method' for #<Lawyer:0x007f801b0f4978>
~~~


#### Overriding method_missing

~~~ ruby
class Lawyer
  def method_missing(method, *args)
    puts "You called: #{method}(#{args.join(', ')})"
    puts "(You also passed it a block)" if block_given?
  end
end

bob = Lawyer.new
bob.talk_simple('a', 'b') do
# a block
end

➤ You called: talk_simple(a, b)
(You also passed it a block)
~~~



#### Ghost Methods ，幽灵方法

>From the caller’s side, a message that’s processed by method_missing looks like
>a regular call—but on the receiver’s side, it has no corresponding method.
>This trick is called a **Ghost Method**.

##### The Hashie Example

就像Ruby变量一样， Hashie::Mash（包含在Hashie gem） 对象属性不存在，依然可以赋值。

~~~ ruby
require 'hashie'
icecream = Hashie::Mash.new
icecream.flavor = "strawberry"
icecream.flavor # => "strawberry"
~~~

关键在 Hashie::Mash.method_missing 的实现。

~~~ ruby
# gems/hashie-1.2.0/lib/hashie/mash.rb
module Hashie
  class Mash < Hashie::Hash
    def method_missing(method_name, *args, &blk)
      return self.[](method_name, &blk) if key?(method_name)
      match = method_name.to_s.match(/(.*?)([?=!]?)$/)
      case match[2]
      when "="
        self[match[1]] = args.first
        # ...
      else
        default(method_name, *args, &blk)
      end
    end
    # ...
  end
end
~~~



#### Dynamic Proxies

##### Ghee的例子

~~~ ruby
# gems/ghee-0.9.8/lib/ghee/resource_proxy.rb
class Ghee
  class ResourceProxy
    # ...
    def method_missing(message, *args, &block)
      subject.send(message, *args, &block)
    end
    def subject
      @subject ||= connection.get(path_prefix){|req| req.params.merge!params }.body
    end
  end
end

# gems/ghee-0.9.8/lib/ghee/api/gists.rb
class Ghee
  module API
    module Gists
      class Proxy < ::Ghee::ResourceProxy
        def star
          connection.put("#{path_prefix}/star").status == 204
        end
        # ...
      end
    end
  end
end
~~~

~~~ ruby
require "ghee"
gh = Ghee.basic_auth("usr", "pwd") # Your GitHub username and password
all_gists = gh.users("nusco").gists
a_gist = all_gists[20]

# url, description 都是 Ghost Methods
a_gist.url # => "https://api.github.com/gists/535077"
a_gist.description # => "Spell: Dynamic Proxy"

a_gist.star
~~~





#### Refactoring the Computer Class

~~~ ruby
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end
➤ def method_missing(name)
➤   # If it doesn’t have one, the call falls back to BasicObject#method_missing
➤   super if !@data_source.respond_to?("get_#{name}_info")
➤   info = @data_source.send("get_#{name}_info", @id)
➤   price = @data_source.send("get_#{name}_price", @id)
➤   result = "#{name.capitalize}: #{info} ($#{price})"
➤   return "* #{result}" if price >= 100
➤   result
➤ end
end
~~~


#### respond_to_missing?

如果对 Ghost method 调用 respond_to? ，会返回false， 人家可不管幽灵，除非你重写了 respond_to_missing? 方法。

~~~ ruby
class Computer
  # ...
➤ def respond_to_missing?(method, include_private = false)
➤   # In this case, super is the default Object#respond_to_missing?
➤   # which always returns false.
➤   @data_source.respond_to?("get_#{method}_info") || super
➤ end
end
~~~

##### 所以注意：如果重写 `method_missing`，别忘了也重写 `respond_to_missing?`
{: style="color:red"}






















## library

You use load to execute code, and you use require to import libraries.

require tries only once to load each file, while load executes the file again every time you call it.


### The Kernel Module

class Object includes Kernel, so Kernel gets into every object’s
ancestors chain.

~~~ ruby
# 每个对象都有 print* 方法
Kernel.private_instance_methods.grep(/^pri/) # => [:printf, :print]
~~~






































































