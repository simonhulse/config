if !has_key(get(g:, 'plugs', {}), 'gruvbox') | finish | endif

set background=dark
let g:gruvbox_contrast_dark  = 'hard'
let g:gruvbox_transparent_bg = 1
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
