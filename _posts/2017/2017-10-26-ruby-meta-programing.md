---
layout: post
title: ruby meta-programming / 元编程
categories: [dev, ruby]
tags: [ruby, meta-programing]
---

### Module

#### Module#constants & Module.constants

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

#### Module#nesting

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


### Class 

#### classes themselves are nothing but objects.

~~~ ruby
"hello".class    # => String
String.class     # => Class
~~~

the methods of a class are the instance methods of Class.

~~~ ruby
# The "false" argument here means: ignore inherited methods
Class.instance_methods(false)   # => [:allocate, :new, :superclass]
~~~



#### class names are nothing but constants

Any reference that begins with an uppercase letter, including the names of
classes and modules, is a constant. 




#### Class#superclass

~~~ ruby
Array.superclass          # => Object
Object.superclass         # => BasicObject
BasicObject.superclass    # => nil
~~~

##### The superclass of Class is Module

~~~ ruby
Class.superclass    # => Module
~~~

#### class 关系 vs 继承关系

![](classes-are-just-objects.png)

#### 已有的Class，可以打开，重新定义；Open Class

~~~ ruby
class String
  def to_alphanumeric
    gsub(/[^\w\s]/, '')
  end
end
~~~

##### 注意：打开类后，定义新方法，与已有的方法同名，老方法被覆盖！ 这种事，被称为 _Monkeypatch_
{: style="color: red"}

#### Class 定义内部，可以直接写代码执行

>何时执行不知道，加载Class定义的时候？

~~~ ruby
class MyClass
  puts 'Hello!'
end
⇒ Hello!
~~~

#### Class 定义，有返回值，和函数一样，是最后一个语句的返回值

~~~ ruby
result = class MyClass
  self
end

result # => MyClass
~~~


#### self 在 Class 定义中，指代类本身

~~~ ruby
class MyClass
  self  # => MyClass
end
~~~

#### class_eval() ；不知道类名时，打开类

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











### Object（对象）相关 meta

What’s an object? It’s a bunch of instance variables, plus a link to a class.

#### object.class 返回所属Class 的 meta类

~~~ ruby
class MyClass
  def my_method
    @v = 1
  end
end
obj = MyClass.new
obj.class    # => MyClass
~~~



#### object.instance_variables 列出所有对象属性

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




#### object.methods ，实例方法，instance_methods

The methods of an object are also the instance methods of its class. 

##### 实例方法不同于类方法

~~~ ruby
String.instance_methods == "abc".methods  # => true
String.methods == "abc".methods           # => false
~~~

##### methods 会返回很多方法，可以用如下方法来查找。

~~~ ruby
obj.methods.grep(/my/)    # => [:my_method]
~~~

![](iv-in-obj-methods-in-class.png)


#### instance_variable_set

~~~ ruby
obj3.instance_variable_set("@x", 10)
~~~





### self

Every line of Ruby code is executed inside an object, the so-called _current object_. 

The _current object_ is also known as **self**, because you can access it with the `self` keyword.

* Only one object can take the role of self at a given time, but no object holds
that role for a long time.
* when you call a method, the receiver becomes self.


####　在对象外面的 self ， The Top Level

什么的 **main** 对象，又Ruby 解释器创建，被称为 **top-level context**

~~~ ruby
self         # => main
self.class   # => Object
~~~

#### Class Definitions and self

类定义中的 self ， 是类对象本身。

~~~ ruby
class MyClass
  self         # => MyClass
end
~~~










### OOP

#### receiver

The **receiver** is the object that you call a method on.

#### ancestors chain 

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

#### include & prepend

~~~ ruby
class C2
  prepend M2
end

class D2 < C2; end

# 不同于 include 将 包含进来的Module 放在自己和父类直接；
# prepend 将 包含进来的Module 放在自己和子类之间。
D2.ancestors # => [D2, M2, C2, Object, Kernel, BasicObject]
~~~

#### 重复include / Multiple inclusions

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







### method


When you call a method, Ruby does two things:

1. It finds the method. This is a process called **method lookup**.
    * **method lookup** : to find a method, Ruby goes in the receiver’s class, and from there it climbs the ancestors chain until it finds the method. 

2. It executes the method. To do that, Ruby needs something called **self**.






### library

You use load to execute code, and you use require to import libraries.

require tries only once to load each file, while load executes the file again every time you call it.


#### The Kernel Module

class Object includes Kernel, so Kernel gets into every object’s
ancestors chain.

~~~ ruby
# 每个对象都有 print* 方法
Kernel.private_instance_methods.grep(/^pri/) # => [:printf, :print]
~~~






































































