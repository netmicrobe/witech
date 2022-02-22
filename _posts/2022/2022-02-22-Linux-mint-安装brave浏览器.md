---
layout: post
title: Linux-mint-安装brave浏览器
categories: [cm, linux]
tags: [mint, apt, ubuntu]
---

* 参考： 
  * [Linux Mint安装brave浏览器，以及无法安装的解决方法，Ubuntu也同样适用](http://www.goodcms8.com/1972/)
  * [How To Install Brave Browser on Ubuntu 22.04|20.04|18.04](https://computingforgeeks.com/install-brave-web-browser-on-ubuntu-linux/)
  * []()


### 安装步骤

~~~bash
sudo apt update
sudo apt -y install curl software-properties-common apt-transport-https 

curl https://brave-browser-apt-release.s3.brave.com/brave-core.asc| gpg --dearmor > brave-core.gpg
sudo install -o root -g root -m 644 brave-core.gpg /etc/apt/trusted.gpg.d/

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt install brave-browser

# 安装完成，启动
brave-browser
~~~


### 安装失败： brave-browser-apt-release.s3.brave.com 连接不上

~~~
Failed to fetch https://brave-browser-apt-release.s3.brave.com/dists/stable/InRelease  Could not connect to brave-browser-apt-release.s3.brave.com:443 (31.13.71.19), connection timed out
~~~

* 解决办法

1. 访问在线ping工具 <https://www.wepcc.com> ， 输入域名 `brave-browser-apt-release.s3.brave.com` ，找到解析速度最快的IP
1. 配置 本地hosts 或者 路由器 `/etc/hosts`











