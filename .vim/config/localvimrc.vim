if !has_key(get(g:, 'plugs', {}), 'vim-localvimrc') | finish | endif

let g:localvimrc_enable  = 1
let g:localvimrc_ask     = 0
let g:localvimrc_reverse = 1
let g:localvimrc_sandbox = 0
