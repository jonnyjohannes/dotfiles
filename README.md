Jonny Johannes's Dotfiles
=========================

Hacking Essentials
------------------

- alacritty: terminal emulator
- brew: homebrew
- git: global config, ignore
- karabiner: for hold-ctrl/tap-esc on mac keyboard
- nvim: (neo)vim configs
- sketchybar: macos toolbar hack
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
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
```
