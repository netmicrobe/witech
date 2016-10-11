---
layout: post
title: vbs 输出到命令行
description: 
categories: [cm, windows, vbs]
tags: [cm, vbs, windows]
---

```
'echo2console.vbs
Set objNetwork = Wscript.CreateObject("Wscript.Network")
Set objStdOut = WScript.StdOut
objStdOut.Write "User: "
objStdOut.Write objNetwork.UserDomain
objStdOut.Write "\"
objStdOut.Write objNetwork.UserName
objStdOut.WriteBlankLines(1)
objStdOut.WriteLine objNetwork.ComputerName
objStdOut.Write "Information retrieved."
objStdOut.Close
```

然后在命令行中执行脚本：cscript echo2console.vbs