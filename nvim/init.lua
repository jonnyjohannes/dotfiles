local vim = vim
-- pen + paper
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
  { import = 'plugins' },
})

-- KEYMAPS
local fzfLua = require('fzf-lua')
local smartSplits = require('smart-splits')
vim.keymap.set({'n'}, '<A-h>', smartSplits.resize_left)
vim.keymap.set({'n'}, '<A-j>', smartSplits.resize_down)
vim.keymap.set({'n'}, '<A-k>', smartSplits.resize_up)
vim.keymap.set({'n'}, '<A-l>', smartSplits.resize_right)
vim.keymap.set({'n'}, '<C-h>', smartSplits.move_cursor_left)
vim.keymap.set({'n'}, '<C-j>', smartSplits.move_cursor_down)
vim.keymap.set({'n'}, '<C-k>', smartSplits.move_cursor_up)
vim.keymap.set({'n'}, '<C-l>', smartSplits.move_cursor_right)
vim.keymap.set({'n'}, '<leader>{', smartSplits.swap_buf_left)
vim.keymap.set({'n'}, '<leader>}', smartSplits.swap_buf_right)
vim.keymap.set({'n'}, '<leader>:', fzfLua.command_history)
vim.keymap.set({'n'}, '<leader>/', fzfLua.blines)
vim.keymap.set({'n'}, '<leader>f', fzfLua.builtin)
vim.keymap.set({'n'}, '<leader>g', fzfLua.live_grep)
vim.keymap.set({'x'}, '<leader>g', fzfLua.grep_visual)
vim.keymap.set({'n'}, '<leader>s', function()
  fzfLua.combine({ pickers = 'buffers;files', line_query=true })
end)
vim.keymap.set({'n'}, '<leader>t', ':NvimTreeFindFileToggle<cr>')
vim.keymap.set({'n'}, '<leader>dl', ':SlimeSendCurrentLine<cr>')
vim.keymap.set({'x'}, '<leader>dl', ':SlimeSend<cr>')
vim.keymap.set({'n'}, '<leader>dL', ':%SlimeSend<cr>')
vim.keymap.set({'n'}, '<leader>og', ':!gh pr view --web<cr>')
vim.keymap.set({'n'}, '<leader>oG', ':!gh browse<cr>')

