" File:        capture-todo.vim
" Description: capture a todo with a file link in your todo.txt
" Author:      Edwin Wenink
" License:     MIT

" This file only needs to be loaded once
if exists("g:loaded_todo_capture")
    finish
endif
let g:loaded_todo_capture=1

" Default location for your todo.txt file.
if !exists('g:todo_location')
    let g:todo_location = "~/Dropbox/todo.txt"
endif

" Default location for the optional inbox.todo.txt file.
" If not specified, will be the same as your todo location
if !exists('g:inbox_location')
    let g:inbox_location = g:todo_location
endif

" Expand paths
let g:todo_location = expand(g:todo_location)
let g:inbox_location = expand(g:inbox_location)

nnoremap <Plug>(CaptureTodo) :CaptureTodo 
nnoremap <Plug>(GotoTodoInbox) :execute ":e" inbox_location<CR>
nnoremap <Plug>(SetTodo) :SetTodo<CR>
nnoremap <Plug>(GotoTodo) :execute ":e" todo_location<CR>

if !exists(":CaptureTodo")
    command! -nargs=1 CaptureTodo :call capture#with_link("<args>")
endif

if !exists(":SetTodo")
    command! SetTodo :call capture#set_todo()
endif

if !hasmapto('<Plug>(CaptureTodo)')
    nmap <unique> <leader>tc <Plug>(CaptureTodo)
endif

if !hasmapto('<Plug>(GotoTodoInbox)')
    nmap <unique> <leader>ti <Plug>(GotoTodoInbox)
endif

if !hasmapto('<Plug>(SetTodo)')
    nmap <unique> <leader>ts <Plug>(SetTodo)
endif

if !hasmapto('<Plug>(GotoTodo)')
    nmap <unique> <leader>td <Plug>(GotoTodo)
endif
