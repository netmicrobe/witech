---
layout: post
title: 使用 shell script 脚本批量 fetch 多个 git repo
categories: [cm, git ]
tags: [linux, shell, script, git ]
---


~~~ shell
#!/bin/bash

function update_repo() {
  local REPO_NAME=$1
  echo "--- --- --- --- "
  echo "--- --- REPO : "$REPO_NAME " --- --- "
  if [ -d $REPO_NAME ]; then
    cd $REPO_NAME
    for BRANCH in `git branch --list master --list daxuancai | cut -c 3-`
    do
      git fetch origin $BRANCH
    done
    cd $BASE_DIR
  fi
}



BASE_DIR=`pwd`
echo $BASE_DIR
for REPO_NAME in `find . -maxdepth 2 -mindepth 2 | cut -d '/' -f 2-`
do
  update_repo $REPO_NAME
done


~~~


