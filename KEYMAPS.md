# Keymaps

Custom bindings in the checked-in configs.

| Layer                            | Mode | Keys                          | Action                                     |
| -------------------------------- | ---- | ----------------------------- | ------------------------------------------ |
| **karabiner**                    | —    | Caps Lock                     | Left Control                               |
|                                  | —    | Left Control (tap / hold)     | Escape / Left Control                      |
|                                  | —    | Quote (tap / hold)            | Quote / Right Option                       |
| **skhd**                         |      |                               |                                            |
|                                  | —    | Cmd + Tab / Cmd + Space       | Open Alfred 5                              |
|                                  | —    | Cmd + Q / Cmd + W             | Open Arc / Alacritty                       |
|                                  | —    | Cmd + Alt + L                 | Open screen saver (lock screen)            |
|                                  | —    | Cmd + Ctrl + H/J/K/L          | Send Left/Down/Up/Right arrow keys         |
|                                  | —    | Cmd + Ctrl + U/D              | Send Page Up / Page Down                   |
|                                  | —    | Cmd + Ctrl + Shift + H/J/K/L  | Move window to left/bottom/top/right half  |
|                                  | —    | Cmd + Ctrl + Shift + Return   | Maximize window                            |
| **tmux** _(prefix: `<C-space>`)_ |      |                               |                                            |
|                                  | N    | `<C-H/J/K/L>`                 | Navigate panes (between nvim too)          |
|                                  | N    | `<M-H/J/K/L>`                 | Resize panes (between nvim too)            |
|                                  | N    | `<prefix>r`                   | Reload tmux config                         |
|                                  | N    | `<prefix>v`                   | Enter copy mode                            |
|                                  | N    | `<prefix>\|`                  | Split horizontally                         |
|                                  | N    | `<prefix>\-`                  | Split vertically                           |
|                                  | N    | `<prefix>s`                   | Launch selector                            |
|                                  | N    | `<prefix>\/`                  | Search forward                             |
|                                  | N    | `<prefix>/?`                  | Search backward                            |
|                                  | N    | `<prefix>b`                   | Break pane into a new window               |
|                                  | N    | `<prefix>j`                   | Join pane to the (prompted) window         |
|                                  | N    | `<prefix>L`                   | Switch to the last client                  |
|                                  | Copy | `<prefix>v`                   | Begin selection                            |
|                                  | Copy | `<prefix>y`                   | Copy and exit                              |
| **(n)vim** _(leader: `<space>`)_ |      |                               |                                            |
|                                  | N    | `YY`                          | Yank the whole buffer                      |
|                                  | N    | `<leader>l`                   | Last buffer                                |
|                                  | N    | `<leader>w`                   | Write buffer                               |
|                                  | N    | `<leader>x`                   | Close window                               |
|                                  | N    | `<leader>z`                   | Close other windows                        |
|                                  | V    | `J` / `K`                     | Move selected lines down / up              |
|                                  | V    | `<` / `>`                     | Indent and keep selection                  |
|                                  | X/O  | `iC` / `aC`                   | Select inside / around a fenced code block |
|                                  | N    | `<leader>t`                   | Toggle file tree at the current file       |
|                                  | N    | `<leader>N`                   | Open scratch buffer                        |
|                                  | N    | `<leader>T`                   | Focus terminal                             |
|                                  | N    | `<leader>Z`                   | Toggle Zen mode                            |
|                                  | N/X  | `<leader>:`                   | Command history                            |
|                                  | N/X  | `<leader>/`                   | Grep                                       |
|                                  | N/X  | `<leader>*`                   | Grep word or visual selection              |
|                                  | N/X  | `<leader>f`                   | Files                                      |
|                                  | N/X  | `<leader>s`                   | Buffers                                    |
|                                  | N/X  | `<leader>d`                   | Unified Snacks picker                      |
|                                  | I    | `<M-Tab>`                     | Open completion menu                       |
|                                  | N    | `gd` / `gr` _(LSP attached)_  | LSP definitions / references picker        |
|                                  | N    | `<M-R>` _(LSP attached)_      | Continue debugging                         |
|                                  | N    | `<leader>DD` _(LSP attached)_ | Toggle DAP view                            |
|                                  | N    | `<leader>Dd`                  | Toggle diagnostic virtual text             |
|                                  | N    | `<leader>A`                   | Append to Harpoon list                     |
|                                  | N/T  | `<M-a>`                       | Focus the Pi terminal                      |
|                                  | N/T  | `<M-s/d/f>`                   | Jump to Harpoon slots 2 / 3 / 4            |
|                                  | N/T  | `<M-g>`                       | Git fugitive                               |
|                                  | T    | `<M-Esc>`                     | Exit terminal mode                         |
|                                  | Cmd  | `:F` / `:S`                   | Open unified FZF-Lua / Snacks picker       |

