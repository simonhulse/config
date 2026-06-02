if !has_key(get(g:, 'plugs', {}), 'ultisnips') | finish | endif

let g:UltiSnipsExpandTrigger      = '<Esc>'
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsEditSplit           = 'vertical'
let g:UltiSnipsSnippetDirectories  = [$HOME . '/.config/snippets']
