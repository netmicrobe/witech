---
layout: post
title: Linux-mint-安装vivaldi浏览器.md
categories: [cm, linux]
tags: [mint, apt, ubuntu, debian]
---

* 参考： 
  * [Install Vivaldi Web Browser on Ubuntu / Debian Linux](https://computingforgeeks.com/install-vivaldi-web-browser-on-ubuntu-debian-linux/)
  * []()
  * []()


### 安装步骤

~~~bash
sudo apt update
sudo apt -y install wget gnupg2 software-properties-common
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -

echo 'deb [arch=amd64] https://repo.vivaldi.com/archive/deb/ stable main' | sudo tee /etc/apt/sources.list.d/vivaldi.list
sudo apt update
sudo apt install vivaldi-stable
~~~











