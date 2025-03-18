Jonny Johannes's Dotfiles
=========================

Hacking Essentials
------------------

    - alacritty: terminal emulator
    - brew: homebrew
    - git: global config, ignore
    - nvim: (neo)vim configs
    - skhd: hotkey daemon
    - starship: prompt
    - tmux: terminal multiplexer
    - zsh: zshrc

Installation
------------

```zsh
    git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles

    # $XDG
    #   - alacritty 
    #   - brew
    #   - git
    #   - nvim
    #   - sketchybar
    #   - skhd
    #   - starship
    #   - tmux
    ln -s ~/.dotfiles/ ~/.config

    # $HOME
    #   - vim 
    #   - zsh
    ln -s ~/.dotfiles/nvim/vimrc ~/.vimrc
    vim +PluginInstall +qall
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
```
