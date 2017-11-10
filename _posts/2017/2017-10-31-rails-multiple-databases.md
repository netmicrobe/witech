---
layout: post
title: rails 连接多个数据库 / multiple databases
categories: [dev, ruby]
tags: [rails, ruby, active-record]
---

* refer to
  * <http://api.rubyonrails.org/classes/ActiveRecord/Base.html>


>### Connection to multiple databases in different models
>
>Connections are usually created through `ActiveRecord::Base.establish_connection` and retrieved by `ActiveRecord::Base.connection`. All classes inheriting from `ActiveRecord::Base` will use this connection. But you can also set a class-specific connection. For example, if Course is an `ActiveRecord::Base`, but resides in a different database, you can just say Course.establish_connection and Course and all of its subclasses will use this connection instead.
>
>This feature is implemented by keeping a connection pool in `ActiveRecord::Base` that is a hash indexed by the class. If a connection is requested, the `ActiveRecord::Base.retrieve_connection` method will go up the class-hierarchy until a connection is found in the connection pool.

### 例子，redmine 连接 testlink 数据库

~~~ ruby
# app/models/xc_testlink/base_object.rb
module XcTestlink
  #
  # 所有 Testlink model的父类
  # 子类中指明表名： self.table_name = "testplans"
  #
  class BaseObject < ActiveRecord::Base
    self.establish_connection :testlink
    self.abstract_class = true
  end
end
~~~

~~~ ruby
# app/models/xc_testlink/testplan.rb
module XcTestlink
  #
  # Test Plan
  #
  class Testplan < BaseObject
    self.table_name = "testplans"
  end
end
~~~


~~~ yml
config/database.yml
testlink:
  adapter: mysql2
  database: testlink
  host: localhost
  username: testlink
  password: 2013Pwd
  encoding: utf8
~~~



