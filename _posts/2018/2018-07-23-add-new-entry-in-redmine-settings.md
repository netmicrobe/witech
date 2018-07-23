---
layout: post
title: 添加新设置到Redmine管理界面
date: 2018-07-23 11:40:18 +0800
categories: [ dev, ruby ]
tags: [redmine, rails]
---

修改 lib/redmine.rb

~~~ ruby
Redmine::MenuManager.map :admin_menu do |menu|
  ... ...
  menu.push :info, {:controller => 'admin', :action => 'info'}, :caption => :label_information_plural, :last => true
  
  # 添加新的连接到系统管理菜单
  menu.push :your_new_feature, {:controller => 'your_new_feature', :action => 'index'}, :caption => '新的功能设置'
end
~~~

* 效果如下：
  * ![](settings.png)


