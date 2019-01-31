---
layout: post
title: Go 使用入门
categories: [dev, go]
tags: [go, go-lang]
---


* [How to Write Go Code](https://golang.org/doc/code.html)
* []()
* []()
* []()



## Hello World

* 文件 main.go

~~~ go
package main
import "fmt"
// this is a comment
func main() {
  fmt.Println("Hello, World")
}
~~~

* main.go 放到 workspace `$GOPATH` 目录下的 src/golang-book/chapter1/

~~~ shell
cd src/golang-book/chapter1
go run main.go
~~~

### Hello Library

1. the first step is to choose a package path (we'll use github.com/user/stringutil) and create the package directory:
    ~~~
    $ mkdir $GOPATH/src/github.com/user/stringutil
    ~~~

2. create a file named reverse.go in that directory

~~~ go
// Package stringutil contains utility functions for working with strings.
package stringutil

// Reverse returns its argument string reversed rune-wise left to right.
func Reverse(s string) string {
  r := []rune(s)
  for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
    r[i], r[j] = r[j], r[i]
  }
  return string(r)
}
~~~






## Go的简单介绍

* 机器上所有的Go代码，通常都放到一个workspace目录（即 `$GOPATH`）下面。
* workspace目录可以有很多版本库，每个版本库可以有很多package。

* package
  * package 的路径下存放Go源代码文件，每个源码文件第一行必须是 `package your-package-name`
  * package 路径决定`import`路径。



### workspace

A workspace is a directory hierarchy with two directories at its root:

* src contains Go source files
  * The src subdirectory typically contains multiple version control repositories (such as for Git or Mercurial) that track the development of one or more source packages.
* bin contains executable commands.
  * The go tool builds and installs binaries to the bin directory.

一个workspace目录结构的例子：

~~~
bin/
    hello                          # command executable
    outyet                         # command executable
src/
    github.com/golang/example/
        .git/                      # Git repository metadata
        hello/
            hello.go               # command source
        outyet/
            main.go                # command source
            main_test.go           # test source
        stringutil/
            reverse.go             # package source
            reverse_test.go        # test source
    golang.org/x/image/
        .git/                      # Git repository metadata
        bmp/
            reader.go              # package source
            writer.go              # package source
          ... (many more repositories and packages omitted) ...
~~~

* The tree above shows a workspace containing two repositories (example and image). 
* The example repository contains two commands (hello and outyet) and one library (stringutil). 
  * Commands and libraries 是另外一种类型的package。
* The image repository contains the bmp package and several others.

* **Note** that symbolic links should not be used to link files or directories into your workspace.


#### The GOPATH environment variable

* The GOPATH environment variable specifies the location of your workspace. 
* It defaults to a directory named go inside your home directory, so `$HOME/go` on Unix, and `%USERPROFILE%\go` (usually C:\Users\YourName\go) on Windows.
* **Note** that GOPATH must not be the same path as your Go installation.
* The command `go env GOPATH` prints the effective current GOPATH
* 为了调测方便，一般将 `$GOPATH/bin` 设置到系统 `$PATH`
  ~~~
  $ export PATH=$PATH:$(go env GOPATH)/bin
  ~~~

如何自定义 GOPATH ，参考： [set the GOPATH environment variable](https://golang.org/wiki/SettingGOPATH)



### import

```
import (
  "log" // Go Built-in package
  "fmt"
  _ "package-not-used-but-wanna-load" // 没用到，但是想初始化（调用包中各文件的init）进来的package，在前头写个下划线
)
```

* An __import path__ is a string that uniquely identifies a package.
* The packages from the standard library are given short import paths such as "fmt" and "net/http". 
* A package's import path corresponds to its location inside a workspace or in a remote repository 
* package name 避免重复的方法：
  * if you have a GitHub account at github.com/user, that should be your base path. `$ mkdir -p $GOPATH/src/github.com/user`



## Go tool

### go install

~~~
$ go install github.com/user/hello

# 等同于

$ cd $GOPATH/src/github.com/user/hello
$ go install
~~~

* This command builds the hello command, producing an executable binary. It then installs that binary to the workspace's bin directory as hello (or, under Windows, hello.exe). 





## Go 语言特性

### nil

### 变量

In Go, all variables are initialized to their zero value. 

* For numeric types, that value is 0; 
* for strings it’s an empty string; 
* for Booleans it’s false;
* for pointers, the zero value is nil. 

When it comes to reference types, there are underlying data structures that are initialized to their zero values. 

### 函数

#### 函数定义

注意，参数名在前，类型在后

func FUNCTION-NAME(PARAMETER1 type-name, ...)

### 集合

#### slice

相当于动态数组


#### map


#### range

The keyword **range** can be used with arrays, strings, slices, maps, and channels. 

```
for _, item := range items {
...
}
或者，
for index, item := range items {
...
}
```



## 帮助文档


### 查看 fmt 包 Println 函数的帮助

~~~
godoc fmt Println
~~~


### godoc

#### 本地运行文档服务器：

```
godoc -http=:6060
```

If you open your webbrowser and navigate to http://localhost:6060, you’ll see a web page with documentation for both the Go standard libraries and any Go source that lives in your GOPATH.





## 使用习惯&技巧

### 函数返回结果和错误

例如，

```go
// Open the file.
file, err := os.Open(dataFile)
```

### 集合 [] 获取返回 item 和 exists

例如，

```
matcher, exists := matchers[feed.Type]
```

### BLANK IDENTIFIER (_)

The _ (underscore character) is known as the blank identifier and has many uses within Go. It’s used when you want to throw away the assignment of a value, including the assignment of an import to its package name, or ignore return values from a function when you’re only interested in the others.
