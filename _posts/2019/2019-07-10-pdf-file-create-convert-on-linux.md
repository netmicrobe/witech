---
layout: post
title: linux 上操作pdf文件：创建、合并、转换 / create,merge,convert
categories: [cm, linux]
tags: [pdfunite, convert, imagemagick, pdf-shuffler]
---

* 参考： 
  * <https://askubuntu.com/a/1004158>
  * [Merge PDF Files In Command Line On Linux](https://www.ostechnix.com/how-to-merge-pdf-files-in-command-line-on-linux/)


## 目前的使用方案

convert        | 将图片转成pdf
pdf-shuffler   | 从pdf分割、提取页面
pdfunite       | 拼接pdf

## convert工具

* REF
  * <https://askubuntu.com/a/246653>
  * <https://ubuntuforums.org/showthread.php?t=1379633>
  * [AskUbuntu - Jpeg files to pdf](https://askubuntu.com/questions/246647/jpeg-files-to-pdf)
  * <https://askubuntu.com/a/1081907>


### jpg 转换为 pdf

~~~
sudo apt-get install imagemagick

convert *.jpg pictures.pdf

convert img{0..19}.jpg slides.pdf

#  joining multiple images into one pdf
convert page1.jpg page2.jpg file.pdf
# NOTE: the +compress turns off compression.
# turns off compression and resulting PDF will be big!
# From ubuntuforums.org, the +compress helps it to not hang. 
convert page1.jpg page2.jpg +compress file.pdf
~~~

* 'convert` 的 `compress` 参数
  * It actually disables all compression leaving you with a PDF 10 times bigger than the original JPEG. Just don't specify compression options, and convert will go with the input compression format (JPEG) which in this case is the best option file size-wise.
  * 参考： 
    * <http://www.imagemagick.org/script/command-line-options.php#compress>
    * <http://www.imagemagick.org/script/command-line-options.php#compress>

* **报错** “not authorized”
  * `convert` 因为安全在Ubuntu上被限制，policy file is `/etc/ImageMagick-6/policy.xml`
  * 解决办法1，桌面用户，可以放心移走policy文件，取消所有限制。 
    `sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xmlout`
  * 解决办法2，服务器用户，修改policy文件。
    例如： `<policy domain="coder" rights="none" pattern="PDF" />`
    找到开放的coder格式，注释掉那条规则：`<!-- <policy domain="coder" rights="none" pattern="PDF" /> -->`



### convert 拼接 PDF文件

~~~
convert sub1.pdf sub2.pdf sub3.pdf merged.pdf
~~~





## pdftk

PDFtk is free graphical tool that can be used to split or merge PDF files. It is available as free and paid versions. You can use it either in CLI or GUI mode.

~~~
sudo add-apt-repository ppa:malteworld/ppa
sudo apt update
sudo apt-get install pdftk
~~~


### pdftk 拼接 pdf

~~~
# to concatenate the pdfpages into one:
pdftk *.pdf cat output combined.pdf

pdftk file1.pdf file2.pdf fiel3.pdf cat output outputfile.pdf
~~~



## Poppler

~~~
sudo apt-get install poppler-utils
~~~

### pdfunite 拼接 pdf文件

* REF
  * [How to easily merge PDF documents under Linux](https://unixblogger.com/how-to-easily-merge-pdf-documents-under-linux/)

~~~
pdfunite file1.pdf file2.pdf file3.pdf outputfile.pdf
pdfunite source1.pdf source2.pdf merged_output.pdf
~~~


* 可能的缺点
  1. 文档中的链接会被损坏
  1. 已有输出文件，不会提醒，直接覆盖。
  1. 生成的PDF文件异常的大


## QPDF

* <http://qpdf.sourceforge.net/>
* <https://github.com/qpdf/qpdf>

QPDF 是 PDF 文件转换的命令行工具，也被称为 pdf-to-pdf

QPDF 可以创建线性化（web 优化）文件和加密文件，同时也可以使用对象流转换 PDF 文件（类似于压缩对象）。

QPDF 支持特殊的模式，允许你在文本编辑器编辑 PDF 文件。

QPDF 支持合并和分离 PDFs。

### 编译安装 QPDF

~~~
git clone https://github.com/qpdf/qpdf.git

sudo apt-get install libjpeg-dev

./configure
make
make install
~~~


### 用 QPDF 拼接

* <https://stackoverflow.com/a/51080927>

比pdftk 生成的文件更小。

~~~
qpdf --empty --pages *.pdf -- out.pdf
~~~



## pdfshuffler （GUI工具）

~~~
sudo apt-get install pdfshuffler
~~~



## PDFsam, GUI 工具

PDFsam is capable of doing a lot of more things than just merging: Split, Rotate, Extract, Split bookmarks and many more. PDFsam is written in Java and (of course) available in most Linux distributions. 

~~~
# 安装要段时间，有100M+
sudo apt-get install pdfsam
~~~

出现如下错误后，没在继续尝试。环境时 mint19.1 + openjdk8

* **错误** 执行 `pdfsam` 提示 `Could not find or load main class java.se.ee`

~~~
$ /usr/lib/jvm/java-8-openjdk-amd64/bin/java -XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee -Xmx512M -classpath /usr/share/pdfsam/lib/* -splash:/usr/share/pdfsam/resources/splash.gif -Dapp.name=pdfsam-basic -Dapp.pid=21474 -Dapp.home=/usr/share/pdfsam -Dbasedir=/usr/share/pdfsam -Dprism.lcdtext=false -Djdk.gtk.version=2 org.pdfsam.basic.App

Error: Could not find or load main class java.se.ee
~~~




## ghostscript

### 用 gs 拼接 PDF

* <https://stackoverflow.com/a/19358402>

gs - Ghostscript (PostScript and PDF language interpreter and previewer)

无需另外安装。系统自带。

~~~
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf mine1.pdf mine2.pdf

# for low resolution PDFs
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=merged.pdf mine1.pdf mine2.pdf

# 上述2种方法，分辨率效果都好于convert
convert -density 300x300 -quality 100 mine1.pdf mine2.pdf merged.pdf

# trick to shrink the size of PDFs, I reduced with it one PDF of 300 MB to just 15 MB with an acceptable resolution! and all of this with the good ghostscript, here it is:
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf input.pdf
~~~




## Apache PDFBox 

### PDFBox 拼接 PDF文件

* <http://pdfbox.apache.org/>

~~~
usage: java -jar pdfbox-app-x.y.z.jar PDFMerger "Source PDF files (2 ..n)" "Target PDF file"
~~~


## pdfmerge.py


* 下载： <https://pypi.python.org/pypi/pdftools/1.0.6>
* should install pyhton3 .

### pdfmerge.py 拼接 PDF

~~~
python pdftools-1.1.0/pdfmerge.py -o output.pdf -d file1.pdf file2.pdf file3 
~~~


## sejda-console

* <http://sejda.org/>

### sejda-console merge

~~~
sejda-console merge -f file1.pdf file2.pdf -o merged.pdf
~~~



## pdfseparate









## img2pdf 工具

比起 `convert`， `img2pdf` put the original jpg into the PDF，坏处是，pdf文件有些大。

### img2pdf 转换 jpg 到 pdf

~~~
ls -1 ./*jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf
~~~



## LibreOffice

* 参考： <https://askubuntu.com/a/561958>


### LibreOffice 转换 jpg 到 pdf

Open jpg or png file with LibreOffice Writer and export as PDF.





## OCR

~~~
# add an OCRed text layer that doesn't change the quality of the scan in the pdfs so they can be searchable:
pypdfocr combined.pdf

# 或者，
ocrmypdf combined.pdf combined_ocr.pdf
~~~



























































