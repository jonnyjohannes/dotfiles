-- basics
local vim = vim
vim.cmd.source('~/.config/nvim/vimrc')

-- lazy.nvim
local lazypath = vim.fn.expand('~/.local/share/nvim/lazy/lazy.nvim')
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    { 'CopilotC-Nvim/CopilotChat.nvim',
      build = 'make tiktoken',
      dependencies = {
        { 'github/copilot.vim' },
        { 'nvim-lua/plenary.nvim' },
      },
      opts = {
        mappings = {
          reset = {
            normal = '<C-r>',
            insert = '<C-r>',
          },
        },
        model = 'claude-3.7-sonnet',
      },
    },
    { 'gelguy/wilder.nvim' },
    { 'github/copilot.vim' },
    { 'ibhagwan/fzf-lua' },
    { 'loctvl842/monokai-pro.nvim' },
    { 'mfussenegger/nvim-dap' },
    { 'mfussenegger/nvim-dap-python' },
    { 'mfussenegger/nvim-jdtls' },
    { 'mrjones2014/smart-splits.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'sheerun/vim-polyglot' },
    { 'tpope/vim-fugitive' },
})

-- color scheme
require('monokai-pro').setup({
  filter = 'spectrum',
})
vim.cmd('colorscheme monokai-pro')

-- require('rose-pine').setup({})
-- vim.cmd('colorscheme rose-pine')

-- remaps
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- fzf
local fzfLua = require('fzf-lua')
fzfLua.setup({
  'borderless_full',
})
vim.keymap.set('n', '<Leader>b', fzfLua.buffers)
vim.keymap.set('n', '<Leader>f', fzfLua.grep_project)
vim.keymap.set('n', '<Leader>t', fzfLua.files)
vim.keymap.set('n', '<Leader>x', fzfLua.command_history)
vim.keymap.set('n', '<Leader>/', fzfLua.search_history)

-- lualine
vim.cmd('set laststatus=3')
require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {
      {
        'windows',
        use_mode_colors = true,
        symbols = '',
      }
    },
    lualine_b = {
    },
    lualine_c = {
    },
    lualine_x = {
      'location',
    },
    lualine_y = {
      'filetype',
    },
    lualine_z = {
      'mode',
    },
  },
  inactive_sections = {
  },
})

-- splits
local smartSplits = require('smart-splits')
smartSplits.setup({
})
-- resizing
vim.keymap.set('n', '<A-h>', smartSplits.resize_left)
vim.keymap.set('n', '<A-j>', smartSplits.resize_down)
vim.keymap.set('n', '<A-k>', smartSplits.resize_up)
vim.keymap.set('n', '<A-l>', smartSplits.resize_right)
-- moving between
vim.keymap.set('n', '<C-h>', smartSplits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smartSplits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smartSplits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smartSplits.move_cursor_right)
-- swapping
vim.keymap.set('n', '<leader><leader>h', smartSplits.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', smartSplits.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', smartSplits.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', smartSplits.swap_buf_right)

-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'java',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'vim',
  },
  highlight = {
    enable = true,
  },
})

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({
})

-- wilder
local wilder = require('wilder')
wilder.setup({
  modes = {':', '/', '?'},
  enable_cmdline_enter = 0,
})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    min_width = '100%',
    min_height = '20%',
    max_height = '20%',
    reverse = 0,
  })
))
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      language = 'vim',
      fuzzy = 2,
    }),
    wilder.search_pipeline({
      language = 'vim',
      fuzzy = 2,
    })
  )
})

