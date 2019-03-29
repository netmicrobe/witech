---
layout: post
title: 批量备份git库的脚本
categories: [cm, git]
tags: [script]
---

* 参考： 
  * []()
  * []()



### 枚举型备份

~~~ shell
#!/bin/bash

function update_repo() {
  local REPO_NAME=$1
  echo "--- --- --- --- "
  echo "--- --- REPO : "$REPO_NAME " --- --- "
  if [ -d $REPO_NAME".git" ]; then
    cd $REPO_NAME".git"
    git fetch --all
    cd ..
  else
    git clone --bare ssh://your-name@192.168.0.1:22/$REPO_NAME
  fi
}

update_repo project-01
update_repo project-02
update_repo project-03
~~~



































