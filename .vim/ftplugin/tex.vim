" Use concealment. Especially useful for maths. You'll need a good unicode font for this (JuliaMono works well)
set conceallevel=2
set iskeyword+=:
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=2
let g:vimtex_view_method='zathura'
let g:vimtex_syntax_custom_cmds = [
    \ {'name': 'symbf', 'mathmode': 1, 'argstyle': 'bold', 'conceal': 1},
    \ {'name': 'boldsymbol', 'mathmode': 1, 'argstyle': 'bold', 'conceal': 1},
    \]

" SPELL CHECKING
setlocal spell spelllang=en_gb
hi clear SpellBad
hi SpellBad cterm=underline

nnoremap <localleader>c :call ftplugin#tex#ToggleConceal()<cr>

" Check for the presence of the file vimspell.utf-8.add in file dir,
" and set this as the spellfile if found.
let dir = expand('%:p:h')
if filereadable(dir . '/vimspell.utf-8.add')
    let b:spellfile = dir . '/vimspell.utf-8.add'
    let &l:spellfile = b:spellfile
endif
