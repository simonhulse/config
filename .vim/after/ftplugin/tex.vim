" .vim/after/ftplugin/tex.vim
" Simon Hulse
" simonhulse@protonmail.com
" Last Edited: Mon 09 Sep 2024 04:33:19 PM EDT

set conceallevel=2
nnoremap <localleader>c :let &conceallevel = -1 * &conceallevel + 2<cr>

set iskeyword+=:

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

" Check for the presence of the file vimspell.utf-8.add in file dir,
" and set this as the spellfile if found.
let dir = getcwd()
if filereadable(dir . '/vimspell.utf-8.add')
    let b:spellfile = dir . '/vimspell.utf-8.add'
    let &l:spellfile = b:spellfile
endif
