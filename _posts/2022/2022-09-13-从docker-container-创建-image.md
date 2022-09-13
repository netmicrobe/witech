---
layout: post
title: 从docker-container-创建-image，关联 容器，镜像
categories: [ cm ]
tags: []
---

* 参考
  * [How to Create a Docker Image From a Container](https://www.dataset.com/blog/create-docker-image/)
  * [Tutorial: Create a Docker Image from a Running Container](https://thenewstack.io/tutorial-create-a-docker-image-from-a-running-container/)
  * []()
  * []()
  * []()
  * []()



1. 启动基础容器
    `docker create --name nginx_base -p 80:80 nginx:alpine`
1. 查看镜像和容器
    ~~~sh
    docker images -a
    docker ps -a
    ~~~
1. 在容器中修改
1. 从当前容器创建镜像，容器会pause
    ~~~sh
    docker commit --author amit.sharma@sentinelone.com --message 'this is a basic nginx image' nginx_base your-new-image-name
    ~~~
    
    `--author`、`--message` 都是可选的。
1. 
1. 






































































