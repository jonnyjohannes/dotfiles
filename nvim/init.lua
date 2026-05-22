local vim = vim

-- pen + paper
vim.cmd.source('~/.config/nvim/vimrc')
vim.opt.winborder = 'single'
require('vim._core.ui2').enable({})

-- plugins
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
  { import = 'plugins' },
})

