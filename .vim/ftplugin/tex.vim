setlocal spell spelllang=en_gb
hi clear SpellBad
hi SpellBad cterm=underline

set conceallevel=2
set iskeyword+=:
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=2
let g:vimtex_view_method='zathura'
let g:vimtex_syntax_custom_cmds = [
    \ {'name': 'symbf', 'mathmode': 1, 'argstyle': 'bold', 'conceal': 1},
    \ {'name': 'boldsymbol', 'mathmode': 1, 'argstyle': 'bold', 'conceal': 1},
    \]
