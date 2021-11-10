set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set colorcolumn=88

let python_highlight_all=1

let g:SimpylFold_fold_import=0
let g:SimpylFold_docstring_preview=1

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let b:ale_fixers = {'python': ['black']}
let b:ale_linters = {'python': ['flake8', 'pydocstyle']}
let b:ale_fix_on_save = 1

" Comment/uncomment
nnoremap <expr> <leader>c getline(".") =~ '^\s*#' ? '^"_2x' : 'I# <esc>`['

iabbrev inp import numpy as np
iabbrev impl import matplotlib as mpl
iabbrev iplt import matplotlib.pyplot as plt
iabbrev quickplot import matplotlib.pyplot as plt<cr>fig, ax = plt.subplots()<cr>ax.plot([x], y)<cr>plt.show()
iabbrev aerrstr assert str(exc_info.value) == ...
iabbrev prop @property
iabbrev statm @staticmethod
iabbrev clsm @classmethod
iabbrev class class Name():<cr>"""Class docstring."""<cr><cr>def __init__(self, ...):<cr>pass
