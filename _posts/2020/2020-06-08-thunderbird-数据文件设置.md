---
layout: post
title: thunderbird-数据文件设置，修改profile location
categories: [cm, mail]
tags: [mail, thunderbird]
---

* 参考： 
  * [Profiles - Where Thunderbird stores your messages and other user data](https://support.mozilla.org/en-US/kb/profiles-where-thunderbird-stores-user-data)
  * [Using Multiple Profiles](https://support.mozilla.org/en-US/kb/using-multiple-profiles)
  * [Moving Thunderbird Data to a New Computer](https://support.mozilla.org/en-US/kb/moving-thunderbird-data-to-a-new-computer)
  * []()



## 找到当前使用的 Profile

程序菜单 \> Help \> More Troubleshoot Information \> Profile Folder



## 移动 thunderbird 的 个人配置文件 / Profiles

1. 安装thunderbird
1. 移动thunderbird 的 个人配置文件（包含邮件数据）
    * Windows
      1. 关闭thunderbird
      1. 将 `C:\Users\your-name\AppData\Roaming\Thunderbird`的 `Profiles` 文件夹拷贝到需要的目录。
      1. `default` 和 `default-release` 2个Profile都要移走。 后面邮件都保存在 `default-release`
      1. `C:\Users\your-name\AppData\Roaming\Thunderbird\profiles.ini` 
          1. 修改 `profile？` 的 `Path=` 到新的文件夹位置。 
          1. 使用绝对路径，要将 `IsRelative=1` 改为 `IsRelative=0`. 
    * Linux
      linux版本的配置文件位置： `~/.thunderbird/` ，其他步骤参照windows版本




## 管理多个Profiles

* Starting the Profile Manager
  `thunderbird -ProfileManager`

## 启动时指定 profiles 的位置

`-profile "path" `

~~~
"F:\Mozilla Thunderbird\thunderbird.exe" -profile "F:\My TB profile"
~~~


