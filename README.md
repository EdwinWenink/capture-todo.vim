# capture-todo.vim

Vim plugin for capturing a TODO with a link to the current line in the current buffer.
This plugin is intended for use with plain text todo lists, such as todo.txt.
This plugin works nicely together with https://github.com/freitass/todo.txt-vim.

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

```
let g:todo_location="~/Dropbox/todo.txt"
```

If you do not set the location, the line above defines the standard behavior.

## Usage

This plugin defines a single command `:CaptureTodo`  that accepts arguments.
For example:

- `:CaptureTodo this is an example TODO`

This will capture "this is an example TODO" and append it to the bottom of your
TODO file, together with a link to the specific location where you invoked
the command. This command can be invoked directly or using the default mapping

- `<leader>tc`    Mnenomic: todo capture

Additionally, a default mapping is defined to jump the todo file:

- `<leader>td`    Mnemonic: to-do

These default mappings can be overridden in your vimrc as follows:

```vim
nmap <leader>tc <Plug>(CaptureTodo)
nmap <leader>td <Plug>(GotoTodo)
```
