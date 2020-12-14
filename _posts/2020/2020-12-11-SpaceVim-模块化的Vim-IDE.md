---
layout: post
title: SpaceVim-模块化的Vim-IDE
categories: [cm, vim]
tags: [editor, 编辑器]
---

* 参考： 
  * [SpaceVim 中文官网](https://spacevim.org/cn/)
  * [Github - SpaceVim](https://github.com/SpaceVim/SpaceVim)
  * [Hack-SpaceVim：Tell you how to hack SpaceVim](https:///github.com/Gabirel/Hack-SpaceVim)
  * [spacevim.org - 使用 Vim 搭建基本开发环境](https://spacevim.org/cn/use-vim-as-ide/)
  * []()
  * []()



## 安装

### 在 Manjaro 上安装

~~~
sudo pacman -S neovim
curl -sLf https://spacevim.org/cn/install.sh | bash
# 或
curl -sLf https://spacevim.org/install.sh | bash
~~~

### 卸载

~~~
curl -sLf https://spacevim.org/install.sh | bash -s -- --uninstall
rm -fr ~/.SpaceVim
~~~







## 配置

快捷键 `SPC f v d` 打开配置文件

初次启动时，SpaceVim 弹出一个选择目录（basic 模式、 dark_powerd 模式），用户需要选择合适自己的配置模板。 此时，SpaceVim 将自动在 `$HOME` 目录生成 `~/.SpaceVim.d/init.toml`。 所有用户配置文件都可以存储在 `~/.SpaceVim.d/`。


### 插件

如果你需要添加 github 上的插件，只需要在 SpaceVim 配置文件中添加 [[custom_plugins]] 片段：

~~~
[[custom_plugins]]
    repo = "lilydjwg/colorizer"
    on_cmd = ["ColorHighlight", "ColorToggle"]
    merged = false
~~~

`one_cmd` 选项使得这个插件延迟加载。 该插件会在第一次执行 ColorHighlight 或者 ColorToggle 命令时被加载。

`merged` 选项用于设定是否合并该插件的文件夹，如果 merged 是 true，那么，这一插件内的文件将被合并到： `~/.cache/vimfiles/.cache/init.vim/` 或者 `~/.cache/vimfiles/.cache/vimrc/`， 这依据当前使用的是 Neovim 还是 Vim。

除了 on_cmd 以外，还有一些其它的选项，可以通过 `:h dein-options` 查阅。


#### 禁用插件

SpaceVim 默认安装了一些插件，如果需要禁用某个插件，可以通过 `~/.SpaceVim.d/init.toml` 的 `[options]` 片段中的 `disabled_plugins` 这一选项来操作：

~~~
[options]
    # 请注意，该值为一个 List，每一个选项为插件的名称，而非 github 仓库地址。
    disabled_plugins = ["clighter", "clighter8"]
~~~


###  SpaceVim 的模块

使用模块的方式来组织和管理插件，将相关功能的插件组织成一个模块，启用/禁用效率更加高。同时也节省了很多寻找插件和配置插件的时间。

在 SpaceVim 中，一个模块是一个单个的 Vim 文件，例如，autocomplete 模块存储在 autoload/SpaceVim/layers/autocomplete.vim，在这个文件内有以下几个公共函数：

* `SpaceVim#layers#autocomplete#plugins()`: 返回该模块插件列表
* `SpaceVim#layers#autocomplete#config()`: 模块相关设置
* `SpaceVim#layers#autocomplete#set_variable()`: 模块选项设置函数


### 启动函数

由于 toml 配置的局限性，SpaceVim 提供了两种启动函数 `bootstrap_before` 和 `bootstrap_after`，在该函数内可以使用 Vim script。 可通过 `~/.SpaceVim.d/init.toml` 的 `[options]` 片段中的这两个选项 `bootstrap_before` 和 `bootstrap_after` 来指定函数名称，例如：

~~~
[options]
    bootstrap_before = "myspacevim#before"
    bootstrap_after  = "myspacevim#after"
~~~

启动函数文件应放置在 Vim &runtimepath 的 autoload 文件夹内。例如：

文件名：`~/.SpaceVim.d/autoload/myspacevim.vim`

~~~
function! myspacevim#before() abort
    let g:neomake_c_enabled_makers = ['clang']
    nnoremap jk <esc>
endfunction

function! myspacevim#after() abort
    iunmap jk
endfunction
~~~

函数 `bootstrap_before` 将在读取用户配置后执行，而函数 `bootstrap_after` 将在 VimEnter autocmd 之后执行。

如果你需要添加自定义以 `SPC` 为前缀的快捷键，你需要使用 bootstrap function，在其中加入：

~~~
function! myspacevim#before() abort
    call SpaceVim#custom#SPCGroupName(['G'], '+TestGroup')
    call SpaceVim#custom#SPC('nore', ['G', 't'], 'echom 1', 'echomessage 1', 1)
endfunction
~~~


### Vim 兼容模式

以下为 SpaceVim 中与 Vim 默认情况下的一些差异。

按键 `s` 是删除光标下的字符，但是在 SpaceVim 中， 它是Normal模式窗口快捷键的前缀，这一功能可以使用选项 windows_leader 来修改，默认是 s。 如果需要使用按键 `s` 的原生功能，可以将该选项设置为空。

~~~
[options]
    windows_leader = ''
~~~

按键 `,` 是重复上一次的搜索 f、F、t 和 T ，但在 SpaceVim 中默认被用作为语言专用的前缀键。如果需要禁用此选项， 可设置 enable_language_specific_leader = false。

~~~
[options]
    enable_language_specific_leader = false
~~~

按键 `q` 是录制宏，但是在 SpaceVim 中被设置为了智能关闭窗口，设置该功能的选项是 windows_smartclose，默认值是 q， 可以通过将该选项设置成空字符串来禁用该功能，同时也可以设置成其他按键。

~~~
[options]
    windows_smartclose = ''
~~~

命令行模式下 `Ctrl-a` 按键在 SpaceVim 中被修改为了移动光标至命令行行首。
命令行模式下 `Ctrl-b` 按键被映射为方向键 `<Left>`, 用以向左移动光标。
命令行模式下 `Ctrl-f` 按键被映射为方向键 `<Right>`, 用以向右移动光标。
可以通过设置 `vimcompatible = true` 来启用 Vim 兼容模式，而在兼容模式下，以上所有差异将不存在。 当然，也可通过对应的选项禁用某一个差异。例如，恢复逗号 , 的原始功能，可以通过禁用语言专用的前缀键：

~~~
[options]
    enable_language_specific_leader = false
~~~


### UI 界面设置

#### 颜色主题 colorscheme

* 参考
  * <https://spacevim.org/cn/layers/colorscheme/>

默认的颜色主题采用的是 `gruvbox`。

* **修改主题设置**

`~/.SpaceVim.d/init.toml` 的 `[options]` 片段中修改 `colorscheme` 选项。例如，使用 Vim 自带的内置主题 desert：

~~~
[options]
    colorscheme = "desert"
    colorscheme_bg = "dark"
~~~


| 快捷键 |	功能描述 |
| `SPC T n`	| 切换至下一个随机主题 |
| `SPC T s` |	通过 Unite 选择主题 |




#### 字体设置

默认字体使用 `SourceCodePro Nerd Font Mono`

如果需要修改 SpaceVim 的字体，可以在 `~/.SpaceVim.d/init.toml` 的 `[options]`片段中修改选项 `guifont`，默认值为：

~~~
[options]
    guifont = "SourceCodePro Nerd Font Mono:h11"
~~~




#### 高亮

快捷键	功能描述
SPC t h h	高亮当前行
SPC t h i	高亮代码对齐线
SPC t h c	高亮光标所在列
SPC t h s	启用/禁用语法高亮
SPC t i	切换显示当前对齐(TODO)
SPC t n	显示/隐藏行号
SPC t b	切换背景色
SPC t c	切换 conceal 模式
SPC t p	切换 paste 模式
SPC t t	打开 Tab 管理器
SPC T ~	显示/隐藏 Buffer 结尾空行行首的 ~
SPC T F	切换全屏(TODO)
SPC T f	显示/隐藏 Vim 边框(GUI)
SPC T m	显示/隐藏菜单栏
SPC T t	显示/隐藏工具栏







## 使用

### 快捷键导航 `<leader>` 键

leader 键默认为： `\`

`leader + 数字` ： 切换文件tab

如果需要修改 `<Leader>` 键则需要使用启动函数修改 `g:mapleader` 的值， 比如使用逗号 , 作为 `<Leader>` 按键。

~~~
function! myspacevim#before() abort
    let g:mapleader = ','
endfunction
~~~


#### 快捷导航键 延迟设置

默认情况下，快捷键导航将在输入延迟超过 1000ms 后打开，你可以通过修改 Vim 的 'timeoutlen' 选项来修改成适合自己的延迟时间长度。

#### 快捷导航键 呼出的菜单操作

按键	功能描述
u	撤销按键
n	向下翻页
p	向上翻页



### 文件树

SpaceVim 使用 vimfiler 作为默认的文件树插件，

~~~
[options]
    # 文件树插件可选值包括：
    # - vimfiler （默认）
    # - nerdtree
    # - defx
    filemanager = "defx"
~~~


打开 / 关闭 文件树  `F3` 或  `SPC f t` 或 `SPC f T`

* **文件树内的快捷键**

`<Left>` / `h`	移至父目录，并关闭文件夹
`<Down>` / `j`	向下移动光标
`<Up>` / `k`	向上移动光标
`<Right>` / `l`	展开目录，或打开文件
`N`	在光标位置新建文件
`y y`	复制光标下文件路径至系统剪切板
`y Y`	复制光标下文件至系统剪切板
`P`	在光标位置黏贴文件
`.`	切换显示隐藏文件
`s v`	分屏编辑该文件
`s g`	垂直分屏编辑该文件
`p`	预览文件
`i`	切换至文件夹历史
`v`	快速查看
`>`	放大文件树窗口宽度
`<`	缩小文件树窗口宽度
`g x`	使用相关程序执行该文件
`'`	标记光标下的文件（夹）
`V`	清除所有标记
`Ctrl+r`	刷新页面

* **文件树中打开文件**

`l` / `<Enter>`	打开文件
`sg`	分屏打开文件
`sv`	垂直分屏打开文件


### 移动光标以及滚屏的快捷键

快捷键	功能描述
`H`	移动光标至屏幕顶部
`L`	移动光标至屏幕底部
`<`	向左移动文本
`>`	向右移动文本
`}`	向前移动一个段落
`{`	向后移动一个段落
`Ctrl-f`	向下翻页 (`Ctrl-f` / `Ctrl-d`)
`Ctrl-b`	向上翻页 (`C-b` / `C-u`)
`Ctrl-e`	向下滚屏 (`3 Ctrl-e/j`)
`Ctrl-y`	向上滚屏 (`3Ctrl-y/k`)
`Ctrl-Shift-Up`	向上移动当前行
`Ctrl-Shift-Down`	向下移动当前行


按键	功能描述
`<F2>`	打开、关闭语法树
`<F3>`	打开、关闭文件树
`Ctrl-<Down>`	切换至下方窗口
`Ctrl-<Up>`	切换至上方窗口
`Ctrl-<Left>`	切换至左边窗口
`Ctrl-<Right>`	切换至右边窗口





### 编辑

#### 移动文本块

快捷键	功能描述
`<` / `Shift-Tab`	向左移动文本
`>` / `Tab`	向右移动文本
`Ctrl-Shift-Up`	向上移动选中行
`Ctrl-Shift-Down`	向下移动选中行


### 代码缩进

默认的代码缩进值是 2，缩进的大小由选项 default_indent 设置， 如果希望使用 4 个空格作为缩进，只需要在 SpaceVim 配置文件中加入如下内容：

~~~
[options]
    default_indent = 4
~~~

`default_indent` 这一选项的值，将被赋值到 Vim 的选项：`&tabstop`、`&softtabstop` 和 `&shiftwidth`。默认情况下，输入的 `<Tab>` 会被自动展开成对应缩进数量的空格， 可通过设置选项 expand_tab 的值为 false 来禁用这一特性：

~~~
[options]
    default_indent = 4
    expand_tab = true
~~~


### 复制粘贴

如果 `has('unnamedplus')` 返回 1，那么快捷键 `<Leader> y` 使用的寄存器是 `+`， 否则，这个快捷键使用的寄存器是 `*`， 可以阅读 `:h registers` 获取更多关于寄存器相关的内容。

快捷键	功能描述
`<Leader> y`	复制文本至系统剪切板
`<Leader> p`	粘贴系统剪切板文字至当前位置之后
`<Leader> P`	粘贴系统剪切板文字至当前位置之前


### 文本编码格式

SpaceVim 默认使用 utf-8 码进行编码。下面是 utf-8 编码的四个设置：

~~~
fileencodings (fencs) : ucs-bom, utf-8, default, latin1
fileencoding (fenc) : utf-8
encoding (enc) : utf-8
termencoding (tenc) : utf-8 (only supported in Vim)
~~~

修复混乱的显示：`SPC e a` 是自动选择文件编码的按键映射。在选择好文件编码方式后，你可以运行下面的代码来修复编码：

~~~
set enc=utf-8
write
~~~









