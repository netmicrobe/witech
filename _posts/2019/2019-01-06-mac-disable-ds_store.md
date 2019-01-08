---
layout: post
title: 禁止mac 创建 .DS_Store 文件
categories: [ cm, mac ]
tags: []
---


* 参考
  * <http://osxdaily.com/2010/02/03/how-to-prevent-ds_store-file-creation/>
  * <https://apple.stackexchange.com/a/340587>
  * <https://wsgzao.github.io/post/macbook/#%E7%A6%81%E6%AD%A2-DS-store-%E7%94%9F%E6%88%90>


There's no built-in functionality in macOS to stop the creation of .DS_Store files in a specific folder and its subfolders. There's a setting to stop the creation on networked volumes (i.e. folders that really are network shares).

mac os 没有设置可以完全禁止 `.DS_Store` 生成，真好用的系统！！

## mac os 提供设置 `com.apple.desktopservices DSDontWriteNetworkStores`，仅对网络映射磁盘可以禁止 `.DS_Store` 生成

~~~
# 禁止 .DS_store 生成，打开“终端”，复制黏贴下面的命令，回车执行，重启 Mac 即可生效。
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
# 恢复 .DS_store 生成
defaults delete com.apple.desktopservices DSDontWriteNetworkStores
# 刪除已存在的. DS_Store
sudo find . -name ".DS_Store" -depth -exec rm {} \;
~~~

## 第三方工具可以禁止 `.DS_Store` 生成

### asepsis

Asepsis 针对 Mojave 的一个fork： <https://github.com/JK3Y/asepsis>
目前，只能支持 macOS < 10.13

* 安装

~~~
git clone https://github.com/JK3Y/asepsis.git
cd asepsis
rake build
rake install
sudo reboot
~~~

build 成功 , rake install 失败，报错如下：

~~~
failed with code pid 743 exit 1
> "/Library/Application Support/Asepsis/ctl/asepsisctl" install_updater
> sudo cp "/Library/Application Support/Asepsis/com.binaryage.asepsis.updater.plist" "/Library/LaunchAgents/com.binaryage.asepsis.updater.plist"
Asepsis installation encountered some failures, please inspect the command output.
~~~

* 卸载

~~~
asepsisctl uninstall
~~~



