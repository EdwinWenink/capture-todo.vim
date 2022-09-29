function! s:AppendToFile(to_append, file_location)

    if !filewritable(a:file_location)
        echoerr "Can't write to location " . a:file_location
        return
    endif

    let l:lines = []
    call extend(l:lines, readfile(a:file_location))
    call extend(l:lines, a:to_append) 
    call writefile(l:lines, a:file_location)
endfunction

function! capture#with_link(description)
    " Drops todo with date, description and file link at bottom of todo file
    execute 'redir >> ' . g:inbox_location
    silent echomsg strftime('%Y-%m-%d') a:description fnameescape(expand('%:p')).':'.line('.')
    silent! redir END
    echom 'Captured in ' . g:inbox_location
endfunction

function! capture#set_todo()
    " Cut the current line and move it to your todo location
    let l:todo = []
    call add(l:todo, getline(line(".")))|d
    call s:AppendToFile(l:todo, g:todo_location)
    echom 'Moved todo to ' . g:todo_location
endfunction

