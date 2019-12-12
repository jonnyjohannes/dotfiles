JonnyJohannes's Dotfiles
========================
  
Overview
--------

  - input: vim bindings for general inputs
  - git: config file, autocomplete script
  - tmux: terminal multiplexer configurations
  - vim: syntax highlighting, colour theme, etc
  - zsh: aliases, configuration, environment settings

Usage
-----
    
    git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/zsh/inputrc ~/.inputrc
    ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    vim +PluginInstall +qall

