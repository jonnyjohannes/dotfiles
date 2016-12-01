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
export PS1='[%{$fg_bold[cyan]%}%~%{$reset_color%}]$(git_prompt_info)> '

# enable colours
autoload -U colors
colors
export CLICOLOR=1

# PATHs
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/src/bin:$HOME/src/cuby:$PATH

# rbenv and pyenv initialization
eval "$(rbenv init -)"
eval "$(pyenv init -)"

# autocompletion scripts
source $HOME/.dotfiles/git/git-completion.bash

# aliases
alias ls='ls -G'
alias vi='vim'
alias ipython='ipython --pylab'

# keybindings
bindkey -v

# set vim as default
export EDITOR=vim
export VISUAL=$EDITOR

# local config file
[[ -s ~/.dotfiles/zsh.local ]] && source ~/.dotfiles/zsh.local

