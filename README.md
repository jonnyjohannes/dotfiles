# j2de dotfiles

## Hacking Essentials

- alacritty: terminal emulator
- brew: homebrew
- git: global config, ignore
- karabiner: for hold-ctrl/tap-esc on mac keyboard
- mise: runtime environment management
- nvim: (neo)vim configs
- sketchybar: macos toolbar hack
- skhd: hotkey daemon
- starship: prompt
- tmux: terminal multiplexer
- zsh: zshrc

## Installation

```zsh
    git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles

    # $XDG
    #   - alacritty
    #   - brew
    #   - git
    #   - karabiner
    #   - mise
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

## Keymaps

*Leader key: `<Space>`*

### Neovim

#### Basic Vim (vimrc)
| Mode     | Keys        | Action/Function                             |
|----------|-------------|---------------------------------------------|
| Normal   | <C-d>       | Page down and center screen                 |
| Normal   | <C-u>       | Page up and center screen                   |
| Normal   | n           | Next search result and center screen        |
| Normal   | N           | Previous search result and center screen    |
| Normal   | YY          | Yank whole buffer                           |
| Normal   | <leader>l   | Switch to alternate buffer                  |
| Normal   | <leader>x   | Close current window                        |
| Normal   | <leader>z   | Close all other windows (only)              |
| Normal   | <Esc>       | Clear search highlights                     |
| Normal   | ma/ms/md/mf | Set privileged marks A/S/D/F                |
| Normal   | <M-a/s/d/f> | Jump to privileged marks A/S/D/F            |
| Visual   | J           | Move selected lines down                    |
| Visual   | K           | Move selected lines up                      |
| Visual   | <           | Indent left and keep selection              |
| Visual   | >           | Indent right and keep selection             |
| Terminal | <M-Esc>     | Exit terminal mode                          |

#### Navigation & Splits (smart-splits)
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| N/T/X  | <C-h>       | Move cursor to left split                   |
| N/T/X  | <C-j>       | Move cursor to below split                  |
| N/T/X  | <C-k>       | Move cursor to above split                  |
| N/T/X  | <C-l>       | Move cursor to right split                  |
| N/T/X  | <M-h>       | Resize split left                           |
| N/T/X  | <M-j>       | Resize split down                           |
| N/T/X  | <M-k>       | Resize split up                             |
| N/T/X  | <M-l>       | Resize split right                          |
| N/T/X  | <C-M-h>     | Move split left                             |
| N/T/X  | <C-M-j>     | Move split down                             |
| N/T/X  | <C-M-k>     | Move split up                               |
| N/T/X  | <C-M-l>     | Move split right                            |

#### File Pickers (FZF-Lua)
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| N/X    | <leader>:   | Command history                             |
| N/X    | <leader>/   | Live grep (project-wide)                    |
| N      | <leader>*   | Grep word under cursor                      |
| X      | <leader>*   | Grep visual selection                       |
| N/X    | <leader>s   | Smart picker (buffers/files)                |

#### FZF Internal Navigation
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| Any    | <C-d>       | Preview page down                           |
| Any    | <C-u>       | Preview page up                             |
| Any    | <M-p>       | Toggle preview                              |

#### File Tree (nvim-tree)
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| Normal | <leader>t   | Toggle file tree and highlight current file |

#### UI & Utilities (Snacks.nvim)
| Mode     | Keys      | Action/Function                             |
|----------|-----------|---------------------------------------------|
| N/T/X    | <M-n>     | Open scratch buffer                         |
| N/T/X    | <M-t>     | Terminal toggle                             |
| N/T/X    | <M-z>     | Zen mode toggle                             |

#### LSP & Debugging
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| Normal | gd          | Goto definition (FZF UI)                    |
| Normal | gr          | Goto references (FZF UI)                    |
| Normal | K           | Show hover documentation                    |
| Normal | <leader>dr  | Continue debugging (DAP)                    |
| Normal | <leader>db  | Toggle breakpoint (DAP)                     |
| Normal | <leader>dB  | Conditional breakpoint (DAP, prompt)        |

#### REPL Integration (vim-slime + TMUX)
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| Normal | <leader>dl  | Send current line to REPL                   |
| Visual | <leader>dl  | Send selected lines to REPL                 |
| Normal | <leader>dL  | Send whole buffer to REPL                   |
| Visual | <leader>dL  | Send selected lines to REPL                 |

#### Completion (nvim-cmp)
| Mode   | Keys        | Action/Function                             |
|--------|-------------|---------------------------------------------|
| Insert | <C-u>       | Scroll completion docs up                   |
| Insert | <C-d>       | Scroll completion docs down                 |
| Insert | <M-TAB>     | Trigger completion                          |
| Insert | <ESC>       | Abort completion                            |
| Insert | <CR>        | Confirm completion selection                |
| Insert | <TAB>       | Next completion item                        |
| Insert | <S-TAB>     | Previous completion item                    |

#### Custom Commands
| Command | Action/Function                                       |
|---------|-------------------------------------------------------|
| :F      | Unified FZF picker (pickers + aliases)               |
| :S      | Unified Snacks picker (pickers + aliases)            |

### TMUX

*Prefix key: `<C-Space>`*

| Mode     | Keys           | Action/Function                             |
|----------|----------------|---------------------------------------------|
| Normal   | prefix + r     | Reload tmux config                          |
| Normal   | prefix + v     | Enter copy mode                             |
| Normal   | prefix + \|    | Split window horizontally                   |
| Normal   | prefix + -     | Split window vertically                     |
| Normal   | prefix + s     | Launch session selector                     |
| Normal   | prefix + /     | Search forward in copy mode                 |
| Normal   | prefix + ?     | Search backward in copy mode                |
| Copy     | v              | Begin selection                             |
| Copy     | y              | Copy selection and exit                     |
| Normal   | <C-h/j/k/l>    | Navigate panes (with Neovim integration)    |
| Normal   | <M-h/j/k/l>    | Resize panes (with Neovim integration)      |
| Normal   | <C-M-h/j/k/l>  | Swap panes (with Neovim integration)        |


### Karabiner Elements
 
| From Key      | To Key (Tap)  | To Key (Hold)    | Description                    |
|-------------  |---------------|------------------|--------------------------------|
| Caps Lock     | Left Control  | Left Control     | Simple modification            |
| Left Control  | Escape        | Left Control     | control on hold, escape on tap |
| Quote (')     | Quote (')     | Right Option     | option on hold, quote on tap   |


### skhd (System Hotkeys)

#### Application Shortcuts
| Keys              | Action/Function                             |
|-------------------|---------------------------------------------|
| Cmd + Tab         | Trigger Alfred (Cmd + Shift + L)            |
| Cmd + Space       | Open Alfred 5                               |
| Cmd + Q           | Open Arc browser                            |
| Cmd + W           | Open Alacritty terminal                     |
| Alt + Cmd + L     | Lock screen                                 |

#### Window Management (Rectangle)
| Keys                    | Action/Function                             |
|-------------------------|---------------------------------------------|
| Alt + Shift + H         | Left half of screen                         |
| Alt + Shift + J         | Bottom half of screen                       |
| Alt + Shift + K         | Top half of screen                          |
| Alt + Shift + L         | Right half of screen                        |
| Alt + Shift + Return    | Maximize window                             |

#### Vim-style Arrow Keys
| Keys              | Action/Function                             |
|-------------------|---------------------------------------------|
| Ctrl + Cmd + H    | Left arrow                                  |
| Ctrl + Cmd + J    | Down arrow                                  |
| Ctrl + Cmd + K    | Up arrow                                    |
| Ctrl + Cmd + L    | Right arrow                                 |
