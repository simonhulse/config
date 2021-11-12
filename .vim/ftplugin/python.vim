set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set colorcolumn=88

let python_highlight_all=1
let b:ale_fixers = ['black']
let b:ale_fix_on_save = 1
let b:ale_linters = ['flake8', 'pydocstyle']

" When I have time, I will improve the with UltiSnips
iabbrev inp import numpy as np
iabbrev impl import matplotlib as mpl
iabbrev iplt import matplotlib.pyplot as plt
iabbrev quickplot import matplotlib.pyplot as plt<cr>fig, ax = plt.subplots()<cr>ax.plot([x], y)<cr>plt.show()
iabbrev aerrstr assert str(exc_info.value) == ...
iabbrev prop @property
iabbrev statm @staticmethod
iabbrev clsm @classmethod
iabbrev class class Name():<cr>"""Class docstring."""<cr><cr>def __init__(self, ...):<cr>pass
