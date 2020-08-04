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



