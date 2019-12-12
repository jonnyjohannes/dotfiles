# tab titles
precmd() {print -Pn "\e]0;%m\a"}

# prompt information
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "(%{$fg[green]%}${ref#refs/heads/}%{$reset_color%})"
  fi
}
setopt promptsubst
export PS1='[%{$fg[blue]%}%~%{$reset_color%}]$(git_prompt_info)> '

# enable colours
autoload -U colors
colors
export CLICOLOR=1

# PATHs
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/src/bin:$PATH

# environment managers
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"
eval "$(jenv init -)"

# autocompletion scripts
source $HOME/.dotfiles/git/git-completion.bash

# aliases
alias grep='grep --color'
alias ls='ls -G'
alias vi='vim'

# keybindings
bindkey -v

# set vim as default
export EDITOR=vim
export VISUAL=$EDITOR

# local config file
[[ -s ~/.dotfiles/zsh.local ]] && source ~/.dotfiles/zsh.local

