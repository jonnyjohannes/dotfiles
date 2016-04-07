" Vim configuration.
" Copy or symlink to ~/.vimrc.
"
set nocompatible

" Vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'kien/ctrlp.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'jonnyjohannes/vim-charmm'
Plugin 'jonnyjohannes/vim-demon'
call vundle#end()

" syntax highlighting
syntax enable 
set background=dark
colorscheme solarized

filetype plugin indent on         " Turn on file type detection.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set visualbell                    " No beeping.
set laststatus=2                  " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set splitbelow                    " split horizontal pane to the bottom
set splitright                    " split vertical pane to the right
set clipboard=unnamed             " Share system clipboard
set tabstop=2                     " tab size: 2
set shiftwidth=2                  " tab size with `<<`/`>>`: 2
set shiftround                    " use multiple of shiftwidth
set expandtab                     " use softtabs

" file type indentations != 2
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType php setlocal tabstop=4 shiftwidth=4

" file type syntaxes
au BufRead,BufNewFile *.ejs set filetype=html
au BufRead,BufNewFile *.json.jbuilder set filetype=ruby

