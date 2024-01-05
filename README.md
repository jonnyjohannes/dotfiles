Jonny Johannes's Dotfiles
=========================

Overview
--------

  - brew: homebrew hacking essentials
  - git: gitconfig, gitignore
  - tmux: tmux.conf
  - vim: (neo)vimrc
  - zsh: zshrc

Usage
-----

```sh
    git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles

    ## $XDG
    ln -s ~/.dotfiles/alacritty ~/.config
    ln -s ~/.dotfiles/vim/vimrc ~/.config/nvim/init.vim
    ln -s ~/.dotfiles/skhd ~/.config
    ln -s ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
    ln -s ~/.dotfiles/tmux ~/.config

    ## $HOME
    ln -s ~/.dotfiles/git ~/.gitconfig
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    vim +PluginInstall +qall
```
