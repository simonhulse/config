" /home/simonhulse/.vim/autoload/mystuff.vim
" Simon Hulse
" simonhulse@protonmail.com
" Last Edited: Thu 26 Sep 2024 10:49:04 AM EDT


function mystuff#AddStamp()
    if &filetype != ''
        if (g:add_stamp == 1 && &commentstring != '')
            let current_line = line('.')
            let current_col = col('.')
            let cstring = substitute(&commentstring, '%\(s\)\@!', '%%', '')

            let firstline = 1
            " Deal with shebang
            if getline(1) =~ '^#!'
                let firstline = 3
            end

            call cursor(firstline, 1)
            if stridx(getline(firstline + 1), 'Simon Hulse') == -1
                let current_line = current_line + 5

                :normal O<esc>dl
                :normal 4.
                call setline(firstline + 1, printf(cstring, 'Simon Hulse'))
                call setline(firstline + 2, printf(cstring, 'simonhulse@protonmail.com'))
                call setline(firstline + 4, '')
            endif
            call setline(firstline, printf(cstring, expand('%:.')))
            call setline(firstline + 3, printf(cstring, 'Last Edited: ' . strftime('%c')))
            call cursor(current_line, current_col)
        endif
    endif
endfunction
