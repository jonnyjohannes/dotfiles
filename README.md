# j2de dotfiles

development environment — keyboard-driven, terminal-first

## Prerequisites

- macOS with Homebrew
- [mise](https://mise.jdx.dev/) for runtime management (java, node, python, uv)

## Installation

```zsh

git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles

# XDG — most configs live here
ln -s ~/.dotfiles/ ~/.config

# HOME — these two need explicit symlinks
ln -s ~/.dotfiles/nvim/vimrc ~/.vimrc
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

# System packages
brew bundle --file=~/.dotfiles/brew/Brewfile

```

Local overrides (not tracked): `git/config.local`, `zsh/zsh.local`

## What's Here

| Directory     | Tool                                          |
| ------------- | --------------------------------------------- |
| `alacritty/`  | terminal emulator (SauceCodePro, Catppuccin)  |
| `brew/`       | Brewfile — system packages                    |
| `cursor/`     | Cursor IDE settings (complements nvim for AI) |
| `git/`        | global config + ignore                        |
| `karabiner/`  | caps→ctrl, ctrl-tap→esc, quote-hold→option    |
| `mise/`       | runtime versions (java, node, python, uv)     |
| `nvim/`       | neovim — lazy.nvim plugins, LSP, DAP, AI      |
| `sketchybar/` | macOS status bar                              |
| `skhd/`       | system hotkey daemon                          |
| `starship/`   | shell prompt                                  |
| `tmux/`       | multiplexer (prefix: `<C-Space>`)             |
| `zsh/`        | shell config (vim mode, fzf, mise, starship)  |

## Neovim

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim). Each file in `nvim/lua/plugins/` is a self-contained spec.

Key plugins: nvim-lspconfig + mason (LSP), nvim-dap (debugging), fzf-lua + snacks (pickers), harpoon (file nav), nvim-cmp + copilot (completion), avante (Claude AI), conform (formatting), smart-splits (tmux-aware navigation).

Leader: `<Space>`. See [KEYMAPS.md](KEYMAPS.md) for the full keymap reference.

## Agentic Assets

| Asset       | Description                  |
| ----------- | ---------------------------- |
| `CLAUDE.md` | repo context for Claude Code |
| `.claude/`  | Claude Code local settings   |
