---
layout: post
title: rails开发 之 active record
categories: [ dev, ruby ]
tags: [activerecord, rails]
---


* 参考
  * []()
  * []()
  * []()



### How to use new_record?, changed? and persisted? methods in rails in this example

参考： <https://stackoverflow.com/a/50512456>

~~~ruby
# new_record?

car = Car.new # => initialize a new Car object
Car.new_record? # => true

# persisted?

car.save
car.persisted? # => true

# changed?

car.model = 'New release model S'
car.changed? # => true

# destroyed?

car.destroy
car.destroyed? # => true
~~~















