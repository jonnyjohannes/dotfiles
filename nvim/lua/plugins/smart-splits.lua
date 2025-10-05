local vim = vim
return {
  {
    'mrjones2014/smart-splits.nvim',
    opts = {
    },
    config = function()
      local smartSplits = require('smart-splits')

      vim.keymap.set({'n', 't'}, '<C-h>', smartSplits.move_cursor_left)
      vim.keymap.set({'n', 't'}, '<C-j>', smartSplits.move_cursor_down)
      vim.keymap.set({'n', 't'}, '<C-k>', smartSplits.move_cursor_up)
      vim.keymap.set({'n', 't'}, '<C-l>', smartSplits.move_cursor_right)

      vim.keymap.set({'n', 't'}, '<M-h>', smartSplits.resize_left)
      vim.keymap.set({'n', 't'}, '<M-j>', smartSplits.resize_down)
      vim.keymap.set({'n', 't'}, '<M-k>', smartSplits.resize_up)
      vim.keymap.set({'n', 't'}, '<M-l>', smartSplits.resize_right)

      vim.keymap.set({'n', 't'}, '<C-M-h>', smartSplits.swap_buf_left)
      vim.keymap.set({'n', 't'}, '<C-M-j>', smartSplits.swap_buf_down)
      vim.keymap.set({'n', 't'}, '<C-M-k>', smartSplits.swap_buf_up)
      vim.keymap.set({'n', 't'}, '<C-M-l>', smartSplits.swap_buf_right)
    end,
  },
}

