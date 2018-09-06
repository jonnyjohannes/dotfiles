" Vim configuration.
" Copy or symlink to ~/.vimrc.
"
set nocompatible

" Vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'elixir-lang/vim-elixir'
Plugin 'jonnyjohannes/vim-charmm'
Plugin 'jonnyjohannes/vim-demon'
Plugin 'kien/ctrlp.vim'
Plugin 'lervag/vimtex'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tyrannicaltoucan/vim-quantum'
Plugin 'vim-airline/vim-airline'
call vundle#end()

" syntax highlighting
syntax enable
set background=dark
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
set termguicolors
let g:quantum_black=1
colorscheme quantum
hi! Normal guibg=NONE
hi! Search guibg=HotPink
hi! IncSearch guibg=HotPink

filetype plugin indent on         " Turn on file type detection.

set backspace=indent,eol,start    " Intuitive backspacing.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set number                        " Show line numbers.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set laststatus=2                  " Show the status line all the time
set splitbelow                    " split horizontal pane to the bottom
set splitright                    " split vertical pane to the right
set clipboard=unnamed             " Share system clipboard
set tabstop=2                     " tab size: 2
set shiftwidth=2                  " tab size with `<<`/`>>`: 2
set shiftround                    " use multiple of shiftwidth
set expandtab                     " use softtabs

" airline config
let g:airline_theme='quantum'
let g:airline_extensions = []
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l/%L : %c'

