" ---Basic stuff---
syntax on             " Syntax highlighting
set splitbelow        " Horizontal window forms below current
set encoding=utf-8    " UTF-8 encoding
set relativenumber    " Line numbering
set splitright        " Vertical window forms to right of current
set timeoutlen=200    " Set so that simply pressing 'o' or 'O' doesn't cause a long hang
set foldmethod=indent " Set fold best on text indentation
set foldlevel=99
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set backspace=indent,eol,start
set noshowmode

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif

set undodir=~/.vim/undo-dir
set undofile

" ---Mappings---
let mapleader = " "
let maplocalleader = "\\"
" Save file with leader instead of colon
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" Enter command mode with ; rather than :
nnoremap ; :
vnoremap ; :
" Window navigations
nnoremap <Down> <C-W><C-J>
nnoremap <Up> <C-W><C-K>
nnoremap <Right> <C-W><C-L>
nnoremap <Left> <C-W><C-H>
" Open vimrc in new window
nnoremap <leader>ev :vnew $MYVIMRC<cr>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Add newline without entering insert mode
nnoremap oo o<esc>k
nnoremap OO O<esc>j
" Move current line below next line
nnoremap - ddp
" Move current line above next line
nnoremap _ dd2kp
" Wrap visually selected text in brackets/quotes
vnoremap <leader>( <esc>`>i)<esc>`<i(<esc>`><cr>
vnoremap <leader>) <esc>`>i)<esc>`<i(<esc>`><cr>
vnoremap <leader>[ <esc>`>i]<esc>`<i[<esc>`><cr>
vnoremap <leader>] <esc>`>i]<esc>`<i[<esc>`><cr>
vnoremap <leader>' <esc>`>i'<esc>`<i'<esc>`><cr>
vnoremap <leader>" <esc>`>i"<esc>`<i"<esc>`><cr>
" Escape insert mode with jk
inoremap jk <esc>
inoremap kj  <esc>
inoremap JK <esc>
inoremap KJ <esc>
" Don't use escape to leave insert mode!
inoremap <esc> <nop>
" Delete line in insert mode
inoremap <c-d> <esc>ddi
" Don't use arrows in insert mode!
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
" Delete contents of line but not line itself
nnoremap dl ddO<esc>

" ---Setup Vundle---
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'frazrepo/vim-rainbow'
Plugin 'dense-analysis/ale'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'itchyny/lightline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable folding

" Write with W
command! W write
" Remove trailing whitespace upon save
autocmd BufWritePre * :%s/\s\+$//e
" Save a file as soon as it is created
autocmd BufNewFile * :write

" Add stamp to top of python scripts
function AddStamp()
    let secondline=getline(2)
    if secondline != '# Simon Hulse'
        :normal gg
        let c = 1
        while c <= 5
            :normal O
            let c += 1
        endwhile
        call setline(2, '# Simon Hulse')
        call setline(3, '# simon.hulse@chem.ox.ac.uk')
        :normal ``
    endif
    call setline(1, '# ' . expand('%:t'))
    call setline(4, '# Last Edited: ' . strftime('%c'))
endfunction

autocmd BufWritePre *.py :call AddStamp()

" Color configuration
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
endif

set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_transparent_bg=1
colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

let g:rainbow_active = 1
