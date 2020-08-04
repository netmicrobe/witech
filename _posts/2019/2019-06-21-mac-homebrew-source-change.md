---
layout: post
title: mac os homebrew 国内源设置
categories: [cm, mac]
tags: []
---

* 参考： 
  * [Mac下更换Homebrew镜像源](https://blog.csdn.net/lwplwf/article/details/79097565)
  * [Homebrew Cask 源使用帮助](https://mirrors.ustc.edu.cn/help/homebrew-cask.git.html)




## UTSC 中科大源

~~~
# 替换brew.git
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git


# 替换homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

cd
brew update


# Cask 源
cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

# Bottles 源
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
~~~



## 默认源

~~~
/usr/local/Homebrew $ git remote -v
origin	https://github.com/Homebrew/brew (fetch)
origin	https://github.com/Homebrew/brew (push)

/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core $ git remote -v
origin	https://github.com/Homebrew/homebrew-core (fetch)
origin	https://github.com/Homebrew/homebrew-core (push)

#  cask 默认源
/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask $ git remote -v
origin	https://github.com/Homebrew/homebrew-cask (fetch)
origin	https://github.com/Homebrew/homebrew-cask (push)
~~~









