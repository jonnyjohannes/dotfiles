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

## Keymaps

| Layer                            | Mode  | Keys                         | Action                                    |
| -------------------------------- | ----- | ---------------------------- | ----------------------------------------- |
| **Karabiner**                    |       |                              |                                           |
|                                  | —     | Caps Lock                    | → Left Control                            |
|                                  | —     | Left Control (tap / hold)    | Escape / Left Control                     |
|                                  | —     | Quote (tap / hold)           | Quote / Right Option                      |
| **Skhd**                         |       |                              |                                           |
|                                  | —     | Cmd + Tab                    | Trigger Alfred (Cmd + Shift + L)          |
|                                  | —     | Cmd + Space                  | Open Alfred 5                             |
|                                  | —     | Cmd + Q                      | Open Arc browser                          |
|                                  | —     | Cmd + W                      | Open Alacritty terminal                   |
|                                  | —     | Cmd + Alt + L                | Lock screen                               |
|                                  | —     | Cmd + Ctrl + H/J/K/L         | Vim-style arrow keys                      |
|                                  | —     | Cmd + Ctrl + Shift + H/J/K/L | Window half (left/down/up/right)          |
|                                  | —     | Cmd + Ctrl + Shift + Return  | Maximize window                           |
| **Tmux** _(prefix: `<C-Space>`)_ |       |                              |                                           |
|                                  | N     | prefix + r                   | Reload tmux config                        |
|                                  | N     | prefix + v                   | Enter copy mode                           |
|                                  | N     | prefix + \|                  | Split window horizontally                 |
|                                  | N     | prefix + \-                  | Split window vertically                   |
|                                  | N     | prefix + s                   | Launch session selector                   |
|                                  | N     | prefix + /                   | Search forward in copy mode               |
|                                  | N     | prefix + ?                   | Search backward in copy mode              |
|                                  | Copy  | v                            | Begin selection                           |
|                                  | Copy  | y                            | Copy selection and exit                   |
|                                  | N     | \<C-h/j/k/l\>                | Navigate panes (with Neovim integration)  |
|                                  | N     | \<M-h/j/k/l\>                | Resize panes (with Neovim integration)    |
| **Neovim** _(leader: `<Space>`)_ |       |                              |                                           |
|                                  | N     | YY                           | Yank whole buffer                         |
|                                  | N     | \<leader\>l                  | Switch to alternate buffer                |
|                                  | N     | \<leader\>w                  | Write (save) current buffer               |
|                                  | N     | \<leader\>x                  | Close current window                      |
|                                  | N     | \<leader\>z                  | Close all other windows (only)            |
|                                  | N     | \<Esc\>                      | Clear search highlights                   |
|                                  | V     | J / K                        | Move selected lines down / up             |
|                                  | V     | \< / \>                      | Indent left / right and keep selection    |
|                                  | T     | \<M-Esc\>                    | Exit terminal mode                        |
|                                  | N/T/X | \<C-h/j/k/l\>                | Navigate panes (with Tmux integration)    |
|                                  | N/T/X | \<M-h/j/k/l\>                | Resize panes (with Tmux integration)      |
|                                  | N/X   | \<leader\>:                  | Command history                           |
|                                  | N/X   | \<leader\>/                  | Live grep (project-wide)                  |
|                                  | N/X   | \<leader\>\*                 | Grep word under cursor / visual selection |
|                                  | N/X   | \<leader\>f                  | Unified picker (aliases + pickers)        |
|                                  | N/X   | \<leader\>s                  | Buffers + files picker                    |
|                                  | N     | \<leader\>t                  | Toggle file tree @ current file           |
|                                  | N     | \<leader\>N                  | Scratch toggle                            |
|                                  | N     | \<leader\>T                  | Terminal toggle                           |
|                                  | N     | \<leader\>Z                  | Zen mode toggle                           |
|                                  | N     | \<M-R\>                      | Continue debugging (DAP)                  |
|                                  | N     | \<M-r\> / \<M-e\> / \<M-w\>  | Step over / into / out (DAP)              |
|                                  | N     | \<M-x\>                      | Terminate debugging (DAP)                 |
|                                  | N     | \<leader\>db                 | Toggle breakpoint (DAP)                   |
|                                  | N     | \<leader\>dB                 | Conditional breakpoint (DAP, prompt)      |
|                                  | N     | \<leader\>dd                 | Toggle diagnostic virtual display         |
|                                  | N     | \<leader\>dr                 | Toggle DAP view                           |
|                                  | I     | \<M-TAB\>                    | Trigger completion                        |
|                                  | N     | \<leader\>a                  | Toggle harpoon menu                       |
|                                  | N     | \<leader\>\<M-a/s/d/f\>      | Replace harpoon file 1 / 2 / 3 / 4        |
|                                  | N     | \<M-a/s/d/f\>                | Jump to harpoon file 1 / 2 / 3 / 4        |
|                                  | cmd   | :F                           | Unified FZF picker (pickers + aliases)    |
|                                  | cmd   | :S                           | Unified Snacks picker (pickers + aliases) |
