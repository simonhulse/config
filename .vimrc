" vim-plug bootstrap
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let backup_dir = $HOME . '/.vim/backup'
if !isdirectory(backup_dir)
  call mkdir(backup_dir, 'p', 0700)
endif

" Options (nocompatible, encoding, syntax, backspace are neovim defaults)
set nocompatible
set encoding=utf-8
syntax on
set backspace=2
set splitright splitbelow
set number relativenumber
set scrolloff=999
set timeoutlen=200
set tabstop=4 shiftwidth=4 expandtab
set laststatus=2 noshowmode
set updatetime=300
set signcolumn=yes
set mouse=a
set undofile swapfile backup backupcopy=yes
let &backupdir = backup_dir
set nrformats+=alpha

if has('termguicolors')
  set termguicolors
endif

let g:tex_flavor = 'latex'

" Leaders
let mapleader = ' '
let maplocalleader = '\'

" Keymaps
nnoremap Q           <nop>
nnoremap <leader>w   :w<CR>
nnoremap <leader>q   :q<CR>
nnoremap <leader>bd  :%bd\|e#<CR>
nnoremap ;           :
vnoremap ;           :
nnoremap <Down>      <C-W><C-J>
nnoremap <Up>        <C-W><C-K>
nnoremap <Right>     <C-W><C-L>
nnoremap <Left>      <C-W><C-H>
nnoremap <leader>ev  :vnew $MYVIMRC<CR>
nnoremap <leader>sv  :source $MYVIMRC<CR>
nnoremap oo          o<Esc>k
nnoremap OO          O<Esc>j
nnoremap -           ddp
nnoremap _           ddkP
inoremap jk          <Esc>
inoremap kj          <Esc>
inoremap JK          <Esc>
inoremap KJ          <Esc>
inoremap <Left>      <nop>
inoremap <Right>     <nop>
inoremap <Up>        <nop>
inoremap <Down>      <nop>
nnoremap dl          ddO<Esc>
nnoremap #           :b#<CR>
nnoremap <leader>p   a <Esc>p
nnoremap <leader>b   0v$gq
nnoremap <leader>l   :AsyncRun ls

" Autocmds
autocmd BufWritePre * if &filetype !=# 'markdown' | %s/\s\+$//e | endif

" Plugins
call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'SirVer/ultisnips'
Plug 'embear/vim-localvimrc'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
Plug 'lifepillar/pgsql.vim'
Plug 'lepture/vim-jinja'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_transparent_bg = 1
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" lightline
let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste'], ['cocstatus', 'readonly', 'filename', 'modified']],
  \ },
  \ 'component_function': {'cocstatus': 'coc#status'},
  \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" UltiSnips
let g:UltiSnipsExpandTrigger      = '<Esc>'
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsEditSplit           = 'vertical'
let g:UltiSnipsSnippetDirectories  = [$HOME . '/.config/snippets']

" vim-localvimrc
let g:localvimrc_enable  = 1
let g:localvimrc_ask     = 0
let g:localvimrc_reverse = 1
let g:localvimrc_sandbox = 0

" coc.nvim
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
