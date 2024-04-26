set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set colorcolumn=88

let python_highlight_all=1
let b:ale_fixers = []
let b:ale_fix_on_save = 1
let b:ale_linters = ['flake8']
let b:ale_python_flake8_options = '--ignore=E203,E731,E741,W504,E501 --per-file-ignores=__init__.py:E402,F401'

" Add stamp to top of python scripts
let g:add_stamp=1
function AddStamp()
    if (g:add_stamp == 1)
        let secondline = getline(2)
        if secondline != '# Simon Hulse'
            :normal gg
            let c = 1
            while c <= 5
                :normal O
                let c += 1
            endwhile
            call setline(2, '# Simon Hulse')
            call setline(3, '# simonhulse@protonmail.com')
            :normal ``
        endif
        call setline(1, '# ' . expand('%:t'))
        call setline(4, '# Last Edited: ' . strftime('%c'))
    endif
endfunction

autocmd BufWritePre :call AddStamp()
