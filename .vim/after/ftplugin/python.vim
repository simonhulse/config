" /home/simonhulse/.vim/after/ftplugin/python.vim
" Simon Hulse
" simonhulse@protonmail.com
" Last Edited: Tue 18 Mar 2025 12:59:02 PM EDT

set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set colorcolumn=88

let python_highlight_all = 1
let g:ale_python_auto_uv = 1
let b:ale_fixers = ['black']
let b:ale_fix_on_save = 1
let b:ale_linters = ['mypy', 'ruff']
