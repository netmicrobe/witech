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











## 使用

### `<leader>` 键

leader 键默认为： `\`

`leader + 数字` ： 切换文件tab


















