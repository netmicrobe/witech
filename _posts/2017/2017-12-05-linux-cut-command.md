---
layout: post
title: linux cut 命令
categories: [cm, linux]
tags: [linux, find]
---


* 参考：
  * <https://shapeshed.com/unix-cut/>


`cut` , a UNIX and Linux command for cutting sections from each line of files.

The cut command in UNIX is a command line utility for cutting sections from each line of files and writing the result to standard output. 

It can be used to cut parts of a line by byte position, character and delimiter. It can also be used to cut data from file formats like CSV.


## How to cut by byte position

use the -b option.

~~~ shell
echo 'baz' | cut -b 2
a
echo 'baz' | cut -b 1-2
ba
echo 'baz' | cut -b 1,3
bz
~~~

## How to cut by character

 use the -c option.

Where your input stream is character based -c can be a better option than selecting by bytes as often characters are more than one byte.

In the following example character ‘♣’ is three bytes. By using the -c option the character can be correctly selected along with any other characters that are of interest.

~~~ shell
echo '♣foobar' | cut -c 1,6
♣a
echo '♣foobar' | cut -c 1-3
♣fo
~~~


## How to cut based on a delimiter

use the `-d` option. This is normally used in conjunction with the `-f` option to specify the field that should be cut.

* names.csv
    ~~~
    John,Smith,34,London
    Arthur,Evans,21,Newport
    George,Jones,32,Truro
    ~~~

The delimiter can be set to a comma with `-d ','`. cut can then pull out the fields of interest with the `-f` flag. 

~~~ shell
cut -d ',' -f 1 names.csv
John
Arthur  
George
~~~

Multiple fields can be cut by passing a comma separated list.

~~~ shell
cut -d ',' -f 1,4 names.csv
John,London
Arthur,Newport
George,Truro
~~~

包括第二个字段以后所有字段

~~~ shell
cut -d ',' -f 2- names.csv

Smith,34,London
Evans,21,Newport
Jones,32,Truro
~~~


## How to cut by complement pattern (not available on the BSD)

use the `--complement` option. The `--complement` option selects the inverse of the options passed to sort.

~~~ shell
echo 'foo' | cut --complement -c 1
oo
~~~


## How to modify the output delimiter (not available on the BSD)

To modify the output delimiter use the `--output-delimiter` option. 

In the following example a semi-colon is converted to a space and the first, third and fourth fields are selected.

~~~ shell
echo 'how;now;brown;cow' | cut -d ';' -f 1,3,4 --output-delimiter=' '
how brown cow
~~~
























































































































