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

function! capture#with_link(description, destination)
    " Drops todo with date, description and file link at bottom of todo file
    execute 'redir >> ' . a:destination
    silent echomsg strftime('%Y-%m-%d') a:description fnameescape(expand('%:p')).':'.line('.')
    silent! redir END
    echom 'Captured in ' . a:destination
endfunction

function! capture#move_to(destination)
    " Cut the current line and move it to your todo location
    let l:todo = []
    call add(l:todo, getline(line(".")))|d
    call s:AppendToFile(l:todo, a:destination)
    echom 'Moved todo to ' . a:destination
endfunction

