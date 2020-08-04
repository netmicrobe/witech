---
layout: post
title: 设置 git 命令输出内容的颜色 color scheme
categories: [cm, git]
tags: []
---

* 参考： 
  * [git config](https://git-scm.com/docs/git-config#Documentation/git-config.txt-colorstatusltslotgt)
  * [How to colorize git-status output?](https://stackoverflow.com/questions/12795790/how-to-colorize-git-status-output)
  * []()
  * []()
  * []()



## `color.status.<slot>`

Use customized color for status colorization.
`<slot>` is one of:

* `header` (the header text of the status message),
* `added` or `updated` (files which are added but not committed),
* `changed` (files which are changed but not added in the index),
* `untracked` (files which are not tracked by git),
* `branch` (the current branch), or
* `nobranch` (the color the no branch warning is shown in, defaulting to red).

The values of these variables may be specified as in `color.branch.<slot>`.


The command can also take multiple parameters in quotes. This includes two colors (foreground background) from this list:

~~~
normal, black, red, green, yellow, blue, magenta, cyan and white;
~~~

and it also includes one attribute (style) from this list:

~~~
bold, dim, ul, blink and reverse.
~~~

So this will work:

~~~
# Remember to enable coloring output if it has not been enabled previously:
git config --global color.ui true

git config color.status.changed blue
git config color.status.untracked magenta
git config color.status.changed "blue normal bold"
git config color.status.header "white normal dim"
~~~



## `color.diff.<slot>`


Use customized color for diff colorization. `<slot>` specifies which part of the patch to use the specified color, and is one of 

* `context` (context text - plain is a historical synonym), meta (metainformation), frag (hunk header), func (function in hunk header), old (removed lines), new (added lines), commit (commit headers), whitespace (highlighting whitespace errors), oldMoved (deleted lines), newMoved (added lines), oldMovedDimmed, oldMovedAlternative, oldMovedAlternativeDimmed, newMovedDimmed, newMovedAlternative newMovedAlternativeDimmed (See the <mode> setting of --color-moved in git-diff[1] for details), contextDimmed, oldDimmed, newDimmed, contextBold, oldBold, and newBold (see git-range-diff[1] for details).






## color

The value for a variable that takes a color is a list of colors (at most two, one for foreground and one for background) and attributes (as many as you want), separated by spaces.

The basic colors accepted are normal, black, red, green, yellow, blue, magenta, cyan and white. The first color given is the foreground; the second is the background.

Colors may also be given as numbers between 0 and 255; these use ANSI 256-color mode (but note that not all terminals may support this). If your terminal supports it, you may also specify 24-bit RGB values as hex, like #ff0ab3.

The accepted attributes are bold, dim, ul, blink, reverse, italic, and strike (for crossed-out or "strikethrough" letters). The position of any attributes with respect to the colors (before, after, or in between), doesn’t matter. Specific attributes may be turned off by prefixing them with no or no- (e.g., noreverse, no-ul, etc).

An empty color string produces no color effect at all. This can be used to avoid coloring specific elements without disabling color entirely.

For git’s pre-defined color slots, the attributes are meant to be reset at the beginning of each item in the colored output. So setting color.decorate.branch to black will paint that branch name in a plain black, even if the previous thing on the same output line (e.g. opening parenthesis before the list of branch names in log --decorate output) is set to be painted with bold or some other attribute. However, custom log formats may do more complicated and layered coloring, and the negated forms may be useful there.


## 修改 ~/.gitconfig 来修改颜色

* <https://unix.stackexchange.com/a/44283>
* [How to: Colours in Git](https://nathanhoad.net/how-to-colours-in-git/)



a section `[color]` in your ~/.gitconfig

~~~
[color]
  diff = auto
  status = auto
  branch = auto
  interactive = auto
  ui = true
  pager = true

[color "status"]
  added = green
  changed = red bold
  untracked = magenta bold

[color "branch"]
  remote = yellow
~~~

~~~
[color]
  ui = auto
[color "branch"]
  current = yellow reverse
  local = yellow
  remote = green
[color "diff"]
  meta = yellow bold
  frag = magenta bold
  old = red bold
  new = green bold
[color "status"]
  added = yellow
  changed = green
  untracked = cyan
~~~

~~~
[color]
branch = auto
decorate = auto
diff = auto
grep = auto
interactive = auto
pager = true
showbranch = auto
status = auto
ui = auto

#color slot= [attributes] foreground [background]
#color = 0 - 256 (ANSI); #000000 (24bit Hex); black, red, green, yellow, blue, magenta, cyan, white (ANSI color words); normal (custom Git Color?)
#attributes: bold dim italic ul blink reverse strike

[color "status"]
header = 8
added = 10
changed = 12
untracked = 14
branch = 0 9
nobranch = bold ul blink 12

[color "diff"]
meta = 3
func = 13
frag = 11
context = 8
old = 12 1
new = 10 3
~~~


### 颜色配置文件独立

* [Git-Config Colors And Include](https://tylercipriani.com/blog/2016/09/21/git-config-include-and-colors/)


* ~/.gitconfig

~~~
[color]
    ui = true
[include]
    path = ~/.config/git/colors.config
~~~


* ~/.config/git/color.config

~~~
# Tomorrow Night Eighties in ~/.config/git/tomorrow-night-eighties.config
# Included in ~/.gitconfig via:
# [include]
#     path = ~tyler/.config/git/tomorrow-night-eighties.config
[color "status"]
    header = "#999999"
    added = "#99cc99"
    changed = "#f2777a"
    untracked = "#ffcc66"
    branch = "#2d2d2d" "#6699cc"
    # Because the phrase "Detached HEAD" isn't unnerving enough
    nobranch = bold ul blink "#f99157"
[color "diff"]
    meta = "#515151"
    func = "#cc99cc"
    frag = "#66cccc"
    context = "#999999"
    old = "#f2777a" "#393939"
    new = "#bef2be" "#515151"
~~~









