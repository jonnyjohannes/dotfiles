# j2de dotfiles

**Hacking Essentials**

| Tool          | Description                     |
| ------------- | ------------------------------- |
| `alacritty/`  | terminal emulator               |
| `brew/`       | Brewfile — system packages      |
| `git/`        | global config + ignore          |
| `karabiner/`  | hold/tap key behaviour          |
| `mise/`       | runtime environtment management |
| `nvim/`       | (neo)vim configs                |
| `sketchybar/` | macos toolbar hack              |
| `skhd/`       | system hotkey daemon            |
| `starship/`   | shell prompt                    |
| `tmux/`       | terminal multiplexer            |
| `zsh/`        | zshrc                           |

## Installation

```zsh

git clone git://github.com/jonnyjohannes/dotfiles.git ~/j2/dotfiles

# $XDG
ln -s ~/j2/dotfiles ~/.config

# $HOME
ln -s ~/j2/dotfiles/nvim/vimrc ~/.vimrc
ln -s ~/j2/dotfiles/zsh/zshrc ~/.zshrc

```

