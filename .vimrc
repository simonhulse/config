".vimrc
"Simon Hulse
"simonhulse@protonmail.com
"Last Edited: Mon 09 Sep 2024 08:54:56 PDT

" >>> UNDO FUNCTIONALITY >>>
" Setup undo to work between vim sessions
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" Configure file backups
if !isdirectory($HOME."/.vim/backups")
    call mkdir($HOME."/.vim/backups", "", 0700)
endif

set backup
set backupdir=~/.vim/backups
set backupcopy=yes
" <<< UNDO FUNCTIONALITY <<<

" >>> BASIC SETUP >>>
set nocompatible
syntax on                    " Syntax highlighting
set splitright               " Vertical window forms to right of current
set splitbelow               " Horizontal window forms below current
set encoding=utf-8           " UTF-8 encoding
set number relativenumber    " Line numbering
set so=999                   " Keep the cursor centered
set timeoutlen=200           " Set so that simply pressing 'o' or 'O' doesn't cause a long hang
set foldmethod=indent        " Set fold best on text indentation
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2             "https://github.com/itchyny/lightline.vim/blob/master/README.md#introduction
set noshowmode               " With lightline, there isn't much need for showmode
set foldlevel=99
set mouse=a                  " Allow mouse (mainly so I jump quickly with the cursor)
set backspace=2              " Backspace works in insert mode
set nrformats+=alpha         " Allow alphabetical characters to be iterated with CTRL_A and CTRL_X
" <<< BASIC SETUP <<<

" >>> MAPPINGS >>>
let mapleader = " "
let maplocalleader = "\\"
" Deny visual mode
nnoremap Q <nop>
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
nnoremap _ ddkP
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
" Jump to previous buffer
nnoremap # :b#<cr>
" Paste with initial space
nnoremap <leader>p a<space><esc>p
" Break long line up to the set text wrapping length
nnoremap <leader>b 0v$gq
" <<< MAPPINGS <<<

" >>> PLUGINS >>>
" Uses Vim Plug
" To setup Vim Plug, place `plug.vim`:
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" in ~/.vim/autoload/

call plug#begin()

" General plugins
Plug 'valloric/YouCompleteMe', { 'do': 'python3.9 ./install.py', 'commit': 'd98f896' }
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'embear/vim-localvimrc'
Plug 'itchyny/lightline.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'dense-analysis/ale'

" .py plugins
Plug 'vim-scripts/indentpython.vim'

" .tex plugins
Plug 'lervag/vimtex'

" .rs plugins
Plug 'rust-lang/rust.vim'

" .fish plugins
Plug 'dag/vim-fish'

" .jl plugins
Plug 'JuliaEditorSupport/julia-vim'

call plug#end()
" <<< PLUGINS <<<

" >>> PLUGIN-SPECIFIC MAPPINGS >>>
" Jump between ALE linting errors.
nnoremap <leader>aj :ALENext<cr>
nnoremap <leader>ak :ALEPrevious<cr>
" <<< PLUGIN-SPECIFIC MAPPINGS <<<

" >>> AUTO-COMMANDS >>>
" Write with W
autocmd BufWritePre * :%s/\s\+$//e  " Remove trailing whitespace upon save
autocmd BufNewFile * :write         " Save a file as soon as it is created
" <<< AUTO-COMMANDS <<<

" >>> ADD STAMP UPON SAVE >>>
function AddStamp()
    if &filetype != ''
        if (g:add_stamp == 1)
            let current_line = line('.')
            let current_col = col('.')
            let cstring = substitute(&commentstring, '%\(s\)\@!', '%%', '')
            :normal gg
            if stridx(getline(2), 'Simon Hulse') == -1
                let current_line = current_line + 5

                :normal O<esc>dl
                :normal 4.
                call setline(2, printf(cstring, 'Simon Hulse'))
                call setline(3, printf(cstring, 'simonhulse@protonmail.com'))
                call setline(5, '')
            endif
            call setline(1, printf(cstring, expand('%:t')))
            call setline(4, printf(cstring, 'Last Edited: ' . strftime('%c')))
            call cursor(current_line, current_col)
        endif
    endif
endfunction

let g:add_stamp = 1
autocmd BufWritePre * :call AddStamp()
" <<< ADD STAMP UPON SAVE <<<

" >>> GRUVBOX CONFIGURATION >>>
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_transparent_bg=1
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
endif
" <<< GRUVBOX CONFIGURATION <<<

" >>> UNLTISNIPS CONFIGURATION >>>
let g:UltiSnipsExpandTrigger="<Esc>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" <<< UNLTISNIPS CONFIGURATION <<<

" >>> LOCALVIMRC CONFIGURATION >>>
let g:localvimrc_enable=1
let g:localvimrc_ask=0
let g:localvimrc_reverse=1
let g:localvimrc_sandbox=0
" <<< LOCALVIMRC CONFIGURATION <<<
