" Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

" must come first because it changes other options
set nocompatible

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

" tabs and spacing: default of softtabs, 2 spaces 
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType php setlocal tabstop=4 shiftwidth=4

" file type syntaxes
au BufRead,BufNewFile *charmm.* set filetype=charmm
au! Syntax charmm source $HOME/.vim/syntax/charmm.vim

au BufRead,BufNewFile *deMon.* set filetype=deMon
au! Syntax deMon source $HOME/.vim/syntax/demon.vim

au BufRead,BufNewFile *.ejs set filetype=html

au BufRead,BufNewFile *.json.jbuilder set filetype=ruby

