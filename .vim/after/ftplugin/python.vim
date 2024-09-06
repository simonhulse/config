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
