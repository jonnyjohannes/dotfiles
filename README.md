JonnyJohannes's Dotfiles
========================
  
Overview
--------

  - input: vim bindings for general inputs
  - git: config file, autocomplete script
  - tmux: terminal multiplexer configurations
  - vim: syntax highlighting, colour theme, etc
  - zsh: aliases, configuration, environment settings

Installation
------------
    
    git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/inputrc ~/.inputrc
    ln -s ~/.dotfiles/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/zshrc ~/.zshrc
    vim +PluginInstall +qall

Uninstall
---------

  remove symlinks 

