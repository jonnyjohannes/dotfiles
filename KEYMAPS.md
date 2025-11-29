
## Keymaps

### Karabiner Elements

#### Simple Modifications
| From Key     | To Key       | Description                     |
| ------------ | ------------ | ------------------------------- |
| Caps Lock    | Left Control |  Simple modification            |

#### Complex Modifications
| From Key     | To Key (Tap) | To Key (Hold) | Description                    |
| ------------ | ------------ | ------------- | ------------------------------ |
| Left Control | Escape       | Left Control  | Control on hold, escape on tap |
| Quote (')    | Quote (')    | Right Option  | Option on hold, quote on tap   |


### Skhd (System Hotkeys)

#### Application Shortcuts
| Keys          | Action/Function                  |
| ------------- | -------------------------------- |
| Cmd + Tab     | Trigger Alfred (Cmd + Shift + L) |
| Cmd + Space   | Open Alfred 5                    |
| Cmd + Q       | Open Arc browser                 |
| Cmd + W       | Open Alacritty terminal          |
| Cmd + Alt + L | Lock screen                      |

#### Vim-style Arrow Keys
| Keys           | Action/Function |
| -------------- | --------------- |
| Cmd + Ctrl + H | Left arrow      |
| Cmd + Ctrl + J | Down arrow      |
| Cmd + Ctrl + K | Up arrow        |
| Cmd + Ctrl + L | Right arrow     |

#### Window Management (Rectangle)
| Keys                        | Action/Function       |
| --------------------------- | --------------------- |
| Cmd + Ctrl + Shift + H      | Left half of screen   |
| Cmd + Ctrl + Shift + J      | Bottom half of screen |
| Cmd + Ctrl + Shift + K      | Top half of screen    |
| Cmd + Ctrl + Shift + L      | Right half of screen  |
| Cmd + Ctrl + Shift + Return | Maximize window       |


### Tmux

*Prefix key: `<C-Space>`*

| Mode | Keys            | Action/Function                          |
| ---- | --------------- | ---------------------------------------- |
| N    | prefix + r      | Reload tmux config                       |
| N    | prefix + v      | Enter copy mode                          |
| N    | prefix + \|     | Split window horizontally                |
| N    | prefix + \-     | Split window vertically                  |
| N    | prefix + s      | Launch session selector                  |
| N    | prefix + /      | Search forward in copy mode              |
| N    | prefix + ?      | Search backward in copy mode             |
| Copy | v               | Begin selection                          |
| Copy | y               | Copy selection and exit                  |
| N    | \<C-h/j/k/l\>   | Navigate panes (with Neovim integration) |
| N    | \<M-h/j/k/l\>   | Resize panes (with Neovim integration)   |


### Neovim

*Leader key: `<Space>`*

#### Basic Vim (vimrc)
| Mode | Keys          | Action/Function                          |
| ---- | ------------- | ---------------------------------------- |
| N    | \<C-d\>       | Page down and center screen              |
| N    | \<C-u\>       | Page up and center screen                |
| N    | n             | Next search result and center screen     |
| N    | N             | Previous search result and center screen |
| N    | YY            | Yank whole buffer                        |
| N    | \<leader\>l   | Switch to alternate buffer               |
| N    | \<leader\>w   | Write (save) current buffer              |
| N    | \<leader\>x   | Close current window                     |
| N    | \<leader\>z   | Close all other windows (only)           |
| N    | \<Esc\>       | Clear search highlights                  |
| V    | J             | Move selected lines down                 |
| V    | K             | Move selected lines up                   |
| V    | \<            | Indent left and keep selection           |
| V    | \>            | Indent right and keep selection          |
| T    | \<M-Esc\>     | Exit terminal mode                       |

#### Navigation & Splits (smart-splits)
| Mode  | Keys            | Action/Function                        |
| ----- | --------------- | -------------------------------------- |
| N/T/X | \<C-h/j/k/l\>   | Navigate panes (with Tmux integration) |
| N/T/X | \<M-h/j/k/l\>   | Resize panes (with Tmux integration)   |

#### File Pickers (FZF-Lua)
| Mode | Keys        | Action/Function                     |
| ---- | ----------- | ----------------------------------- |
| N/X  | \<leader\>: | Command history                     |
| N/X  | \<leader\>/ | Live grep (project-wide)            |
| N    | \<leader\>* | Grep word under cursor              |
| X    | \<leader\>* | Grep visual selection               |
| N/X  | \<leader\>f | Unified picker (aliases + pickers)  |
| N/X  | \<leader\>s | Buffers + files picker              |

#### FZF Internal Navigation
| Mode | Keys    | Action/Function   | 
| ---- | ------- | ----------------- |
| fzf  | \<C-d\> | Preview page down |
| fzf  | \<C-u\> | Preview page up   |
| fzf  | \<M-p\> | Toggle preview    |

#### File Tree (nvim-tree)
| Mode | Keys        | Action/Function                 |
| ---- | ----------- | ------------------------------- |
| N    | \<leader\>t | Toggle file tree @ current file |

#### UI & Utilities (Snacks.nvim)
| Mode | Keys        | Action/Function     |
| ---- | ----------- | ------------------- |
| N    | \<leader\>N | Scratch toggle      |
| N    | \<leader\>T | Terminal toggle     |
| N    | \<leader\>Z | Zen mode toggle     |

#### LSP & Debugging
| Mode | Keys         | Action/Function                      |
| ---- | ------------ | ------------------------------------ |
| N    | gd           | Goto definition (FZF UI)             |
| N    | gr           | Goto references (FZF UI)             |
| N    | K            | Show hover documentation             |
| N    | \<M-R\>      | Continue debugging (DAP)             |
| N    | \<M-r\>      | Step over (DAP)                      |
| N    | \<M-e\>      | Step into (DAP)                      |
| N    | \<M-w\>      | Step out (DAP)                       |
| N    | \<M-x\>      | Terminate debugging (DAP)            |
| N    | \<leader\>db | Toggle breakpoint (DAP)              |
| N    | \<leader\>dB | Conditional breakpoint (DAP, prompt) |
| N    | \<leader\>dd | Toggle diagnostic virtual display    |
| N    | \<leader\>dr | Toggle DAP view                      |

#### REPL Integration (vim-slime)
| Mode | Keys         | Action/Function             |
| ---- | ------------ | --------------------------- |
| N    | \<leader\>dl | Send current line to REPL   |
| X    | \<leader\>dl | Send selected lines to REPL |
| N    | \<leader\>dL | Send whole buffer to REPL   |
| X    | \<leader\>dL | Send selected lines to REPL |

#### Completion (nvim-cmp)
| Mode | Keys      | Action/Function              |
| ---- | --------- | ---------------------------- |
| I    | \<C-u\>   | Scroll completion docs up    |
| I    | \<C-d\>   | Scroll completion docs down  |
| I    | \<M-TAB\> | Trigger completion           |
| I    | \<ESC\>   | Abort completion             |
| I    | \<CR\>    | Confirm completion selection |
| I    | \<TAB\>   | Next completion item         |
| I    | \<S-TAB\> | Previous completion item     |

#### Harpoon (File Navigation)
| Mode | Keys        | Action/Function                        |
| ---- | ----------- | -------------------------------------- |
| N    | \<M-a\>     | Jump to harpoon file 1                 |
| N    | \<M-s\>     | Jump to harpoon file 2                 |
| N    | \<M-d\>     | Jump to harpoon file 3                 |
| N    | \<M-f\>     | Jump to harpoon file 4                 |
| N    | \<M-g\>     | Add current file + toggle harpoon menu |

#### Custom Commands
| Command | Action/Function                           |
| ------- | ----------------------------------------- |
| :F      | Unified FZF picker (pickers + aliases)    |
| :S      | Unified Snacks picker (pickers + aliases) |


