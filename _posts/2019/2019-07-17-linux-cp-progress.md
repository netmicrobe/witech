---
layout: post
title: Ubuntu cp 拷贝大文件能看到进度
categories: [cm, linux]
tags: [gcp, rsync]
---

* 参考： 
  * [How to show the transfer progress and speed when copying files with cp?](https://askubuntu.com/questions/17275/how-to-show-the-transfer-progress-and-speed-when-copying-files-with-cp)
  * [How can I make a progress bar while copying a directory with cp?
](https://stackoverflow.com/questions/7128575/how-can-i-make-a-progress-bar-while-copying-a-directory-with-cp)


首先，pv对cp命令用不了。可以使用 `gcp` 或 `rsync`

* `gcp` 可以对文件 和 文件夹 拷贝并显示进度

`gcp` 会首先扫描目录结构，在目标目录创建文件夹，所以，如果源目录文件夹比较多，也会花上不少时间，且不会显示进度的，so，耐心等待吧。

~~~
sudo apt-get install gcp
gcp -rv ~/Podcasts /media/Mik2
~~~

* `rsync` 可以对文件 和 文件夹 拷贝并显示进度

~~~
rsync -ah --progress source-file destination-file

rsync -ah --progress source-folder destination-folder
~~~

* 使用 pv 拷贝大文件时显示进度

~~~
pv my_big_file > backup/my_big_file
~~~











