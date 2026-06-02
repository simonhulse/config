if !has_key(get(g:, 'plugs', {}), 'lightline.vim') | finish | endif

let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste'], ['cocstatus', 'readonly', 'filename', 'modified']],
  \ },
  \ 'component_function': {'cocstatus': 'coc#status'},
  \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
