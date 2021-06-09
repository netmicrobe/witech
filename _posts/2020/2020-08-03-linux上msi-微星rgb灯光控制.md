---
layout: post
title: linux上msi-微星rgb灯光控制
categories: [cm, linux]
tags: []
---

* 参考： 
  * []()
  * []()



## msi-rgb 微星主板灯光控制

源码网站： <https://github.com/nagisa/msi-rgb>
用 rust 语言开发。



### manjaro

~~~
yay -S msi-rgb

# shut down led on motherboard
sudo msi-rgb 00000000 ffffffff 00000000 -x
~~~


### ubuntu

~~~
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# 或
sudo apt install rustc

# 检查 rust 安装情况
rustc --version
~~~

~~~
# 安装 cargo
sudo apt install cargo
cargo --version
~~~

~~~
# 编译 msi-rgb
git clone https://github.com/nagisa/msi-rgb
cd msi-rgb
cargo build --release

./target/release/msi-rgb -h


# 关闭b450m mortar主板的等效
sudo ./target/release/msi-rgb 00000000 ffffffff 00000000 -x
~~~



## 设置成开机自启动

### systemd

1. 创建脚本 `vi ~/bin/close-msi-motherboard-led.sh`
    ~~~
    #!/bin/bash
    echo "关闭微星主板LED"
    msi-rgb 00000000 ffffffff 00000000 -x
    ~~~

1. 创建sevice 文件 `sudo vi /usr/lib/systemd/system/msi-led-close.service`

    ~~~
    [Unit]
    Description=Close LED on MSI motherboard

    [Service]
    Type=idle
    Restart=no
    RemainAfterExit=false
    User=root
    ExecStart=/home/wi/bin/close-msi-motherboard-led.sh

    [Install]
    WantedBy=multi-user.target 
    ~~~

    * 在 Manjaro KDE 上遇到一次黑屏（桌面、状态条没有了），将 Service 的 Type 从 simple 改为 idle 就好了。


1. 设置开机自启动 `sudo systemctl enable msi-led-close.service`
    检查是否设置成功： 
    * `sudo systemctl enable msi-led-close.service`
    * `ll /etc/systemd/system/multi-user.target.wants/msi-led-close.service`





















