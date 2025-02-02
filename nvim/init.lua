-- basics
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
      branch = 'canary',
      build = 'make tiktoken',
      dependencies = {
        { 'github/copilot.vim' },
        { 'nvim-lua/plenary.nvim' },
      },
      opts = {},
    },
    { 'github/copilot.vim' },
    { 'goolord/alpha-nvim' },
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
    { 'vimpostor/vim-tpipeline' },
})

-- color scheme
require('monokai-pro').setup({
  filter = 'spectrum'
})
vim.cmd('colorscheme monokai-pro')
vim.cmd('hi Visual ctermbg=237 guibg=#4c4c00')

-- fzf
local fzfLua = require('fzf-lua')
fzfLua.setup({
  "borderless_full",
})
vim.keymap.set('n', '<Leader>b', fzfLua.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>f', fzfLua.grep_project, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>t', fzfLua.files, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>x', fzfLua.command_history, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>/', fzfLua.search_history, { noremap = true, silent = true })

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

-- lualine + tpipeline
vim.cmd('let g:tpipeline_autoembed = 0')
vim.cmd('autocmd BufNew * set laststatus=0 showtabline=0 noshowmode noruler noshowcmd')

require('lualine').setup({
  options = {
    theme = 'monokai-pro',
    section_separators = '',
    component_separators = '',
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        'buffers',
        use_mode_colors = true,
        symbols = '',
      }
    },
    lualine_b = {
    },
    lualine_c = {
    },
    lualine_x = {
      'filetype',
    },
    lualine_y = {
      {
        'FugitiveHead',
        icon = '',
      }
    },
    lualine_z = {
      'mode',
    },
  },
  inactive_sections = { },
})

-- alpha
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local header = {
  '    ██╗  ██╗██╗████████╗    ██╗████████╗    ',
  '    ██║  ██║██║╚══██╔══╝    ██║╚══██╔══╝    ',  
  '    ███████║██║   ██║       ██║   ██║       ',  
  '    ██╔══██║██║   ██║       ██║   ██║       ',  
  '    ██║  ██║██║   ██║       ██║   ██║       ',  
  '    ╚═╝  ╚═╝╚═╝   ╚═╝       ╚═╝   ╚═╝       ',  
  '                 ¯\\(°_o)/¯                 ',
}
dashboard.section.header.val = header
dashboard.section.buttons.val = {
    dashboard.button('t', '   > Files', ':lua require("fzf-lua").files()<CR>'),
    dashboard.button('f', '   > Grep', ':lua require("fzf-lua").grep_project()<CR>'),
    dashboard.button('g', '   > Git', ':tab Git<CR>'),
    dashboard.button('e', '   > New file' , ':ene <BAR> startinsert <CR>'),
    dashboard.button('s', '   > Settings' , ':e $MYVIMRC <CR>'),
    dashboard.button('q', '   > Exit', ':qa<CR>'),
}
alpha.setup(dashboard.opts)

-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "java",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "vim",
  },
  highlight = {
    enable = true,
  },
})

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

