"mystuff.vim
"Simon Hulse
"simonhulse@protonmail.com
"Last Edited: Mon 09 Sep 2024 09:21:28 PDT

function mystuff#AddStamp()
    if &filetype != ''
        if (g:add_stamp == 1 && &commentstring != '')
            let current_line = line('.')
            let current_col = col('.')
            let cstring = substitute(&commentstring, '%\(s\)\@!', '%%', '')
            :normal gg
            if stridx(getline(2), 'Simon Hulse') == -1
                let current_line = current_line + 5

                :normal O<esc>dl
                :normal 4.
                call setline(2, printf(cstring, 'Simon Hulse'))
                call setline(3, printf(cstring, 'simonhulse@protonmail.com'))
                call setline(5, '')
            endif
            call setline(1, printf(cstring, expand('%:t')))
            call setline(4, printf(cstring, 'Last Edited: ' . strftime('%c')))
            call cursor(current_line, current_col)
        endif
    endif
endfunction
