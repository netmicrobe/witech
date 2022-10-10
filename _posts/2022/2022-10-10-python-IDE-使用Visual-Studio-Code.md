---
layout: post
title: python-IDE-使用Visual-Studio-Code，关联 
categories: [ dev, python ]
tags: []
---

* 参考
  * [Getting Started with Python in VS Code](https://code.visualstudio.com/docs/python/python-tutorial)
  * [Advanced Visual Studio Code for Python Developers](https://realpython.com/advanced-visual-studio-code-python/)
  * []()
  * []()


## Visual Studio Code

### 配置 Python 开发环境

1. 安装 VS-Code
    ~~~sh
    sudo pacman -S code
    ~~~

1. 安装 VS-Code 的 python 插件
    1. 启动 VS-Code，进入 extensions 管理（`Ctrl + Shift + x`）
    1. 安装 微软的 python 插件（Extension ID: `ms-python.python`）

1. 在系统上安装python

1. 设置 workspace 文件夹
    1. 从文件夹目录，启动VS Code
        ~~~sh
        cd my-project
        code .
        ~~~
    1. 或者，启动后，打开文件夹： File \> Open Folder

1. 简单写段code，执行下
    
    写个 hello.py

    ~~~python
    msg = "Hello World"
    print(msg)
    ~~~

    IDE界面上，文件名 标签栏 最右边的位置，有个三角形的启动按钮，点击就可以运行了。

    屏幕下面， terminal 窗口可以看到结果。


### 简单调试 debug 下


1. 选中要下断点的语句，按 `F9`，设置成功，句子前面会出现个红点。
1. 按 `F5` 执行
1. `文件名 标签栏` 附近会出现 `调试工具栏`
1. `Debug Console` 窗口，可以对当前变量进行操作，类似 javascript 的 console


### 配置虚拟运行环境

1. 创建虚拟环境
~~~sh
python -m venv your-env-name
~~~
1. 进入虚拟环境
    在VS-Code terminal 中运行 `source /your-env-path/bin/activate`
1. 在 VS-Code 中选择 刚创建的虚拟环境中的Python interpreter
    1. `Ctrl + Shift + P` 呼出 Command Palette
    1. 输入 `Python: Select Interpreter`
    1. 选择虚拟环境中的Python interpreter




### 排错

#### manjaro 虚拟环境中执行 matplotlib 的图形代码报错

* 代码

~~~py
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 20, 100)  # Create a list of evenly-spaced numbers over the range
plt.plot(x, np.sin(x))       # Plot the sine of each x point
plt.show()                   # Display the plot
~~~

* 报错： 

~~~
UserWarning: Matplotlib is currently using agg, which is a non-GUI backend, so cannot show the figure.
  plt.show()
~~~

* 排查：

已经在虚拟环境中安装了 `matplotlib`

同样代码在 manjaro KDE 环境运行正常。

~~~py
import matplotlib
import matplotlib.rcsetup as rcsetup

print(matplotlib.get_backend())
print(rcsetup.all_backends)
~~~

用上面代码检查发现 虚拟环境用的 backend 是 `Agg`，系统环境用的是 `QtAgg`

* 解决：

在虚拟环境中安装Qt5Agg： `pip install PyQt5`

修改代码，添加 `matplotlib.use("Qt5Agg")`：

~~~py
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

matplotlib.use("Qt5Agg")
x = np.linspace(0, 20, 100)
plt.plot(x, np.sin(x))
plt.show()
~~~
















































