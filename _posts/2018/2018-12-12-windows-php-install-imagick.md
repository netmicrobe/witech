---
layout: post
title: 在windows 的 xampp/php 上安装 ImageMagick extension
categories: [ cm, php ]
tags: [windows, ImageMagick, imagick]
---

* 参考
  * [Install the ImageMagick PHP extension in Windows](https://mlocati.github.io/articles/php-windows-imagick.html)
  * []()



## ImageMagick 安装版本下载

  * <https://ftp.icm.edu.pl/packages/ImageMagick/binaries/>
  * <https://www.imagemagick.org/download/binaries/>
  * [How to install and enable the Imagick extension in XAMPP for Windows](https://ourcodeworld.com/articles/read/349/how-to-install-and-enable-the-imagick-extension-in-xampp-for-windows)


## 在 xampp-win32-5.6.38-0-VC11 上安装 


### 检查windows上php版本

In order to install the imagick PHP extension on Windows, you need to know the exact version of your PHP. To do this: open a command prompt and enter these commands:

* Determine the PHP version: `php -i|find "PHP Version"`

* Determine the thread safety  `php -i|find "Thread Safety"`
  You’ll have enabled for thread safe or disabled for not thread safe

* Determine the architecture   `php -i|find "Architecture"`
  You’ll have x86 for 32 bits and x64 for 64 bits


### 根据php版本参数，下载对应的 ImageMagick 和 php_imagick 模块

地址：

* <https://mlocati.github.io/articles/php-windows-imagick.html>
* <https://windows.php.net/downloads/pecl/deps/>


### 安装 php_imagick

1. 从`php_imagick-….zip`解压出`php_imagick.dll`，放到`ext`目录
1. 从`ImageMagick-….zip`解压出，文件名以`CORE_RL` or `IM_MOD_RL`开头的 DLL，放到 php.exe 所在的目录（这个目录应该已经配置到PATH）。
    或者，拷贝到其他目录，这个目录应该配置到PATH。
1. Add this line to your php.ini file: `extension=php_imagick.dll`
1. Restart the Apache/NGINX Windows service (if applicable)

### 测试

~~~ php
<?php
$image = new Imagick();
$image->newImage(1, 1, new ImagickPixel('#ffffff'));
$image->setImageFormat('png');
$pngData = $image->getImagesBlob();
echo strpos($pngData, "\x89PNG\r\n\x1a\n") === 0 ? 'Ok' : 'Failed'; 
~~~





































