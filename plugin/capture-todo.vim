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

" Drops todo with date, description and file link at bottom of todo file
function! s:CaptureWithLink(description)
       echon '\r'
       execute 'redir >> ' . g:todo_location
       silent echomsg strftime('%Y-%m-%d') a:description fnameescape(expand('%:p')).':'.line('.')
       silent! redir END
       echom 'Captured in ' . g:todo_location
endfunction

if !exists(":CaptureTodo")
    command! -nargs=1 CaptureTodo :call s:CaptureWithLink("<args>")
endif

nnoremap <Plug>(GotoTodo) :execute ":e" todo_location<CR>
nnoremap <Plug>(CaptureTodo) :CaptureTodo 

if !hasmapto('<Plug>(GotoTodo)')
    nmap <unique> <leader>td <Plug>(GotoTodo)
endif

if !hasmapto('<Plug>(CaptureTodo)')
    nmap <unique> <leader>tc <Plug>(CaptureTodo)
endif
