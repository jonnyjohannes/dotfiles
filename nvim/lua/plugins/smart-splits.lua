local vim = vim
return {
  {
    'mrjones2014/smart-splits.nvim',
    opts = {
    },
    config = function()
      local smartSplits = require('smart-splits')

      vim.keymap.set({'n', 't', 'x'}, '<C-h>', smartSplits.move_cursor_left)
      vim.keymap.set({'n', 't', 'x'}, '<C-j>', smartSplits.move_cursor_down)
      vim.keymap.set({'n', 't', 'x'}, '<C-k>', smartSplits.move_cursor_up)
      vim.keymap.set({'n', 't', 'x'}, '<C-l>', smartSplits.move_cursor_right)

      vim.keymap.set({'n', 't', 'x'}, '<M-h>', smartSplits.resize_left)
      vim.keymap.set({'n', 't', 'x'}, '<M-j>', smartSplits.resize_down)
      vim.keymap.set({'n', 't', 'x'}, '<M-k>', smartSplits.resize_up)
      vim.keymap.set({'n', 't', 'x'}, '<M-l>', smartSplits.resize_right)

      vim.keymap.set({'n', 't', 'x'}, '<C-M-h>', '<C-w>H')
      vim.keymap.set({'n', 't', 'x'}, '<C-M-j>', '<C-w>J')
      vim.keymap.set({'n', 't', 'x'}, '<C-M-k>', '<C-w>K')
      vim.keymap.set({'n', 't', 'x'}, '<C-M-l>', '<C-w>L')
    end,
  },
}

