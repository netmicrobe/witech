---
layout: post
title: 安装Go
categories: [ dev, golang ]
tags: [ golang, centos ]
---

* 参考
  * <https://golang.org/project/>

## Binary Distributions

Official binary distributions are available at <https://golang.org/dl/>.

After downloading a binary release, visit <https://golang.org/doc/install> or load doc/install.html in your web browser for installation instructions.

1. `tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz`
2. Add /usr/local/go/bin to the PATH environment variable.
     adding this line to your /etc/profile (for a system-wide installation) or $HOME/.profile:
     ~~~
     export PATH=$PATH:/usr/local/go/bin
     ~~~
3. 设置环境变量：

    在 /etc/profile 添加：
    ~~~
    export GOROOT=/usr/local/go 
    export GOBIN=$GOROOT/bin
    export GOPKG=$GOROOT/pkg/tool/linux_amd64 
    export GOARCH=amd64
    export GOOS=linux
    export GOPATH=$HOME/workspace/go
    export PATH=$PATH:$GOBIN:$GOPKG:${GOPATH//://bin:}/bin
    ~~~


## Installing Go from source

<https://golang.org/doc/install/source>




