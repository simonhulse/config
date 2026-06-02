if !has_key(get(g:, 'plugs', {}), 'coc.nvim') | finish | endif

let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-java',
  \ 'coc-markdownlint',
  \ 'coc-html',
  \ ]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! ShowDocs() abort
  if index(['vim', 'help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB>       coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR>
  \ coc#pum#visible() ? coc#pum#confirm() :
  \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocs()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap  <silent>         <leader>rn <Plug>(coc-rename)
xmap  <silent>         <leader>f  <Plug>(coc-format-selected)
nmap  <silent>         <leader>f  <Plug>(coc-format-selected)
xmap  <silent><nowait> <leader>a  <Plug>(coc-codeaction-selected)
nmap  <silent><nowait> <leader>a  <Plug>(coc-codeaction-selected)
nmap  <silent><nowait> <leader>ac <Plug>(coc-codeaction-cursor)
nmap  <silent><nowait> <leader>as <Plug>(coc-codeaction-source)
nmap  <silent><nowait> <leader>qf <Plug>(coc-fix-current)
nmap  <silent>         <leader>re <Plug>(coc-codeaction-refactor)
xmap  <silent>         <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap  <silent>         <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap  <silent><nowait> <leader>cl <Plug>(coc-codelens-action)

xmap <silent><nowait> if <Plug>(coc-funcobj-i)
omap <silent><nowait> if <Plug>(coc-funcobj-i)
xmap <silent><nowait> af <Plug>(coc-funcobj-a)
omap <silent><nowait> af <Plug>(coc-funcobj-a)
xmap <silent><nowait> ic <Plug>(coc-classobj-i)
omap <silent><nowait> ic <Plug>(coc-classobj-i)
xmap <silent><nowait> ac <Plug>(coc-classobj-a)
omap <silent><nowait> ac <Plug>(coc-classobj-a)

autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocActionAsync('runCommand', 'editor.action.organizeImport')

nnoremap <silent><nowait> <leader>La :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <leader>Le :<C-u>CocList extensions<CR>
nnoremap <silent><nowait> <leader>Lc :<C-u>CocList commands<CR>
nnoremap <silent><nowait> <leader>Lo :<C-u>CocList outline<CR>
nnoremap <silent><nowait> <leader>Ls :<C-u>CocList -I symbols<CR>
nnoremap <silent><nowait> <leader>Lj :<C-u>CocNext<CR>
nnoremap <silent><nowait> <leader>Lk :<C-u>CocPrev<CR>
