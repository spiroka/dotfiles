filetype plugin indent on
syntax on

runtime macros/matchit.vim

set autoindent
set expandtab " replace tabs with spaces
set shiftwidth=2 " tab size
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
set hidden
set incsearch
set ruler
set wildmenu
set autowriteall
set noswapfile
set number " show line numbers
set nowrap
set mouse=a
set cursorline

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
:helptags ~/.vim/bundle/ctrlp.vim/doc
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|git'

" Moving lines
vnoremap <C-j> :m '>+1<CR>gv=gv 
vnoremap <C-k> :m '<-2<CR>gv=gv 
