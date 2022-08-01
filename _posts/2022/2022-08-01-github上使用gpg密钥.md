---
layout: post
title: github上使用gpg密钥，关联 GnuPG, git
categories: [ cm ]
tags: []
---

* 参考
  * [无辄的栈 - 在Github上使用GPG的全过程](https://www.zackwu.com/posts/2019-08-04-how-to-use-gpg-on-github/)
  * []()


### 生成 GPG 密钥

~~~sh
# 查看GnuPG版本，我的版本是 2.2.36
gpg --version

# 生成密钥
# 按提示输入信息，注意邮箱要和github上一致
gpg --full-generate-key

# 生成后，记下密钥ID
~~~

如果没记下，可以使用如下命令查看

~~~sh
gpg --list-keys

# some output is omitted here
pub   rsa2048 2019-08-04 [SC] [expires: 2021-08-03]
      1BA074F113915706D141348CDC3DB5873563E6B2
uid           [ultimate] fortest <test@test.com>
sub   rsa2048 2019-08-04 [E] [expires: 2021-08-03]
~~~

* `pub`其后的是该密钥的公钥特征，包括了密钥的参数（加密算法是rsa，长度为2048，生成于2019-08-04，用途是Signing和Certificating，一年之后过期）以及密钥的ID。
* `uid`其后的是生成密钥时所输入的个人信息。
* `sub`其后的则是该密钥的子密钥特征，格式和公钥部分大致相同（E表示用途是Encrypting）。


### 关联GPG公钥与Github账户

根据密钥ID来导出对应GPG密钥的公钥字符串

~~~sh
gpg --armor --export {密钥ID}
~~~

然后将生成的公钥字符串，填入 Github，Settings 》SSH And GPG keys 》 New GPG key


### 利用GPG私钥对Git commit进行签名

首先，需要让Git知道签名所用的GPG密钥ID：

~~~sh
git config --global user.signingkey {密钥ID}
~~~

然后，在每次commit的时候，加上`-S`参数，表示这次提交需要用GPG密钥进行签名：

~~~sh
git commit -S -m "..."
~~~

如果觉得每次都需要手动加上-S有些麻烦，可以设置Git为每次commit自动要求签名：

~~~sh
git config --global commit.gpgsign true
~~~

但不论是否需要手动加上-S，commit时皆会弹出对话框，需要输入该密钥的密码，以确保是密钥拥有者本人操作。



### gpg: Can't check signature: No public key

比如 ， github 上建立的库，初始commit是Github代为签名。

clone 到本地，这个commit就会显示 `gpg: Can't check signature: No public key`

解决方法：

导入 导入并信任Github所用的GPG密钥。

~~~sh
curl https://github.com/web-flow.gpg | gpg --import
# curl's output is omitted
gpg: key 4AEE18F83AFDEB23: public key "GitHub (web-flow commit signing) <noreply@github.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
~~~

然后是信任（用自己的密钥为其签名验证，需要输入密码）：

~~~sh
gpg --sign-key 4AEE18F83AFDEB23
~~~











