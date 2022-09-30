# capture-todo.vim

Vim plugin for capturing a TODO with a link to the current line in the current buffer.
This plugin is intended for use with plain text todo lists, such as todo.txt.
This plugin works nicely together with https://github.com/freitass/todo.txt-vim.

Also see `:help capture-todo` after installation.

## Description

Do you often have small tasks popping up in your thoughts when you are working
on something? This small plugin helps you quickly capture these TODOs without
leaving the current buffer and interrupting your work flow. Moreover, often
these TODOs will be related to the work you are currently doing. When capturing
a TODO, this plugin therefore includes a link to the file and line number you
were editing at the moment of capturing the TODO.

For example, capturing an example TODO when editing this help file will write
the following to my todo.txt file:

`2022-09-26 example TODO C:/Users/Edwin\ Wenink/vimfiles/doc/capture-todo.txt:21`

When going through your todo.txt, you can quickly pick up where you left off
using Vim's default `gF` (go to file) normal mode command. If you do not need
the file link, just remove it later or ignore it.

## Installation

When using a plugin manager like `Plug`, add the following to your `vimrc`:

```vim
Plug 'EdwinWenink/capture-todo.vim'
```

## Setup

You need to tell this plugin where your plain text todo file is located.
This is done by setting the following in your vimrc:

```vim
let g:todo_location="~/Dropbox/todo.txt"
```

If you do not set the location, the line above defines the standard behavior.

You can optionally also set a separate "inbox" file:

```vim
let g:inbox_location = "~/Dropbox/inbox.todo.txt"
```

If you do not set your inbox file, the location will be equal to your todo file.
In this case, captured notes will be written to the inbox file. The idea behind
this functionality is that the inbox serves as a backlog, so that the todo.txt
can be used to list things you will do on the short term (for example today or
this week). This way you can capture all your thoughts without cluttering your
main todo.txt file.

N.B. it is recommended to name your files following the pattern `*.todo.txt`.
This way the `todo.txt` Vim plugin will correctly set the filetype to `todo`.
This plugin is not a filetype plugin and works with any text file.

## Usage

This plugin defines a single command `:CaptureTodo`  that accepts arguments.
For example:

- `:CaptureTodo this is an example TODO`

This will capture "this is an example TODO" and append it to the bottom of your
TODO file, together with a link to the specific location where you invoked
the command. This command can be invoked directly or using the default mapping

- `<leader>tc`    Mnemonic: todo capture

Additionally, a default mapping is defined to jump the todo file or the index file:

- `<leader>td`    Mnemonic: to do
- `<leader>ti`    Mnemonic: to inbox

These default mappings can be overridden in your vimrc as follows:

```vim
nmap <leader>tc <Plug>(CaptureTodo)
nmap <leader>td <Plug>(GotoTodo)
nmap <leader>ti <Plug>(GotoTodoInbox)
```

Two additional commands are defined for moving the TODO on the current line to 
your inbox file or your todo file. If you have not set your inbox file, the 
mappings will do the same thing and move the current line to your todo file.

```vim
nmap <unique> <leader>mt <Plug>(MoveToTodo)
nmap <unique> <leader>mi <Plug>(MoveToInbox)
```
