set nocompatible              " be iMproved, required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" to install plugins run this from bash: vim +PluginInstall +qall
Plugin 'Valloric/YouCompleteMe'
Plugin 'WolfgangMehner/vim-plugins'
Plugin 'sirtaj/vim-openscad'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/andreimaxim/vim-io'
Plugin 'majutsushi/tagbar'
Plugin 'git@github.com:jeffkreeftmeijer/vim-numbertoggle.git'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on    " required

let g:ycm_global_ycm_extra_conf = "~/ycm_extra_conf.py"
let mapleader=","

set number
syntax enable

map <space> @q
map j gj
map k gk
map <C-m> :make <enter>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>w  :w<cr>
map <leader>x  :x<cr>
map <leader>q  :q<cr>
map <leader>t  :tabe<space>
map <F1> :nohlsearch<cr>
map <F2> :NERDTreeToggle<cr>
map <F3> :TagbarToggle<cr>

colorscheme desert
set mouse=a
set autoindent
set expandtab
set hlsearch
set wildmenu
set showmatch


set relativenumber
"use relative numbering only when vim is in focus
au FocusLost * :set number
au FocusGained * :set relativenumber

"use absolue numbering in insert mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


set tabstop=4
set shiftwidth=4
set colorcolumn=80
set cino=:0,(0

set backspace=indent,eol,start

nnoremap j gj
nnoremap k gk

nnoremap <leader>gt :YcmCompleter GoTo<cr>

set ignorecase
set smartcase
set incsearch
set visualbell
set ruler
set history=700

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"use $(leader)b or $(leader)B to insert breakpoints in python code --zack
au FileType python map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" spelling Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


