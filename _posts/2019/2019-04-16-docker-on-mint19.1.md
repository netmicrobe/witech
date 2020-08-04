---
layout: post
title: linux mint 19.1 上使用docker
categories: [cm, linux]
tags: [docker]
---

* 参考： 
  * [Get Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
  * [Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/)
  * []()



## 安装&配置 Docker

1. SET UP THE REPOSITORY
    ~~~
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # 注意使用bionic（ubuntu18.04.2）而不是 tessa（mint 19.1）
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    ~~~

1. INSTALL DOCKER CE
    ~~~
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    ~~~
    * 安装指定版本docker
      ~~~
      # List the versions available in your repo:
      apt-cache madison docker-ce
      # Install a specific version using the version string from the second column
      sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
      ~~~

1. 测试是否安装成功
    ~~~
    sudo docker run hello-world
    ~~~


### 非root用户使用docker命令

* The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can only access it using sudo

* If you don’t want to preface the docker command with sudo, create a Unix group called docker and add users to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

1. Create the `docker` group. `sudo groupadd docker`
1. Add your user to the `docker` group. `sudo usermod -aG docker $USER`
1. 注销后登录。
1. 试哈 `docker run hello-world`


### 配置自动启动

~~~
# 自启动
sudo systemctl enable docker

# 关闭自启动
sudo systemctl disable docker
~~~






















