let g:rustfmt_autosave = 1

" Comment/uncomment
nnoremap <expr> <leader>c getline(".") =~ '^\s*//' ? '^"_3x' : 'I// <esc>`['
