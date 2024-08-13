" (neo)vim configuration
" for vanilla vim:
"   ln -s ~/.dotfiles/nvim/init.vim ~/.vimrc
set nocompatible

" Leader keymap
let mapleader = ','

" plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'sainnhe/sonokai'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
call vundle#end()

" colours
syntax enable
set termguicolors
let g:sonokai_style = 'shusia'
colorscheme sonokai
hi Visual ctermbg=237 guibg=#4c4c00

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set number                        " Show line numbers.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set splitbelow                    " split horizontal pane to the bottom
set splitright                    " split vertical pane to the right
set clipboard=unnamed             " Share system clipboard
set shiftround                    " use multiple of shiftwidth
set expandtab                     " use softtabs
set mouse=v
set startofline

" airline
let g:airline_theme='sonokai'
let g:airline_extensions = ['branch']
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l/%L : %c'

" fzf
nnoremap <Leader>t :GFiles<CR>
nnoremap <Leader>f :Rg<CR>
