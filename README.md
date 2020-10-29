# Personnal work flow and tools

Main Tools : I3 + Tmux + Zsh + Nvim

![config_screenshot](config_screenshot.png)

## Set up

Full installation (user password and vault password are required)

```bash
# for a local install
./install

# for a remote install
./install install remote_name_server
```

Only update config file (vault password is required)

``` bash
# for a local update
./install update

# for a remote update
./install update remote_name_server
```

# Vim keybinding

## leader

The leader is : **space**

## ctags

File indexing to navigate in code

Command        | Use
---------------|-------------------------
ctags -R .     | In main directory, create tags file
:CC            | Update tags file if it exist at the root project
:UpdateTags    | Update tags file if it exist at the root project

## find files

Command              | Use
---------------------|-------------------------
   in fzf            | ctrl + t : in new tab
   in fzf            | ctrl + x : in split
   in fzf            | ctrl + v : in vsplit
leader + j           | find files (fzf)
leader + l           | find lines (fzf)
leader + t           | find tags (fzf)
leader + s           | find sinppets (fzf)
leader + f           | find tabs (fzf)
leader + bb          | find buffer (fzf)

## find/replace in text

Command                   | Use
--------------------------|-------------------------
Visual_Mode + leader + r  | replace in current file
leader + g                | grep (Rg)
Visual_Mode + gv          | grep (Rg)

## search in file

Command      | Use
-------------|-------------------------
/            | active search mode
leader + l   | find lines (fzf)

## complete

Command                   | Use
--------------------------|-------------------------
tab                       | simple complete
ctrl + space + ctrl space | coc complete

## nerd tree

Command      | Use
-------------|-------------------------
F1           | show Nerd Tree
t            | open in a tab
s            | vertical split
i            | horizontal split
ctrl + ww    | next pane

## switch .h/.cpp

Command      | Use
-------------|-------------------------
leader + A  | switch .h / .cpp

## spell

Command      | Use
-------------|-------------------------
leader + ss  | active spell

## move

Command      | Use
-------------|-------------------------
ctrl + hjkl  | left right up down
leader + cd  | change file directory with current file
leader + /   | vertical split
leader + -   | horizontal split

## buffers

Command               | Use
----------------------|-------------------------
leader + bb           | find buffer
leader + bn           | next buffer
leader + n            | next buffer
leader + bp           | previous buffer
leader + p            | previous buffer
leader + bo           | new buffer
leader + o            | new buffer
leader + ba           | close all buffers
leader + bd           | close current buffer
leader + bc           | close current buffer

## code

Command                | Use
-----------------------|-------------------------
leader + w             | write file
leader + q             | close file
leader + x             | write and close file
u                      | undo
ctrl r                 | redo
< and > (.)            | indent code
Visual_mode + =        | auto indent code
leader + c + space     | comment blocks
ctrl p or ctrl + n     | autocomplete
ctrl o                 | backward
ctrl i                 | forward
:line                  | go to line number
shift + click          | copy text
leader + ] or ctrl + ] | go to definition
leader + P             | toggle paste mode
ctrl + g               | show path file
gt                     | next tab

## command

Command      | Use
-------------|-------------------------
:r!          | command with output in vim file

## shortcut

Command        | Use
---------------|-------------------------
F1             | toggle NerdTree
F2             | vim new buffer
F3             | vim close buffer
F4             | vim prev buffer
F5             | vim next buffer
F6             | vim linenumber
F7             | vim show end line
F8             | tmux previous window
F9             | tmux next window
F12            | make kraken in release

# Tmux keybinding

## leader

The leader is : **ctrl + space**

Command                         | Use
--------------------------------|-------------------------
leader + d                      | detach session
leader + s                      | switch session
leader + n                      | next window
leader + p                      | previous window
leader + hjkl                   | next pane
leader x or ctrl + q            | kill pane
leader + ,                      | rename window
leader + z                      | focus on pane
leader + /                      | vertical split
leader + -                      | horizontal split
leader + ctrl + r               | invoke ranger
leader + r                      | reload .tmux.conf
leader + ctrl + b               | clear pane
leader + ctrl + s               | save pane in ~/tmux.history file
leader + [ or leader + ctrl + v | copy mode
leader + ] or leader + ctrl + p | copy tmux buffer (vim)
leader + f                      | facebook pathPicker
leader + ctrl + k               | switch keyboard (us/fr)
shift + left/right              | move windows +/-1
Alt + arrow                     | Resize Panes

# Vim Versus Tmux

Command               | Use
----------------------|-------------------------
ctrl + hjkl or Arrow  | killer feature vim->tmux, tmux->vim

# Search Files

Command               | Use
----------------------|-------------------------
fzf                   | file finder with autocomp (vim/cd/ssh **[Tab] or ctrl + t)

# Manage Tmux session with tmuxinator

Command                             | Use
------------------------------------|-------------------------
mux <session_name>                  | open or create session
tmux list-sessions                  | list sessions
tmux kill-session -t <session_name> | kill session

