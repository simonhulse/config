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

for s:f in split(glob($HOME . '/.vim/config/*.vim'), '\n')
  execute 'source ' . fnameescape(s:f)
endfor
