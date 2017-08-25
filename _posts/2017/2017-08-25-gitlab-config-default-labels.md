---
layout: post
title: 如何配置gitlab自动生成哪些label
categories: [cm, gitlab]
tags: [gitlab, label, ruby]
---

* 参考： <https://gitlab.com/gitlab-org/gitlab-ce/issues/718>

### 问题

gitlab 中 some-project > Issues > Labels > "Generate a default set of labels"

点击可以生成一系列的label

如何自定义这些 labels 呢？

### 解决

1.  修改 gitlab/lib/gitlab/issues_labels.rb
    在 labels 数组里面新增就好拉！
   
    ~~~ ruby
    module Gitlab
      class IssuesLabels
        class << self
          def generate(project)
            red = '#d9534f'
            yellow = '#f0ad4e'
            blue = '#428bca'
            green = '#5cb85c'

            labels = [
              { title: "bug", color: red },
              { title: "critical", color: red },
              { title: "confirmed", color: red },
              { title: "documentation", color: yellow },
              { title: "support", color: yellow },
              { title: "discussion", color: blue },
              { title: "suggestion", color: blue },
              { title: "enhancement", color: green },
              
              # 新增
              
              { title: "Doing", color: green },
              { title: "To Do", color: yellow },
              { title: "Story", color: "#428BCA", description: "scrume story，新功能" },
              { title: "No-Bug", color: "#D10069", description: "测试搞错，非Bug" },
              { title: "对外接口", color: "#5CB85C" }
            ]

            labels.each do |params|
              ::Labels::FindOrCreateService.new(nil, project, params).execute(skip_authorization: true)
            end
          end
        end
      end
    end

    ~~~

2.  重启 gitlab，`service gitlab restart`

