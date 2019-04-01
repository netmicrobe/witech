---
layout: post
title: Go 使用入门
categories: [dev, go]
tags: [go, go-lang]
---


* [How to Write Go Code](https://golang.org/doc/code.html)
* [golangbot.com](https://golangbot.com/)
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

1. 创建package路径 (如，github.com/user/stringutil)

    ~~~
    $ mkdir -p $GOPATH/src/github.com/user/stringutil
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

3. 编译

    ~~~ go
    $ go build github.com/user/stringutil
    ~~~

4. 引用package

    ~~~ go
    package main

    import (
      "fmt"

      "github.com/user/stringutil"
    )

    func main() {
      fmt.Println(stringutil.Reverse("!oG ,olleH"))
    }
    ~~~

    ~~~ go
    $ go install github.com/netmicrobe/hello
    $ hello
    Hello, Go!
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


### Package

* The first statement in a Go source file must be `package name`
* Executable commands must always use `package main`.



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


### Testing 

* Go has a lightweight test framework composed of the `go test` command and the `testing` package.
* 创建测试代码文件，文件名以 `_test.go` 结尾，包含`func TestXXX (t *testing.T)` 函数.
* The test framework runs each such function; if the function calls a failure function such as `t.Error` or `t.Fail`, the test is considered to have failed.

* 例子： Add a test to the stringutil package
  1. creating the file `$GOPATH/src/github.com/user/stringutil/reverse_test.go`
      ~~~ go
      package stringutil

      import "testing"

      func TestReverse(t *testing.T) {
        cases := []struct {
          in, want string
        }{
          {"Hello, world", "dlrow ,olleH"},
          {"Hello, 世界", "界世 ,olleH"},
          {"", ""},
        }
        for _, c := range cases {
          got := Reverse(c.in)
          if got != c.want {
            t.Errorf("Reverse(%q) == %q, want %q", c.in, got, c.want)
          }
        }
      }
      ~~~
  2. run the test with go test: `go test github.com/user/stringutil`
      或者
      ~~~ shell
      cd github.com/user/stringutil
      go test
      ~~~






## Go tool

### go help 帮助 

`go help subcommand-name`

例如，

~~~
go help importpath
~~~


### go install

~~~
$ go install github.com/user/hello

# 等同于

$ cd $GOPATH/src/github.com/user/hello
$ go install
~~~

* This command builds the hello command, producing an executable binary. It then installs that binary to the workspace's bin directory as hello (or, under Windows, hello.exe). 





### go get

If you include the repository URL in the package's import path, go get will fetch, build, and install it automatically:

~~~ shell
$ go get github.com/golang/example/hello
$ $GOPATH/bin/hello
Hello, Go examples!
~~~

* If the specified package is not present in a workspace, go get will place it inside the first workspace specified by GOPATH.
* If the package does already exist, go get skips the remote fetch and behaves the same as go install.




### go clean

* windows上的build cache在： `C:\Users\your-name\AppData\Local\go-build`
* 清理 local build cache ： `go clean -cache`





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




### 异常处理

* 参考：
  * <https://blog.golang.org/defer-panic-and-recover>

#### defer

在函数中添加多个 延迟（defer）语句，当函数执行到最后时，这些defer语句会按照逆序执行，最后该函数返回。

~~~ go
func ReadWrite() bool { 
  file.Open("file") 
  defer file.Close() 
  
  if failureX { return false } 
  if failureY { return false } 
  
  return true
}
~~~


#### panic

* **Panic** is a built-in function that stops the ordinary flow of control and begins panicking. 
* When the function F calls panic, execution of F stops, any deferred functions in F are executed normally, and then F returns to its caller. 
* The process continues up the stack until all functions in the current goroutine have returned, at which point the program **crashes**.
* Panic can also be caused by runtime errors, such as out-of-bounds array accesses.

#### recover

* **Recover** is a built-in function that regains control of a panicking goroutine. 
* Recover is only useful inside __deferred functions__.

 
#### 例子

~~~ go
package main

import "fmt"

func main() {
    f()
    fmt.Println("Returned normally from f.")
}

func f() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered in f", r)
        }
    }()
    fmt.Println("Calling g.")
    g(0)
    fmt.Println("Returned normally from g.")
}

func g(i int) {
    if i > 3 {
        fmt.Println("Panicking!")
        panic(fmt.Sprintf("%v", i))
    }
    defer fmt.Println("Defer in g", i)
    fmt.Println("Printing in g", i)
    g(i + 1)
}
~~~


执行结果如下

~~~
Calling g.
Printing in g 0
Printing in g 1
Printing in g 2
Printing in g 3
Panicking!
Defer in g 3
Defer in g 2
Defer in g 1
Defer in g 0
Recovered in f 4
Returned normally from f.
~~~

如果删除函数f()中的defer语句，将会是如下结果：

~~~
Calling g.
Printing in g 0
Printing in g 1
Printing in g 2
Printing in g 3
Panicking!
Defer in g 3
Defer in g 2
Defer in g 1
Defer in g 0
panic: 4
 
panic PC=0x2a9cd8
[stack trace omitted]
~~~




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
