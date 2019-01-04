---
layout: post
title: Gitlab上关闭artifacts功能
categories: [ cm, git ]
tags: [gitlab, artifacts]
---

* 参考
  * [Introduction to build artifacts](https://git.scity.cn/help/ci/build_artifacts/README.md)
  * [Introduction to job artifacts ](https://docs.gitlab.com/ee/user/project/pipelines/job_artifacts.html)
  * [gitlab-ci配置详解(二)](https://segmentfault.com/a/1190000011890710)


## Disabling build artifacts

这样直接关闭了artifacts功能，导致一些依赖artifacts 的 ci 无法成功执行，upload出错。

### To disable artifacts site-wide, follow the steps below.

#### In Omnibus installations:

Edit /etc/gitlab/gitlab.rb and add the following line:

~~~
gitlab_rails['artifacts_enabled'] = false
~~~

Save the file and reconfigure GitLab for the changes to take effect.

#### In installations from source:

Edit /home/git/gitlab/config/gitlab.yml and add or amend the following lines:

~~~
artifacts:
  enabled: false
~~~

Save the file and restart GitLab for the changes to take effect.

## 设置artifacts的过期时间

可以通过在设置文件（`.gitlab-ci.yml` ）中将过期时间缩短，来减少artifacts占用的服务器磁盘空间。

~~~
pages:
  stage: deploy
  script:
  - bundle exec jekyll build -d public --config _config.yml,_config_product.yml
  artifacts:
    paths:
    - public
    expire_in: "1 min"
  only:
  - master
~~~




