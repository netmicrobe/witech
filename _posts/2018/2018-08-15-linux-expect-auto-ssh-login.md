---
layout: post
title: 使用expect脚本自动进行ssh登录
categories: [ cm, linux ]
tags: [tcl, expect, ssh]
---


---
* 参考：
  * [Expect Command Tutorial in Linux With Example Usage](https://www.slashroot.in/expect-command-tutorial-linux-example-usage)
  * [Expect](https://core.tcl.tk/expect/index)
  * [expect(1) - Linux man page](https://linux.die.net/man/1/expect)
  * [Expect examples and tips](https://www.pantz.org/software/expect/expect_examples_and_tips.html)

---

1. 安装 expect 和 openssh



1. 编写 ssh-pass 脚本，放入 $PATH 的搜索范围

    ~~~ tcl
    #!/usr/bin/expect
    #Usage ssh-pass <host> <ssh user> <ssh password>

    set timeout 60
    set username [lindex $argv 1]
    set password [lindex $argv 2]
    set hostname [lindex $argv 0]
    log_user 0

    if {[llength $argv] == 0} {
      send_user "Usage: ssh-pass hostname username \'password\'\n"
      exit 1
    }

    send_user "\n#####\n# $hostname\n#####\n"

    spawn ssh -q -oStrictHostKeyChecking=no -oCheckHostIP=no $username@$hostname

    expect {
      timeout { send_user "\nFailed to get password prompt\n"; exit 1 }
      eof { send_user "\nSSH failure for $hostname\n"; exit 1 }
      "*?assword"
    }

    send "$password\r"

    interact
    ~~~



2. 在 bash 中创建快捷函数

    ~~~ shell
    function sshtest() {
      ssh-pass 192.168.100.$1 root your-pass
    }
    ~~~


















