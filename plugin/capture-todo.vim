" File:        capture-todo.vim
" Description: capture a todo with a file link in your todo.txt
" Author:      Edwin Wenink
" License:     MIT

" TODO refactor with namespace en funcs in autoload, e.g. function! capture#todo#with_link(description)

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

function! s:CaptureWithLink(description)
    " Drops todo with date, description and file link at bottom of todo file
    execute 'redir >> ' . g:inbox_location
    silent echomsg strftime('%Y-%m-%d') a:description fnameescape(expand('%:p')).':'.line('.')
    silent! redir END
    echom 'Captured in ' . g:inbox_location
endfunction

function! s:SetTodo()
    " Cut the current line and move it to your todo location
    if !filewritable(g:todo_location)
        echoerr "Can't write to todo location " . g:todo_location
        return
    endif

    let l:todo = []
    let l:lines = []
    call add(l:todo, getline(line(".")))|d
    " Read in todo file as variable
    call extend(l:lines, readfile(g:todo_location))
    " Add the new todo
    call extend(l:lines, l:todo) 
    " Write back to file
    call writefile(l:lines, g:todo_location)
    echom 'Moved todo to ' . g:todo_location
endfunction

nnoremap <Plug>(CaptureTodo) :CaptureTodo 
nnoremap <Plug>(GotoTodoInbox) :execute ":e" inbox_location<CR>
nnoremap <Plug>(SetTodo) :SetTodo<CR>
nnoremap <Plug>(GotoTodo) :execute ":e" todo_location<CR>

if !exists(":CaptureTodo")
    command! -nargs=1 CaptureTodo :call s:CaptureWithLink("<args>")
endif

if !exists(":SetTodo")
    command! SetTodo :call s:SetTodo()
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
