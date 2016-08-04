# tab titles
PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*} "; echo -ne "\007"'

# prompt information
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="[\e[01;34m\w\e[m]\e[0;32m\$(parse_git_branch)\e[m> "

# PATHs
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/src/bin:$HOME/src/cuby:$PATH

# rbenv and pyenv
eval "$(rbenv init -)"
eval "$(pyenv init -)"

# autocompletion scripts
source $HOME/.dotfiles/git/git-completion.bash

# aliases
alias ls='ls -G'
alias vi='vim'
alias ipython='ipython --pylab'

# keybindings
set -o vi

# set vim as default
export EDITOR=vi
export VISUAL=$EDITOR

# local config file
[[ -s ~/.dotfiles/bash.local ]] && source ~/.dotfiles/bash.local

